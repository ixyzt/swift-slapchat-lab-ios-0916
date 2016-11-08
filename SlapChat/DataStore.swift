//
//  DataStore.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    
    static let sharedInstance = DataStore()
    
    private init() {}
    
    var messages = [Message]()
    
    
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "slapChat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchData() {
        
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Message>(entityName: "Message")
        do {
           self.messages = try managedContext.fetch(fetchRequest)
        } catch {
            
        }
    }
    
    func createNewMessage(message: String, createdAt: NSDate) {
        
        let newMessage = Message(context: context)
        newMessage.content = message
        newMessage.createdAt = createdAt
        
        messages.append(newMessage)
    }
    
    func generateTestData() {
        self.createNewMessage(message: "This is message one", createdAt: NSDate(timeIntervalSince1970: 1478629798))
        self.createNewMessage(message: "This is message two", createdAt: NSDate(timeIntervalSince1970: 1478630798))
        self.createNewMessage(message: "This is message three", createdAt: NSDate(timeIntervalSince1970: 1478631798))
        
        self.saveContext()
        self.fetchData()
    }
    
}
