//
//  OutfitManagedObject.swift
//  WhatWearToday
//
//  Created by jlcardosa on 10/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit
import CoreData

class OutfitManagedObject: NSManagedObject {

    static let entityName = "Outfit"
    static let titleAttrKey = "title"
    static let typeAttrKey = "type"
    static let colorAttrKey = "color"
    static let seasonAttrKey = "season"
    static let descriptionAttrKey = "pieceDescription"
    
    var outfit: Outfit!
    
    func persist(object: Outfit!) {
        self.setValue(outfit.title, forKey: OutfitManagedObject.titleAttrKey);
        self.setValue(outfit.type, forKey: OutfitManagedObject.typeAttrKey);
        self.setValue(outfit.color, forKey: OutfitManagedObject.colorAttrKey);
        self.setValue(outfit.season, forKey: OutfitManagedObject.seasonAttrKey);
        self.setValue(outfit.pieceDescription, forKey: OutfitManagedObject.descriptionAttrKey);
    }
}
