//
//  OutfitCalculator.swift
//  WhatWearToday
//
//  Created by jlcardosa on 22/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation

class OutfitCalculator : OutfitCalculatorProtocol{
    
    func calculate(response: ResponseOpenWeatherMapProtocol) -> [Outfit] {
        
        //TODO
        let outfits = [Outfit]()
        
        return outfits
    }
    
    private func calculateSeasonRelyingOn(Date date : Date!) -> Outfit.Season {
        
        
        return Outfit.Season.Summer
    }
}
