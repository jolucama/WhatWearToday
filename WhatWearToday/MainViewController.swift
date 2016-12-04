//
//  ViewController.swift
//  WhatWearToday
//
//  Created by J on 29/08/16.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, WeatherAPIDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var weatherPhoto: UIImageView!
    @IBOutlet weak var degrees: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var calculation: UIButton!
    
    var apiKey : String!
    var weatherAPI : OpenWeatherMapAPI!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var locationObject: CLLocation?
	
	var responseWeatherApi : ResponseOpenWeatherMapProtocol!
	var calculationResults : ResultCalculator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let now = Date()
        self.datePicker.setDate(now, animated: true)
        self.datePicker.minimumDate = now
        self.datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 5, to: now)
		self.datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        self.apiKey = PlistManager.getValue(forKey: "APIWeatherKey") as! String
        
        //Location Services
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherAPI = OpenWeatherMapAPI(apiKey: self.apiKey)
        weatherAPI.delegate = self
        weatherAPI.setTemperatureUnit(unit: TemperatureFormat.Celsius)
		
		let backgroundView = UIImageView(frame: self.view.frame)
		backgroundView.image = UIImage(named: "ClearSkyDay.jpg")
		backgroundView.contentMode = UIViewContentMode.scaleAspectFill
		
		let filter = UIView()
		filter.frame = self.view.frame
		filter.backgroundColor = UIColor.black
		filter.alpha = 0.05
		backgroundView.addSubview(filter)
		
		self.view.insertSubview(backgroundView, at: 0)
    }
	
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if self.locationObject == nil {
            self.locationObject = locations[locations.count - 1]
            let currentLatitude: CLLocationDistance = self.locationObject!.coordinate.latitude
            let currentLongitude: CLLocationDistance = self.locationObject!.coordinate.longitude
            weatherAPI.currentWeather(byLatitude: currentLatitude, andLongitude: currentLongitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        NSLog("Impossible to get the location of the device")
    }
    
    func didFinishRequest(withType type : OpenWeatherMapType, response : ResponseOpenWeatherMapProtocol?) {
        if ((response?.getError()) == nil) {
			self.responseWeatherApi = response!
            self.degrees.text = String(Int((response?.getTemperature()!)!))
            self.weatherLabel.text = response?.getDescription()
            self.location.text = response?.getCityName()
        } else {
            let alert = UIAlertController(title: "Error", message: (response?.getError()?.localizedDescription)! + ". Add outfits in the meantime ;)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                print(response?.getError()! as Any)
            }))
            // To Test
            alert.addAction(UIAlertAction(title: "Add outfit", style: .default, handler: { (action) in
                self.performSegue(withIdentifier: "editOutfitSegue", sender: self)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func datePickerAction(_ sender: Any) {
        // TODO, Call the API, change the weather here !!
        print(self.datePicker.date);
        
        if self.locationObject != nil {
            weatherAPI.forecastWeather(byLatitude:   self.locationObject!.coordinate.latitude,
                                       andLongitude: self.locationObject!.coordinate.longitude,
                                       andDate:      self.datePicker.date)
        }
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        let outfitCalculator = RamdomOutfitCalculator()
		do {
			//Fail if click the button so fast
			try self.calculationResults = outfitCalculator.calculate(response: self.responseWeatherApi)
		} catch let error as Error {
			NSLog("Problem witht the calculation")
			print(error)
		}
    }
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToResultCalculation",
			let resultViewController = segue.destination as? ResultViewController {
			
			let resultHW = self.calculationResults.headwearOutfit
			let resultUB = self.calculationResults.upperBodyOutfit
			let resultL = self.calculationResults.legsOutfit
			let resultFW = self.calculationResults.footwearOutfit
			resultViewController.headwear1Outfit = (resultHW.indices.contains(0) ? resultHW[0] : nil)
			resultViewController.headwear2Outfit = (resultHW.indices.contains(1) ? resultHW[1] : nil)
			resultViewController.upperBody1Outfit = (resultUB.indices.contains(1) ? resultUB[0] : nil)
			resultViewController.upperBody2Outfit = (resultUB.indices.contains(1) ? resultUB[1] : nil)
			resultViewController.legsOutfit = (resultL.indices.contains(0) ? resultL[0] : nil)
			resultViewController.footwearOutfit = (resultFW.indices.contains(0) ? resultFW[0] : nil)
		}
	}
}
