//
//  OutfitRepository.swift
//  WhatWearToday
//
//  Created by jlcardosa on 10/12/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation
import CoreData

class BaseRepository {
	
	var managedContext : NSManagedObjectContext!
	var fetchRequest : NSFetchRequest<NSFetchRequestResult>
	
	init(entityName: String) {
		self.managedContext = CoreDataManager.getManagedObjectContext()
		self.fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
		self.fetchRequest.sortDescriptors = []
	}
	
	func fetch() throws -> [NSManagedObject] {
		do {
			let results =
				try self.managedContext.fetch(self.fetchRequest)
			return results as! [NSManagedObject]
		} catch let error as NSError {
			throw error
		}
	}
	
	func setOffset(offset: Int) {
		self.fetchRequest.fetchOffset = offset
	}
	
	func setLimit(limit : Int) {
		self.fetchRequest.fetchLimit = limit
	}
	
	func orderBy(key: String, ascending: Bool) {
		self.fetchRequest.sortDescriptors?.append(NSSortDescriptor(key: key, ascending: ascending))
	}
	
	func delete(outfit: NSManagedObject) {
		self.managedContext.delete(outfit)
	}
}
