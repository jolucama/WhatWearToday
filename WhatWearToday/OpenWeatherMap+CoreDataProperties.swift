//
//  OpenWeatherMap+CoreDataProperties.swift
//  WhatWearToday
//
//  Created by jlcardosa on 10/12/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation
import CoreData


extension OpenWeatherMap {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OpenWeatherMap> {
        return NSFetchRequest<OpenWeatherMap>(entityName: "OpenWeatherMap");
    }

    @NSManaged public var content: Dictionary<String, Any>?
    @NSManaged public var requestAt: NSDate?

}
