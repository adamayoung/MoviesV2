//
//  Persistence.swift
//  Movies
//
//  Created by Adam Young on 17/09/2020.
//

import CoreData

struct PersistenceController {

    private static let defaultContainerIdentifier = "iCloud.uk.co.adam-young.Movies"
    #if os(watchOS)
    private static let transactionAuthorName = "watchOSApp"
    #else
    private static let transactionAuthorName = "iOSApp"
    #endif

    static let shared = PersistenceController()

    //    static var preview: PersistenceController = {
    //        let result = PersistenceController(inMemory: true)
    //        let viewContext = result.container.viewContext
    //        for _ in 0..<10 {
    //            let newItem = Item(context: viewContext)
    //            newItem.timestamp = Date()
    //        }
    //        do {
    //            try viewContext.save()
    //        } catch {
    //            // Replace this implementation with code to handle the error appropriately.
    //            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    //            let nsError = error as NSError
    //            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    //        }
    //        return result
    //    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Movies")
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("No Descriptions found")
        }

        if inMemory {
            description.url = URL(fileURLWithPath: "/dev/null")
        }

        description.cloudKitContainerOptions
            = NSPersistentCloudKitContainerOptions(containerIdentifier: Self.defaultContainerIdentifier)
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true
        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        description.setOption(true as NSObject, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                print("Error loading store: \(error), \(error.userInfo)")
            }
        }

        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
