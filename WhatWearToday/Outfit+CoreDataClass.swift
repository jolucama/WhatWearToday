//
//  Outfit+CoreDataClass.swift
//  WhatWearToday
//
//  Created by jlcardosa on 13/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation
import CoreData

@objc(Outfit)
public class Outfit: NSManagedObject {
    
    static let entityName = "Outfit"

    enum Season : Int {
    
        case SpringAutumn = 0
        case Summer = 1
        case Winter = 2
    }
	
	enum Types : String {
		
		// Headwear
		case Beret = "Beret"
		case BowlerHat = "BowlerHat"
		case Trilby = "Trilby"
		case WoolenHat = "WoolenHat"
		case Hat = "Hat"
		
		// Upperbody
		case Coat = "Coat"
		case Jacket = "Jacket"
		case Tshirt = "Tshirt"
		case Shirt = "Shirt"
		case Pullover = "Pullover"
		case Jumpers = "Jumpers"
		case Tanktop = "Tanktop"
		case Dress = "Dress"
		case Blouse = "Blouse"
		case Cardigan = "Cardigan"
		case Sweatshirt = "Sweatshirt"
		case Hoodie = "Hoodie"
		
		//Legs
		case Jeans = "Jeans"
		case Trouser = "Trouser"
		case Shorts = "Shorts"
		case Tight = "Tight"
		case Skirt = "Skirt"
		
		// Footwear
		case Shoes = "Shoes"
		case Sandals = "Sandals"
		case Boots = "Boots"
		case Wellingtons = "Wellingtons"
		
		static let allValues = [Beret, .BowlerHat, .Trilby, .WoolenHat, .Hat, .Coat, .Jacket, .Tshirt, .Shirt, .Pullover, .Jumpers, .Tanktop, .Dress, .Blouse, .Cardigan, .Sweatshirt, .Hoodie, .Jeans, .Trouser, .Shorts, .Tight, .Skirt, .Shoes, .Sandals, .Boots, .Wellingtons]
		
		static let allValuesRaw = [Beret.rawValue, BowlerHat.rawValue, Trilby.rawValue, WoolenHat.rawValue, Hat.rawValue, Coat.rawValue, Jacket.rawValue, Tshirt.rawValue, Shirt.rawValue, Pullover.rawValue, Jumpers.rawValue, Tanktop.rawValue, Dress.rawValue, Blouse.rawValue, Cardigan.rawValue, Sweatshirt.rawValue, Hoodie.rawValue, Jeans.rawValue, Trouser.rawValue, Shorts.rawValue, Tight.rawValue, Skirt.rawValue, Shoes.rawValue, Sandals.rawValue, Boots.rawValue, Wellingtons.rawValue]
		
		func getTypePart() -> TypeParts {
			switch self {
			case .Beret, .BowlerHat, .Trilby, .WoolenHat, .Hat:
				return TypeParts.Headwear
			case .Coat, .Jacket, .Tshirt, .Shirt, .Pullover, .Jumpers, .Tanktop, .Dress, .Blouse, .Cardigan, .Sweatshirt, .Hoodie:
				return TypeParts.UpperBody
			case .Jeans, .Trouser, .Shorts, .Tight, .Skirt:
				return TypeParts.Legs
			case .Shoes, .Sandals, .Boots, .Wellingtons:
				return TypeParts.Footwear
			}
		}
		
		
	}
	
	enum TypeParts : Int {
		
		case Headwear = 1
		case UpperBody
		case Legs
		case Footwear
	}
}
