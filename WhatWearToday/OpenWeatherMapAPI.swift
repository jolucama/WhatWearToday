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
	}
	
	public func weather(byCityName cityName : String, andCountryCode countryCode: String) {
		self.parameters[RequestParametersKey.cityName.rawValue] = cityName + "," + countryCode
	}
	
	public func weather(byCityId cityId : Int) {
		self.parameters[RequestParametersKey.cityID.rawValue] = String(cityId)
	}
	
	public func weather(byLatitude latitude : Double, andLongitude longitude : Double) {
		self.parameters[RequestParametersKey.latitude.rawValue] = String(latitude)
		self.parameters[RequestParametersKey.longitude.rawValue] = String(longitude)
	}
	
	public func weather(byZipCode zipcode : String, andCountryCode countryCode : String) {
		self.parameters[RequestParametersKey.zipCode.rawValue] = zipcode + "," + countryCode
	}
	
	public func performWeatherRequest(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
		let lastRequest = OpenWeatherMap.getLastRequestStored()
		if lastRequest == nil || lastRequest?.needToRequestAgain(forTimeInterval: self.timeInterval) == true {
			let request = RequestOpenWeatherMap(withType: self.type, andParameters: self.parameters)
			request.request(onCompletion: completionHandler)
			
			NSLog("Response done")
		} else {
			completionHandler(lastRequest?.content as? Data, nil, nil)
		}
	}
	
    public func resetLocationParameters() {
        self.parameters.removeValue(forKey: RequestParametersKey.cityName.rawValue)
        self.parameters.removeValue(forKey: RequestParametersKey.cityID.rawValue)
        self.parameters.removeValue(forKey: RequestParametersKey.latitude.rawValue)
		self.parameters.removeValue(forKey: RequestParametersKey.longitude.rawValue)
		self.parameters.removeValue(forKey: RequestParametersKey.zipCode.rawValue)
    }
	
	
	
    // Several options
	
	public func setUsingPersistence(_ option: Bool, withTimeInterval time: Int) {
		self.usingPersistence = option
		self.timeInterval = time
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
