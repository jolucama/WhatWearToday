//
//  CoreDataManager.swift
//  WhatWearToday
//
//  Created by jlcardosa on 11/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {

    //var managedObjectContext : NSManagedObjectContext!
    
    static func getManagedObjectContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.managedObjectContext
    }
    
}
