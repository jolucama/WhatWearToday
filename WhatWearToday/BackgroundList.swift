//
//  IconList.swift
//  WhatWearToday
//
//  Created by jlcardosa on 04/12/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation

enum BackgroundList : String {
	
	case ClearSkyDay = "ClearSkyDay.jpg"
	case ClearSkyNight = "ClearSkyNight.jpg"
	case FewCloudsDay = "FewCloudsDay.jpg"
	case FewCloudsNight = "FewCloudsNight.jpg"
	case ScatteredCloudsDay = "ScatteredCloudsDay.jpg"
	case ScatteredCloudsNight = "ScatteredCloudsNight.jpg"
	case BrokenCloudsDay = "BrokenCloudsDay.jpg"
	case BrokenCloudsNight = "BrokenCloudsNight.jpg"
	case ShowerRainDay = "ShowerRainDay.jpg"
	case ShowerRainNight = "ShowerRainNight.jpg"
	case RainDay = "RainDay.jpg"
	case RainNight = "RainNight.jpg"
	case ThunderstormDay = "ThunderstormDay.jpg"
	case ThunderstormNight = "ThunderstormNight.jpg"
	case SnowDay = "SnowDay.jpg"
	case SnowNight = "SnowNight.jpg"
	case MistDay = "MistDay.jpg"
	case MistNight = "MistNight.jpg"
	
	func backgroundControllerComingFrom(responseWeatherAPI response : ResponseOpenWeatherMapProtocol) -> BackgroundList {
		switch response.getIconList() {
		case "01d" :
			return .ClearSkyDay
		case "01n" :
			return .ClearSkyNight
		case "02d" :
			return .FewCloudsDay
		case "02n" :
			return .FewCloudsNight
		case "03d" :
			return .ScatteredCloudsDay
		case "03n" :
			return .ScatteredCloudsNight
		case "04d" :
			return .BrokenCloudsDay
		case "04n" :
			return .BrokenCloudsNight
		case "09d" :
			return .ShowerRainDay
		case "09n" :
			return .ShowerRainNight
		case "10d" :
			return .RainDay
		case "10n" :
			return .RainNight
		case "11d" :
			return .ThunderstormDay
		case "11n" :
			return .ThunderstormNight
		case "13d" :
			return .SnowDay
		case "13n" :
			return .SnowNight
		case "50d" :
			return .MistDay 
		case "50n" :
			return .MistNight
		default:
			return .ClearSkyDay
		}
	}
	
}
