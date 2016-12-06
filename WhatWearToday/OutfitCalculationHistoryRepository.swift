//
//  OutfitRepository.swift
//  WhatWearToday
//
//  Created by jlcardosa on 23/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation
import CoreData

class OutfitCalculationHistoryRepository {
	
	let managedContext : NSManagedObjectContext!
	let fetchRequest : NSFetchRequest<NSFetchRequestResult>
	
	init() {
		self.managedContext = CoreDataManager.getManagedObjectContext()
		self.fetchRequest = OutfitCalculationHistory.fetchRequest()
		self.fetchRequest.sortDescriptors = []
	}
	
	func fetch() throws -> [OutfitCalculationHistory] {
		do {
			let results =
				try self.managedContext.fetch(fetchRequest)
			return results as! [OutfitCalculationHistory]
		} catch let error as NSError {
			throw error
		}
	}
	
	func setLimit(limit : Int) {
		self.fetchRequest.fetchLimit = limit
	}
	
	func orderBy(key: String, ascending: Bool) {
		self.fetchRequest.sortDescriptors?.append(NSSortDescriptor(key: key, ascending: ascending))
	}
	
	func delete(outfit : OutfitCalculationHistory) {
		self.managedContext.delete(outfit)
	}
}
