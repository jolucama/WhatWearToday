//
//  OutfitRepository.swift
//  WhatWearToday
//
//  Created by jlcardosa on 23/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation
import CoreData

class OutfitRepository {

    let managedContext = CoreDataManager.getManagedObjectContext()
    
    func fetch(bySeason season: Outfit.Season) -> [Outfit] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Outfit.entityName)
        fetchRequest.predicate = NSPredicate(format: "season == %d", season.rawValue)
        do {
            let results =
                try self.managedContext.fetch(fetchRequest)
            return results as! [Outfit]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            return [Outfit]()
        }
    }
}
