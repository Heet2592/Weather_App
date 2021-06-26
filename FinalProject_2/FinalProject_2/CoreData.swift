//
//  CoreData.swift
//  FinalProject_2
//
//  Created by user182505 on 12/11/20.
//  Copyright © 2020 user182505. All rights reserved.
//

import Foundation
import CoreData

class CoreData{
    
    static var shared = CoreData()
    
    func insertCity(city : String,country:String) {
        
        let c = CitiesStorage(context: persistentContainer.viewContext)
        c.cityName = city
        c.countryName = country
        saveContext()
    }

    func deleteCity(city : CitiesStorage)  {
        persistentContainer.viewContext.delete(city)
        saveContext()
    }
    
    

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
    
    func search(text : String) -> [CitiesStorage] {

        let fetch : NSFetchRequest =  CitiesStorage.fetchRequest()
            let predicate = NSPredicate(format: "cityName BEGINSWITH [c] %@", text)
            fetch.predicate = predicate
            var result : [CitiesStorage] = [CitiesStorage]()
                   do{
                       result = try (persistentContainer.viewContext.fetch(fetch) as? [CitiesStorage])!
                   }catch{
                   }
            return result
    }
    
     lazy var  fetchResultsController : NSFetchedResultsController<CitiesStorage> = {
    
    let fetchData : NSFetchRequest<CitiesStorage> = CitiesStorage.fetchRequest()
    fetchData.sortDescriptors = [NSSortDescriptor(key: "cityName", ascending:false)]
    let fetchController = NSFetchedResultsController(fetchRequest: fetchData, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: "cityName", cacheName: nil)
    
    return fetchController
    }()
    
    func fetchCityFromCoreData() -> [CitiesStorage]{
        let fetch : NSFetchRequest =  CitiesStorage.fetchRequest()
        fetch.sortDescriptors = [NSSortDescriptor.init(key: "cityName", ascending: true)]
        
        var result : [CitiesStorage] = [CitiesStorage]()
        do{
            result = try (persistentContainer.viewContext.fetch(fetch) as? [CitiesStorage])!
        
        }catch{
        }
        return result
    }

     lazy var persistentContainer: NSPersistentContainer = {
   
         let container = NSPersistentContainer(name: "FinalProject_2")
         container.loadPersistentStores(completionHandler: { (storeDescription, error) in
             if let error = error as NSError? {
          
                 fatalError("Unresolved error \(error), \(error.userInfo)")
             }
         })
         return container
     }()



}

