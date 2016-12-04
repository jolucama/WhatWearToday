//
//  ResultCalculator.swift
//  WhatWearToday
//
//  Created by jlcardosa on 01/12/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation

struct ResultCalculator {
	
	var headwearOutfit = [Outfit]()
	var upperBodyOutfit = [Outfit]()
	var legsOutfit = [Outfit]()
	var footwearOutfit = [Outfit]()
	
	mutating func addOutfitDependingOnTheType(outfit : Outfit?) {
		if (outfit == nil) {
			return;
		}
		let type = Outfit.TypeParts(rawValue: Int(outfit!.typePart))!
		switch type {
		case Outfit.TypeParts.Headwear:
			self.headwearOutfit.append(outfit!)
		case Outfit.TypeParts.UpperBody:
			self.upperBodyOutfit.append(outfit!)
		case Outfit.TypeParts.Legs:
			self.legsOutfit.append(outfit!)
		case Outfit.TypeParts.Footwear:
			self.footwearOutfit.append(outfit!)
		}
	}
	
	
}
