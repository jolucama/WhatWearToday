//
//  OutfitCalculator.swift
//  WhatWearToday
//
//  Created by jlcardosa on 22/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation

class RamdomOutfitCalculator : OutfitCalculatorProtocol {
	
	var typePartsOutfitsBySeason : ResultCalculator
	var currentSeason : Outfit.Season! = nil
	
	init() {
		self.typePartsOutfitsBySeason = ResultCalculator()
	}
	
    func calculate(response: ResponseOpenWeatherMapProtocol) throws -> ResultCalculator
	{
		self.currentSeason = self.calculateSeasonRelyingOn(Date: response.getDate())
		try self.sliptOutfitIntoTypes()
		return self.calculateRamdonly()
    }
	
	
	private func calculateRamdonly() -> ResultCalculator
	{
		var ramdomResult = ResultCalculator()
		
		ramdomResult.addOutfitDependingOnTheType(outfit: self.typePartsOutfitsBySeason.headwearOutfit.extractRamdonItem())
		ramdomResult.addOutfitDependingOnTheType(outfit: self.typePartsOutfitsBySeason.headwearOutfit.extractRamdonItem())
		ramdomResult.addOutfitDependingOnTheType(outfit: self.typePartsOutfitsBySeason.upperBodyOutfit.extractRamdonItem())
		ramdomResult.addOutfitDependingOnTheType(outfit: self.typePartsOutfitsBySeason.upperBodyOutfit.extractRamdonItem())
		ramdomResult.addOutfitDependingOnTheType(outfit: self.typePartsOutfitsBySeason.legsOutfit.extractRamdonItem())
		ramdomResult.addOutfitDependingOnTheType(outfit: self.typePartsOutfitsBySeason.footwearOutfit.extractRamdonItem())
		
		return ramdomResult
	}
	
	private func sliptOutfitIntoTypes() throws
	{
		let outfitRepository = OutfitRepository()
		let outfits = try outfitRepository.fetch(bySeason: self.currentSeason)
		for outfit in outfits {
			self.typePartsOutfitsBySeason.addOutfitDependingOnTheType(outfit: outfit);
		}
	}
	
    private func calculateSeasonRelyingOn(Date date : Date!) -> Outfit.Season
	{
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
