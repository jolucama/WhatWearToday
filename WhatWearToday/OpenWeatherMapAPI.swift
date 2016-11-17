//
//  WeatherAPIProtocol.swift
//  WhatWearToday
//
//  Created by jlcardosa on 14/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit

public class OpenWeatherMapAPI {
    
    var parameters = [String:String]()
    var type : OpenWeatherMapType
    var formatType : Format = Format.Json
    weak var delegate : WeatherAPIDelegate?
    
    
    /// Creates a new instance with the API key and the type
    ///
    /// - Parameter apiKey: The API key that is given here: https://home.openweathermap.org/api_keys
    /// - Parameter type  : The type of the call, by default will be the Current weather, see OpenWeatherMapType
    ///                     for more information about the possibles options
    init (apiKey : String!, type : OpenWeatherMapType = OpenWeatherMapType.Current) {
        self.parameters[RequestParametersKey.apiKey.rawValue] = apiKey
        self.type = type
    }
    
    public func currentWeather(byCityName cityName : String) {
        self.parameters[RequestParametersKey.cityName.rawValue] = cityName
        let request = RequestOpenWeatherMap(withType: self.type, andParameters: self.parameters)
        request.request(onCompletion: { (data : Data?, response, error) in
            
            if error == nil {
                var responseOWM : ResponseOpenWeatherMapProtocol
                switch self.type {
                    case OpenWeatherMapType.Current:
                        let responseOWM = CurrentResponseOpenWeatherMap(data: data!, type: self.formatType)
                    case OpenWeatherMapType.Forecast:
                        let responseOWM = ForecastResponseOpenWeatherMap(data: data!, type: self.formatType, date : Date())
                }
            }
            
            self.delegate?.didFinishRequest(withType: OpenWeatherMapType.Current, response: responseOWM)
        })
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
        self.formatType = format
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
