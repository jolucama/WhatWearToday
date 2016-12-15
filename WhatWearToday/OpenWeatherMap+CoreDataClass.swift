//
//  OpenWeatherMap+CoreDataClass.swift
//  WhatWearToday
//
//  Created by jlcardosa on 10/12/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(OpenWeatherMap)
public class OpenWeatherMap: NSManagedObject {
	
	
	static func getLastRequestStored() -> OpenWeatherMap? {
		
		let fetchRequest = NSFetchRequest<OpenWeatherMap>(entityName: "OpenWeatherMap");
		fetchRequest.sortDescriptors?.append(NSSortDescriptor(key: "date", ascending: false))
		fetchRequest.fetchLimit = 1
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		let managedObjectContext = appDelegate.managedObjectContext
		do {
			let results = try managedObjectContext.fetch(fetchRequest)
			if results.count > 0 {
				return results[0] as OpenWeatherMap?
			} else {
				return nil
			}
		} catch let error as NSError {
			NSLog("Error in OpenWeatherMap:getLastRequestStored. %@", error)
			return nil
		}
	}
	
	func needToRequestAgain(forTimeInterval time: Int) -> Bool {
		return Calendar.current.dateComponents([.second], from: self.requestAt! as Date, to: Date()).second! > time;
	}
	
}
