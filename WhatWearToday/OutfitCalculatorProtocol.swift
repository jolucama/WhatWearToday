//
//  OutfitCalculatorProtocol.swift
//  WhatWearToday
//
//  Created by jlcardosa on 22/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation

protocol OutfitCalculatorProtocol {
    
    func calculate(response : ResponseOpenWeatherMapProtocol) -> [Outfit]
    
}
