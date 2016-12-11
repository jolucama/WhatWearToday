//
//  ResponseOpenWeatherMapProtocol.swift
//  WhatWearToday
//
//  Created by jlcardosa on 17/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation


public class ResponseOpenWeatherMap {
    
    var rawData : Dictionary<String, Any>!
    var error : Error?
    
    init(data : Data) {
        do {
			try self.rawData = JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves) as! Dictionary<String, AnyObject>
        } catch let error as NSError {
            NSLog("%@", error)
        }
    }
    
    init(withError error: Error) {
        self.error = error
        self.rawData = ["":""]
    }
}
