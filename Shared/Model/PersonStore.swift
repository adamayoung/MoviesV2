//
//  PersonStore.swift
//  Movies
//
//  Created by Adam Young on 17/09/2020.
//

import CoreData
import Combine
import Foundation

final class PersonStore: NSObject, ObservableObject {

    private static let topLimit = 10

    var trending: [Person] {
        trendingIDs.compactMap { people[$0] }
    }

    var topTrending: [Person] {
        Array(trendingIDs.prefix(Self.topLimit))
            .compactMap { people[$0] }
    }

    var favourites: [Person] {
        favouriteIDs.compactMap { people[$0] }
    }

    var topFavourites: [Person] {
        Array(favouriteIDs.prefix(Self.topLimit))
            .compactMap { people[$0] }
    }

    private let peopleManager: PeopleManager
    private let persistentContainer: NSPersistentContainer

    @Published private var people: [Person.ID: Person] = [:]
    @Published private var trendingIDs: [Person.ID] = []
    @Published private var favouriteIDs: [Person.ID] = []
    @Published private var credits: [Person.ID: PersonCombinedCredits] = [:]
    @Published private var showsKnownFor: [Person.ID: [Show]] = [:]

    private var cancellables = Set<AnyCancellable>()
    private var isFetchingTrending = false
    private var currentTrendingPage = 0
    private var isMoreTrendingAvailable = true

    init(peopleManager: PeopleManager = TMDbPeopleManager(),
         persistentContainer: NSPersistentContainer = PersistenceController.shared.container) {
        self.peopleManager = peopleManager
        self.persistentContainer = persistentContainer
        super.init()

        loadFavourites()
        NotificationCenter.default
            .addObserver(self, selector: #selector(loadFavourites),
                         name: NSNotification.Name(rawValue: "NSPersistentStoreRemoteChangeNotification"),
                         object: self.persistentContainer.persistentStoreCoordinator
        )
    }

    func person(withID id: Person.ID) -> Person? {
        people[id]
    }

    func credits(forPerson personID: Person.ID) -> PersonCombinedCredits? {
        credits[personID]
    }

    func showsKnownFor(forPerson personID: Person.ID) -> [Show]? {
        showsKnownFor[personID]
    }

    func isFavourite(personID: Person.ID) -> Bool {
        favouriteIDs.contains(personID)
    }

}

extension PersonStore {

    func fetchTrending(completionHandler: ((Error?) -> Void)? = nil) {
        guard !isFetchingTrending, isMoreTrendingAvailable else {
            completionHandler?(nil)
            return
        }

        isFetchingTrending = true
        currentTrendingPage += 1

        return peopleManager.fetchTrending(page: currentTrendingPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isFetchingTrending = false

                switch completion {
                case .finished:
                    completionHandler?(nil)

                case .failure(let error):
                    completionHandler?(error)
                }
            }, receiveValue: { [weak self] people in
                guard !people.isEmpty else {
                    self?.isMoreTrendingAvailable = false
                    return
                }

                self?.appendTrending(people: people)
            })
            .store(in: &cancellables)
    }

    func fetchNextTrendingIfNeeded(currentPerson: Person, offset: Int, completionHandler: ((Error?) -> Void)? = nil) {
        let index = trendingIDs.firstIndex(where: { $0 == currentPerson.id })
        let thresholdIndex = trendingIDs.index(trendingIDs.endIndex, offsetBy: -offset)
        guard index == thresholdIndex else {
            completionHandler?(nil)
            return
        }

        fetchTrending(completionHandler: completionHandler)
    }

    func fetchPerson(withID id: Person.ID, completionHandler: ((Error?) -> Void)? = nil) {
        peopleManager.fetchPerson(withID: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    completionHandler?(nil)

                case .failure(let error):
                    completionHandler?(error)
                }
            }, receiveValue: { [weak self] person in
                guard let person = person else {
                    return
                }

                self?.people[person.id] = person
            })
            .store(in: &cancellables)
    }

    func fetchShowsKnownFor(forPerson personID: Person.ID, completionHandler: ((Error?) -> Void)? = nil) {
        guard showsKnownFor[personID] == nil else {
            completionHandler?(nil)
            return
        }

        peopleManager.fetchKnownFor(forPerson: personID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    completionHandler?(nil)

                case .failure(let error):
                    completionHandler?(error)
                }
            }, receiveValue: { [weak self] shows in
                self?.showsKnownFor[personID] = shows
            })
            .store(in: &cancellables)
    }

    func fetchCredits(personID: Person.ID, completionHandler: ((Error?) -> Void)? = nil) {
        guard credits[personID] == nil else {
            completionHandler?(nil)
            return
        }

        peopleManager.fetchCredits(forPerson: personID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    completionHandler?(nil)

                case .failure(let error):
                    completionHandler?(error)
                }
            }, receiveValue: { [weak self] credits in
                self?.credits[personID] = credits
            })
            .store(in: &cancellables)
    }

    func toggleFavourite(person: Person) {
        defer {
            try? persistentContainer.viewContext.save()
        }

        let request: NSFetchRequest<FavouritePerson> = NSFetchRequest(entityName: "FavouritePerson")
        request.predicate = NSPredicate(format: "personID = %d", person.id)
        request.fetchBatchSize = 1
        let results = (try? persistentContainer.viewContext.fetch(request)) ?? []

        if let favouritePerson = results.first {
            persistentContainer.viewContext.delete(favouritePerson)
            return
        }

        let _ = FavouritePerson(context: persistentContainer.viewContext, person: person)
    }

}

extension PersonStore {

    private func appendTrending(people: [Person]) {
        var trendingIDs = self.trendingIDs
        people.forEach {
            if self.people[$0.id] == nil {
                self.people[$0.id] = $0
            }

            if !trendingIDs.contains($0.id) {
                trendingIDs.append($0.id)
            }
        }
        self.trendingIDs = trendingIDs
    }

    @objc private func loadFavourites() {
        persistentContainer.viewContext.perform { [weak self] in
            guard let self = self else {
                return
            }

            let fetchRequest = NSFetchRequest<FavouritePerson>(entityName: "FavouritePerson")
            let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            let favouritePeople = (try? self.persistentContainer.viewContext.fetch(fetchRequest)) ?? []

            let people = favouritePeople.compactMap(Person.init)
            people.forEach {
                if self.people[$0.id] == nil {
                    self.people[$0.id] = $0
                }
            }

            self.favouriteIDs = people.map(\.id)
        }
    }

}
