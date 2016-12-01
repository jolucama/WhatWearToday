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

	let managedContext : NSManagedObjectContext!
	let fetchRequest : NSFetchRequest<NSFetchRequestResult>
	
	init() {
		self.managedContext = CoreDataManager.getManagedObjectContext()
		self.fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Outfit.entityName)
	}
	
	func fetchAll() throws -> [Outfit] {
		return try self.returnValuesFromFetchRequest()
	}
	
    func fetch(bySeason season: Outfit.Season) throws -> [Outfit] {
        self.fetchRequest.predicate = NSPredicate(format: "season == %d", season.rawValue)
		return try self.returnValuesFromFetchRequest()
    }
	
	private func returnValuesFromFetchRequest() throws -> [Outfit] {
		do {
			let results =
				try self.managedContext.fetch(fetchRequest)
			return results as! [Outfit]
		} catch let error as NSError {
			throw error
		}
	}
}
