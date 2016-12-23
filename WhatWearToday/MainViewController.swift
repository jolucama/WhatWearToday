//
//  ViewController.swift
//  WhatWearToday
//
//  Created by J on 29/08/16.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var weatherPhoto: UIImageView!
    @IBOutlet weak var degrees: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var calculation: UIButton!
	
	var backgroundImageView: UIImageView!
    
    var apiKey : String!
    var weatherAPI : OpenWeatherMapAPI!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var locationObject: CLLocation?
	
	var responseWeatherApi : ResponseOpenWeatherMapProtocol!
	var calculationResults : ResultCalculator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		UIApplication.shared.statusBarStyle = .lightContent
		self.createBackgroundWithFilter()
		
        let now = Date()
        self.datePicker.setDate(now, animated: true)
        self.datePicker.minimumDate = now
        self.datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 5, to: now)
		self.datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        self.apiKey = PlistManager.getValue(forKey: "APIWeatherKey") as! String
		
        //Location Services
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherAPI = OpenWeatherMapAPI(apiKey: self.apiKey, forType: OpenWeatherMapType.Current)
        weatherAPI.setTemperatureUnit(unit: TemperatureFormat.Celsius)
    }
	
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if self.locationObject == nil {
            self.locationObject = locations[locations.count - 1]
            let currentLatitude: CLLocationDistance = self.locationObject!.coordinate.latitude
            let currentLongitude: CLLocationDistance = self.locationObject!.coordinate.longitude
            weatherAPI.weather(byLatitude: currentLatitude, andLongitude: currentLongitude)
			weatherAPI.performWeatherRequest(completionHandler:{(data: Data?, urlResponse: URLResponse?, error: Error?) in
				NSLog("Response Current Weather Done")
				if (error != nil) {
					self.showAddOutfitAlert(message: "Error fetching the current weather", error: error)
				} else {
					do {
						self.responseWeatherApi = try CurrentResponseOpenWeatherMap(data: data!)
						DispatchQueue.main.async { [unowned self] in
							self.updateViewWithResponseWeatherAPI()
						}
					} catch let error as Error {
						self.showAddOutfitAlert(message: "Error fetching the current weather", error: error)
					}
				}
			})
        }
    }
	
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        NSLog("Impossible to get the location of the device")
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func datePickerAction(_ sender: Any) {
        if self.locationObject != nil {
			weatherAPI.type = OpenWeatherMapType.Forecast
			weatherAPI.performWeatherRequest(completionHandler:{(data: Data?, urlResponse: URLResponse?, error: Error?) in
				NSLog("Response Current Forecast Done")
				if (error != nil) {
					self.showAddOutfitAlert(message: "Error fetching the forecast weather", error: error)
				} else {
					do {
						self.responseWeatherApi = try ForecastResponseOpenWeatherMap(data: data!, date: self.datePicker.date)
						DispatchQueue.main.async { [unowned self] in
							self.updateViewWithResponseWeatherAPI()
						}
					} catch let error as Error {
						self.showAddOutfitAlert(message: "Error fetching the forecast weather", error: error)
					}
				}
			})
        }
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        let outfitCalculator = RamdomOutfitCalculator()
		do {
			if self.responseWeatherApi != nil {
				try self.calculationResults = outfitCalculator.calculate(response: self.responseWeatherApi)
				self.performSegue(withIdentifier: "goToResultCalculation", sender: sender)
			} else {
				self.showAddOutfitAlert(message: "We don't have info about the weather yet.", error: nil)
			}
		} catch let error as Error {
			self.showAddOutfitAlert(message: error.localizedDescription, error: error)
			NSLog("Problem witht the calculation")
			print(error)
		}
    }
	
	private func createBackgroundWithFilter() {
		self.backgroundImageView = UIImageView(frame: self.view.frame)
		self.backgroundImageView.contentMode = UIViewContentMode.scaleAspectFill
		
		let filter = ViewModifier.createBlackFilter(frame: self.view.frame, opacity: 0.25)
		self.backgroundImageView.addSubview(filter)
		
		self.view.insertSubview(self.backgroundImageView, at: 0)
	}
	
	private func updateViewWithResponseWeatherAPI(){
		self.loadBackground(responseWeather: self.responseWeatherApi)
		self.degrees.text = String(Int(self.responseWeatherApi.getTemperature()))
		self.weatherLabel.text = self.responseWeatherApi.getDescription()
		self.location.text = self.responseWeatherApi.getCityName()
	}
	
	private func loadBackground(responseWeather: ResponseOpenWeatherMapProtocol) {
		let backgroundIconList = responseWeather.getIconList()
		let iconListString = String(reflecting: backgroundIconList).replacingOccurrences(of: "WhatWearToday.IconList.", with: "")
		
		UIView.animate(withDuration: 0.35, animations: {
			self.backgroundImageView.alpha = 0.0
		}, completion: {
			(finished: Bool) -> Void in
			self.backgroundImageView.image = UIImage(named: iconListString + ".jpg")
			UIView.animate(withDuration: 0.35, animations: {
				self.backgroundImageView.alpha = 1.0
			})
		})
	}

	private func showAddOutfitAlert(message: String, error: Error?) {
		let alert = UIAlertController(title: "Oups!", message: message + ". Add outfits in the meantime ;)", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
			print(error ?? "No error object")
		}))
		alert.addAction(UIAlertAction(title: "Add outfit", style: .default, handler: { (action) in
			self.performSegue(withIdentifier: "fromMainViewToOutfitList", sender: self)
		}))
		self.present(alert, animated: true, completion: nil)
	}
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToResultCalculation" {
			let destinationNavigationController = segue.destination as! UINavigationController
			let resultViewController = destinationNavigationController.topViewController as! ResultViewController
			
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
		
		if segue.identifier == "fromMainViewToOutfitList",
			let containerViewController = segue.destination as? ContainerViewController{
			
			if self.backgroundImageView.image != nil {
				containerViewController.backButtonImage = self.backgroundImageView.image
			}
		}
	}
}
