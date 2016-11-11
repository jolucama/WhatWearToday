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
    let titleAttrKey = "title"
    let typeAttrKey = "type"
    let colorAttrKey = "color"
    let seasonAttrKey = "season"
    let descriptionAttrKey = "pieceDescription"
    
    var outfit: Outfit!
    
    func persist(object: Outfit!) {
        self.setValue(outfit.title, forKey: self.titleAttrKey);
        self.setValue(outfit.type, forKey: self.typeAttrKey);
        self.setValue(outfit.color, forKey: self.colorAttrKey);
        self.setValue(outfit.season, forKey: self.seasonAttrKey);
        self.setValue(outfit.pieceDescription, forKey: self.descriptionAttrKey);
    }
}
