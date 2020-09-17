//
//  PersonDetailsView.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct PersonDetailsView: View {

    var id: Person.ID

    @EnvironmentObject private var personStore: PersonStore

    private var person: Person? {
        personStore.person(withID: id)
    }

    private var isFavourite: Bool {
        guard let person = person else {
            return false
        }

        return personStore.isFavourite(personID: person.id)
    }

    private var popularShows: [Show]? {
        personStore.showsKnownFor(forPerson: id)
    }

    private var title: String {
        person?.name ?? ""
    }

    var body: some View {
        container
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    if person != nil {
                        Button(action: {
                            toogleFavourite()
                        }, label: {
                            favouriteButtonLabel
                        })
                    }
                }
            }
            .onAppear(perform: fetch)
            .navigationTitle(title)
    }

    @ViewBuilder private var container: some View {
        #if os(iOS)
        content
            .navigationBarTitleDisplayMode(.inline)
        #elseif os(macOS)
        content
            .frame(minWidth: 500, idealWidth: 700, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        #else
        content
        #endif
    }

    @ViewBuilder private var content: some View {
        if let person = self.person, let popularShows = self.popularShows {
            PersonDetails(person: person, popularShows: popularShows)
                .transition(AnyTransition.opacity.animation(Animation.easeOut.speed(0.5)))
        } else {
            ProgressView()
        }
    }

    private var favouriteButtonLabel: some View {
        let imageName = isFavourite ? "heart.fill" : "heart"

        #if !os(watchOS)
        return Image(systemName: imageName)
        #else
        let title = isFavourite ? "Remove Favourite" : "Add Favourite"
        return Label(title, systemImage: imageName)
        #endif
    }

    private func toogleFavourite() {
        guard let person = person else {
            return
        }

        personStore.toggleFavourite(person: person)
    }

}

extension PersonDetailsView {

    private func fetch() {
        personStore.fetchPerson(withID: id)
        personStore.fetchShowsKnownFor(forPerson: id)
    }

}

struct PersonDetailsView_Previews: PreviewProvider {

    static var previews: some View {
        PersonDetailsView(id: 5)
    }

}
