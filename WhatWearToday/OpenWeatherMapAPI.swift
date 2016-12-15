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
	var type: OpenWeatherMapType
    var forecastDate: Date?
    weak var delegate: WeatherAPIDelegate?
	var usingPersistence: Bool
	var timeInterval: Int
	
    /// Creates a new instance with the API key and the type
    ///
    /// - Parameter apiKey: The API key that is given here: https://home.openweathermap.org/api_keys
    /// - Parameter type  : The type of the call, by default will be the Current weather, see OpenWeatherMapType
    ///                     for more information about the possibles options
	init (apiKey : String!, forType type: OpenWeatherMapType = OpenWeatherMapType.Current) {
        self.parameters[RequestParametersKey.apiKey.rawValue] = apiKey
		self.type = type
		self.usingPersistence = false
		self.timeInterval = 0
    }
	
	public func weather(byCityName cityName : String) {
		self.parameters[RequestParametersKey.cityName.rawValue] = cityName
		self.performCurrentWeatherRequest()
	}
	
	public func weather(byCityName cityName : String, andCountryCode countryCode: String) {
		self.parameters[RequestParametersKey.cityName.rawValue] = cityName + "," + countryCode
		self.performCurrentWeatherRequest()
	}
	
	public func weather(byCityId cityId : Int) {
		self.parameters[RequestParametersKey.cityID.rawValue] = String(cityId)
		self.performCurrentWeatherRequest()
	}
	
	public func weather(byLatitude latitude : Double, andLongitude longitude : Double) {
		self.parameters[RequestParametersKey.latitude.rawValue] = String(latitude)
		self.parameters[RequestParametersKey.longitude.rawValue] = String(longitude)
		self.performCurrentWeatherRequest()
	}
	
	public func weather(byZipCode zipcode : String, andCountryCode countryCode : String) {
		self.parameters[RequestParametersKey.zipCode.rawValue] = zipcode + "," + countryCode
		self.performCurrentWeatherRequest()
	}
	
	public func performWeatherRequest(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
		let lastRequest = OpenWeatherMap.getLastRequestStored()
		if lastRequest == nil || lastRequest?.needToRequestAgain(forTimeInterval: self.timeInterval) == true {
			let request = RequestOpenWeatherMap(withType: self.type, andParameters: self.parameters)
			request.request(onCompletion: completionHandler)
		} else {
			completionHandler(lastRequest?.content as? Data, nil, nil)
		}
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
    
    public func currentWeather(byLatitude latitude : Double, andLongitude longitude : Double) {
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
                responseOWM = CurrentResponseOpenWeatherMap(data: data!)
            } else {
                responseOWM = CurrentResponseOpenWeatherMap(withError: error!);
            }
            NSLog("Response to CurrentResponseOpenWeatherMap")
            
            DispatchQueue.main.async { [unowned self] in
                self.delegate?.didFinishRequest(withType: OpenWeatherMapType.Current, response: responseOWM)
            }
        })
    }
    
    /// --- Methods for the forecast weather
    
    public func forecastWeather(byCityName cityName : String, andDate date : Date) {
        self.parameters[RequestParametersKey.cityName.rawValue] = cityName
        self.forecastDate = date
        self.performForecastWeatherRequest()
    }
    
    public func forecastWeather(byCityName cityName : String, andCountryCode countryCode: String, andDate date : Date) {
        self.parameters[RequestParametersKey.cityName.rawValue] = cityName + "," + countryCode
        self.forecastDate = date
        self.performForecastWeatherRequest()
    }
    
    public func forecastWeather(byCityId cityId : Int, andDate date : Date) {
        self.parameters[RequestParametersKey.cityID.rawValue] = String(cityId)
        self.forecastDate = date
        self.performForecastWeatherRequest()
    }
    
    public func forecastWeather(byLatitude latitude : Double, andLongitude longitude : Double, andDate date : Date) {
        self.parameters[RequestParametersKey.latitude.rawValue] = String(latitude)
        self.parameters[RequestParametersKey.longitude.rawValue] = String(longitude)
        self.forecastDate = date
        self.performForecastWeatherRequest()
    }
    
    public func forecastWeather(byZipCode zipcode : String, andCountryCode countryCode : String, andDate date : Date) {
        self.parameters[RequestParametersKey.zipCode.rawValue] = zipcode + "," + countryCode
        self.forecastDate = date
        self.performForecastWeatherRequest()
    }
    
    private func performForecastWeatherRequest() {
        let request = RequestOpenWeatherMap(withType: OpenWeatherMapType.Forecast, andParameters: self.parameters)
        request.request(onCompletion: { (data : Data?, response, error) in
            var responseOWM : ResponseOpenWeatherMapProtocol!
            if error == nil {
                responseOWM = ForecastResponseOpenWeatherMap(data: data!, date: self.forecastDate!)
            }
            NSLog("Response to ForecastResponseOpenWeatherMap")
            DispatchQueue.main.async { [unowned self] in
                self.delegate?.didFinishRequest(withType: OpenWeatherMapType.Forecast, response: responseOWM)
            }
        })
    }
    
    private func cleanInputParameters() {
        self.parameters.removeValue(forKey: RequestParametersKey.cityName.rawValue)
        self.parameters.removeValue(forKey: RequestParametersKey.cityName.rawValue)
        self.parameters.removeValue(forKey: RequestParametersKey.cityName.rawValue)
        self.parameters.removeValue(forKey: RequestParametersKey.cityName.rawValue)
    }
    
    // Several options
	
	public func setUsingPersistence(_ option: Bool, withTimeInterval time: Int) {
		self.usingPersistence = option
		self.timeInterval = time
	}
	
	public func setDateForForecast(date: Date) {
		self.forecastDate = date
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
