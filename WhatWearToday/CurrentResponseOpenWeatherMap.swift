//
//  ResponseOpenWeatherMap.swift
//  WhatWearToday
//
//  Created by jlcardosa on 17/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation


public class CurrentResponseOpenWeatherMap : ResponseOpenWeatherMap, ResponseOpenWeatherMapProtocol {
    
    public func getTemperature() -> Float? {
        
        return self.rawData["main"]?["temp"] as? Float
    }
    
    public func getPressure() -> Float? {
        
        return self.rawData["main"]?["pressure"] as? Float
    }
    
    public func getHumidity() -> Float? {
        
        return self.rawData["main"]?["humidity"] as? Float
    }
    
    public func getTempMax() -> Float? {
        
        return self.rawData["main"]?["temp_max"] as? Float
    }
    
    public func getTempMin() -> Float? {
        
        return self.rawData["main"]?["temp_min"] as? Float
    }
    
    public func getCityName() -> String? {
        
        return self.rawData["name"] as? String
    }
    
    public func getDescription() -> String? {
        
        return self.rawData["weather"]?["description"] as? String
    }
    
    public func getWindSpeed() -> String? {
        
        return self.rawData["wind"]?["speed"] as? String
    }
}
