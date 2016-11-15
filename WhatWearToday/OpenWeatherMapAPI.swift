//
//  WeatherAPIProtocol.swift
//  WhatWearToday
//
//  Created by jlcardosa on 14/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit

public class OpenWeatherMapAPI : WeatherAPIProtocol {
    
    enum OpenWeatherMapType : String {
        
        case Current = "weather"
        
        case Forecast = "forecast"
    }
    
    var parameters = [String:String]()

    init (apiKey : String!) {
        self.parameters[RequestParametersKey.apiKey.rawValue] = apiKey
    }
    
    public func currentWeather(byCityName cityName : String, onCompletion : @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        self.parameters[RequestParametersKey.cityName.rawValue] = cityName
        let request = RequestOpenWeatherMap(withType: OpenWeatherMapType.Current.rawValue, andParameters: self.parameters)
        request.request(onCompletion: onCompletion)
    }
    
    /*
    public func currentWeather(byCityName cityName : String, andCountryCode countryCode : String) -> FormatReturn! {
        self.parameters[RequestParametersKey.cityName.rawValue] = cityName + "," + countryCode
    }
    
    
    
    public func forecastWeather() -> FormatReturn! {
        //To Implement
    }
 
    */
    
    public func setFormat(format : Format) {
        self.parameters[RequestParametersKey.format.rawValue] = format.rawValue
    }
    
    public func setSearchAccuracy(searchAccuracy : SearchAccuracyType) {
        self.parameters[RequestParametersKey.searchAccuracy.rawValue] = searchAccuracy.rawValue
    }
    
    public func setLimitationOfResult(in limitation : Int) {
        self.parameters[RequestParametersKey.limit.rawValue] = String(limitation)
    }
    
    public func setTemperatureUnit(unit : TemperatureFormat) {
        self.parameters[RequestParametersKey.units.rawValue] = unit.rawValue
    }
    
    public func setMultilingualSupport(language : Language) {
        self.parameters[RequestParametersKey.language.rawValue] = language.rawValue
    }
}
