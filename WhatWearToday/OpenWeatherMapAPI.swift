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
    var formatType : Format = Format.Json
    var forecastDate : Date?
    weak var delegate : WeatherAPIDelegate?
    
    
    /// Creates a new instance with the API key and the type
    ///
    /// - Parameter apiKey: The API key that is given here: https://home.openweathermap.org/api_keys
    /// - Parameter type  : The type of the call, by default will be the Current weather, see OpenWeatherMapType
    ///                     for more information about the possibles options
    init (apiKey : String!) {
        self.parameters[RequestParametersKey.apiKey.rawValue] = apiKey
    }
    
    
    /// --- Methods for the current weather
    
    
    public func currentWeather(byCityName cityName : String) {
        self.parameters[RequestParametersKey.cityName.rawValue] = cityName
        self.performCurrentWeatherRequest()
    }
    
    public func currentWeather(byCityName cityName : String, andCountryCode countryCode: String) {
        self.parameters[RequestParametersKey.cityName.rawValue] = cityName + "," + countryCode
        self.performCurrentWeatherRequest()
    }
    
    public func currentWeather(byCityId cityId : Int) {
        self.parameters[RequestParametersKey.cityID.rawValue] = String(cityId)
        self.performCurrentWeatherRequest()
    }
    
    public func currentWeather(byLatitud latitude : Int, andLongitude longitude : Int) {
        self.parameters[RequestParametersKey.latitude.rawValue] = String(latitude)
        self.parameters[RequestParametersKey.longitude.rawValue] = String(longitude)
        self.performCurrentWeatherRequest()
    }
    
    public func currentWeather(byZipCode zipcode : String, andCountryCode countryCode : String) {
        self.parameters[RequestParametersKey.zipCode.rawValue] = zipcode + "," + countryCode
        self.performCurrentWeatherRequest()
    }
    
    private func performCurrentWeatherRequest() {
        let request = RequestOpenWeatherMap(withType: OpenWeatherMapType.Current, andParameters: self.parameters)
        request.request(onCompletion: { (data : Data?, response, error) in
            var responseOWM : ResponseOpenWeatherMapProtocol!
            if error == nil {
                responseOWM = CurrentResponseOpenWeatherMap(data: data!, type: self.formatType)
            }
            
            self.delegate?.didFinishRequest(withType: OpenWeatherMapType.Current, response: responseOWM)
        })
    }
    
    /// --- Methods for the forecast weather
    
    public func forecastWeather(byCityName cityName : String, andDate date : Date) {
        self.parameters[RequestParametersKey.cityName.rawValue] = cityName
        self.forecastDate = date
        self.performCurrentWeatherRequest()
    }
    
    public func forecastWeather(byCityName cityName : String, andCountryCode countryCode: String, andDate date : Date) {
        self.parameters[RequestParametersKey.cityName.rawValue] = cityName + "," + countryCode
        self.forecastDate = date
        self.performCurrentWeatherRequest()
    }
    
    public func forecastWeather(byCityId cityId : Int, andDate date : Date) {
        self.parameters[RequestParametersKey.cityID.rawValue] = String(cityId)
        self.forecastDate = date
        self.performCurrentWeatherRequest()
    }
    
    public func forecastWeather(byLatitud latitude : Int, andLongitude longitude : Int, andDate date : Date) {
        self.parameters[RequestParametersKey.latitude.rawValue] = String(latitude)
        self.parameters[RequestParametersKey.longitude.rawValue] = String(longitude)
        self.forecastDate = date
        self.performCurrentWeatherRequest()
    }
    
    public func forecastWeather(byZipCode zipcode : String, andCountryCode countryCode : String, andDate date : Date) {
        self.parameters[RequestParametersKey.zipCode.rawValue] = zipcode + "," + countryCode
        self.forecastDate = date
        self.performCurrentWeatherRequest()
    }
    
    private func performForecastWeatherRequest() {
        let request = RequestOpenWeatherMap(withType: OpenWeatherMapType.Forecast, andParameters: self.parameters)
        request.request(onCompletion: { (data : Data?, response, error) in
            var responseOWM : ResponseOpenWeatherMapProtocol!
            if error == nil {
                responseOWM = ForecastResponseOpenWeatherMap(data: data!, type: self.formatType, date: self.forecastDate!)
            }
            
            self.delegate?.didFinishRequest(withType: OpenWeatherMapType.Forecast, response: responseOWM)
        })
    }
    
    // Several options
    
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
