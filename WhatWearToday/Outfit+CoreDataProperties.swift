//
//  Outfit+CoreDataProperties.swift
//  WhatWearToday
//
//  Created by jlcardosa on 13/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation
import CoreData


extension Outfit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Outfit> {
        return NSFetchRequest<Outfit>(entityName: "Outfit");
    }

    @NSManaged public var color: String?
    @NSManaged public var pieceDescription: String?
    @NSManaged public var season: String?
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var photo: NSData?

}