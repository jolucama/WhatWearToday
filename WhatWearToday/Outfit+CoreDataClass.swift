//
//  Outfit+CoreDataClass.swift
//  WhatWearToday
//
//  Created by jlcardosa on 13/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation
import CoreData

@objc(Outfit)
public class Outfit: NSManagedObject {
    
    static let entityName = "Outfit"

    enum Season : Int {
    
        case SpringAutumn = 0
        
        case Summer = 1
        
        case Winter = 2
    }
    
    func fetchRequest(bySeason season : Season) -> NSFetchRequest<Outfit> {
        let fetchRequest = NSFetchRequest<Outfit>(entityName: Outfit.entityName)
        fetchRequest.predicate = NSPredicate(format: "season == %d", season.rawValue)
    }
}
