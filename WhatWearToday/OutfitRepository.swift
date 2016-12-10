//
//  OutfitRepository.swift
//  WhatWearToday
//
//  Created by jlcardosa on 23/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation
import CoreData

class OutfitRepository : BaseRepository {
	
	init() {
		super.init(entityName: Outfit.entityName)
	}
	
	func fetchByDescendingDate() throws -> [Outfit] {
		self.orderBy(key: "createdAt", ascending: false)
		return try self.fetch() as! [Outfit]
	}
	
	func fetch(bySeason season: Outfit.Season) throws -> [Outfit] {
		self.fetchRequest.predicate = NSPredicate(format: "season == %d", season.rawValue)
		return try self.fetch() as! [Outfit]
	}
}
