//
//  WeatherAPIProtocol.swift
//  WhatWearToday
//
//  Created by jlcardosa on 14/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation


public protocol WeatherAPIDelegate : class {
    
    func didFinishRequest(withType type : OpenWeatherMapType, response : ResponseOpenWeatherMapProtocol)

}
