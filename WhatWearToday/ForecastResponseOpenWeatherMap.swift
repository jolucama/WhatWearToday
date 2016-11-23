//
//  ResponseOpenWeatherMap.swift
//  WhatWearToday
//
//  Created by jlcardosa on 17/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation


public class ForecastResponseOpenWeatherMap : ResponseOpenWeatherMap, ResponseOpenWeatherMapProtocol {
    
    var forecastList = Array<Dictionary<String, AnyObject>>()
    var currentListElement : Dictionary<String, AnyObject>?
    var pickedDate : Date!
    
    init(data : Data, type : Format, date : Date) {
        super.init(data: data, type: type)
        self.pickedDate = date
        self.forecastList = (self.rawData["list"] as? Array<Dictionary<String, AnyObject>>)!
        self.getCurrentListElementDependingOnTheDate()
    }
    
    public func getTemperature() -> Float? {
        
        return self.currentListElement?["main"]?["temp"] as? Float
    }
    
    public func getPressure() -> Float? {
        
        return self.currentListElement?["main"]?["pressure"] as? Float
    }
    
    public func getHumidity() -> Float? {
        
        return self.currentListElement?["main"]?["humidity"] as? Float
    }
    
    public func getTempMax() -> Float? {
        
        return self.currentListElement?["main"]?["temp_max"] as? Float
    }
    
    public func getTempMin() -> Float? {
        
        return self.currentListElement?["main"]?["temp_min"] as? Float
    }
    
    public func getCityName() -> String? {
        let city = self.rawData["city"] as? Dictionary<String, Any>
        
        return city?["name"] as? String
    }
    
    public func getDescription() -> String? {
        let weather = self.currentListElement?["weather"] as? Array<Dictionary<String, Any>>
        let firstElement = weather?.first
        
        return firstElement?["description"] as? String
    }
    
    public func getWindSpeed() -> String? {
        
        return self.currentListElement?["wind"]?["speed"] as? String
    }
    
    public func getDateTime() -> Date? {
        return Date(timeIntervalSince1970: self.currentListElement?["dt"] as! TimeInterval)
    }
    
    public func getError() -> Error? {
        return self.error;
    }
    
    private func getCurrentListElementDependingOnTheDate() {
        let unixDate = Int(self.pickedDate.timeIntervalSince1970)
        self.currentListElement = self.forecastList.first
        for elementList in self.forecastList {
            let elementListDate = elementList["dt"] as! Int
            if (unixDate < elementListDate) {
                self.currentListElement = elementList
                break
            }
        }
    }
}
