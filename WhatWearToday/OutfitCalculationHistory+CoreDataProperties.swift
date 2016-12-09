//
//  OutfitCalculationHistory+CoreDataProperties.swift
//  WhatWearToday
//
//  Created by jlcardosa on 09/12/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation
import CoreData


extension OutfitCalculationHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OutfitCalculationHistory> {
        return NSFetchRequest<OutfitCalculationHistory>(entityName: "OutfitCalculationHistory");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var outfits: NSSet?

}

// MARK: Generated accessors for outfits
extension OutfitCalculationHistory {

    @objc(addOutfitsObject:)
    @NSManaged public func addToOutfits(_ value: Outfit)

    @objc(removeOutfitsObject:)
    @NSManaged public func removeFromOutfits(_ value: Outfit)

    @objc(addOutfits:)
    @NSManaged public func addToOutfits(_ values: NSSet)

    @objc(removeOutfits:)
    @NSManaged public func removeFromOutfits(_ values: NSSet)

}
