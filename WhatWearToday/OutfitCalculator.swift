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
        
        let currentSeason = self.calculateSeasonRelyingOn(Date: response.getDateTime()!)
        let outfitRepository = OutfitRepository()
		var outfits = outfitRepository.fetch(bySeason: currentSeason)
        
        

	
        
        return outfits
    }
    
    private func calculateSeasonRelyingOn(Date date : Date!) -> Outfit.Season {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month], from: date)
        let month = components.month!
        let day = components.day!
        
        if day > 21 && month > 6 && day < 22 && month < 9 {
            return Outfit.Season.Summer
        } else if day > 21 && month > 12 && day < 22 && month < 3 {
            return Outfit.Season.Winter
        } else {
            return Outfit.Season.SpringAutumn
        }
    }
}
