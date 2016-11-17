//
//  ResponseOpenWeatherMapProtocol.swift
//  WhatWearToday
//
//  Created by jlcardosa on 17/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation


public class ResponseOpenWeatherMap {
    
    var rawData : Dictionary<String, AnyObject>!
    
    init(data : Data, type : Format) {
        
        do {
            try self.rawData = JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves) as! Dictionary<String, AnyObject>
            
            print(self.rawData)
        } catch {
            
        }
    }
    
}

