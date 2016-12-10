//
//  Outfit+CoreDataProperties.swift
//  WhatWearToday
//
//  Created by jlcardosa on 10/12/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation
import CoreData


extension Outfit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Outfit> {
        return NSFetchRequest<Outfit>(entityName: "Outfit");
    }

    @NSManaged public var color: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var pieceDescription: String?
    @NSManaged public var season: Int16
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var typePart: Int16
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var calculationHistories: NSSet?

}

// MARK: Generated accessors for calculationHistories
extension Outfit {

    @objc(addCalculationHistoriesObject:)
    @NSManaged public func addToCalculationHistories(_ value: OutfitCalculationHistory)

    @objc(removeCalculationHistoriesObject:)
    @NSManaged public func removeFromCalculationHistories(_ value: OutfitCalculationHistory)

    @objc(addCalculationHistories:)
    @NSManaged public func addToCalculationHistories(_ values: NSSet)

    @objc(removeCalculationHistories:)
    @NSManaged public func removeFromCalculationHistories(_ values: NSSet)

}
