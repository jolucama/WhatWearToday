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
        let main = self.rawData["main"] as? Dictionary<String, Float>
        return main?["temp"]
    }
    
    public func getPressure() -> Float? {
        let main = self.rawData["main"] as? Dictionary<String, Any>
        return main?["pressure"] as? Float
    }
    
    public func getHumidity() -> Float? {
        let main = self.rawData["main"] as? Dictionary<String, Any>
        return main?["humidity"] as? Float
    }
    
    public func getTempMax() -> Float? {
        let main = self.rawData["main"] as? Dictionary<String, Any>
        return main?["temp_max"] as? Float
    }
    
    public func getTempMin() -> Float? {
        let main = self.rawData["main"] as? Dictionary<String, Any>
        return main?["temp_min"] as? Float
    }
    
    public func getCityName() -> String? {
        
        return self.rawData["name"] as? String
    }
    
    public func getDescription() -> String? {
        let weather = self.rawData["weather"] as? Dictionary<String, Any>
        return weather?["description"] as? String
    }
    
    public func getWindSpeed() -> String? {
        let wind = self.rawData["wind"] as? Dictionary<String, Any>
        return wind?["speed"] as? String
    }
}
