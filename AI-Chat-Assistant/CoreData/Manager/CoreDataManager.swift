//
//  CoreDataManager.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 18.09.2023.
//

import Foundation

import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager(modelName: "ChatAssistantDataModel")
    
    //MARK: - Refenreces
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    //MARK: - Init
    init(modelName: String) {
        self.persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    //MARK: - Methods
    // Load the persistent store asynchronously
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                print("Hata oluştu: \(error), \(error.userInfo)")
            } else {
                completion?()
                print("Başarılı Core Data yüklemesi.")
            }
        }
    }
    
    // Save the view context asynchronously
    func saveContext(completion: ((Bool) -> Void)? = nil) {
        let context = viewContext
        if context.hasChanges {
            context.perform {
                do {
                    try context.save()
                    completion?(true)
                } catch {
                    print("Hata: \(error.localizedDescription)")
                    completion?(false)
                }
            }
        } else {
            completion?(true)
        }
    }
    
    // Delete an object from the context and save
    func delete(object: NSManagedObject, completion: ((Bool) -> Void)? = nil) {
        let context = viewContext
        context.perform { [weak self] in
            guard let self else { return }
            context.delete(object)
            self.saveContext(completion: completion)
        }
    }
}



