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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let now = Date()
        self.datePicker.setDate(now, animated: true)
        self.datePicker.minimumDate = now
        self.datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 5, to: now)
        self.apiKey = PlistManager.getValue(forKey: "APIWeatherKey") as! String
        
        //Location Services
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherAPI = OpenWeatherMapAPI(apiKey: self.apiKey)
        weatherAPI.delegate = self
        weatherAPI.setTemperatureUnit(unit: TemperatureFormat.Celsius)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if self.locationObject == nil {
            self.locationObject = locations[locations.count - 1]
            let currentLatitude: CLLocationDistance = self.locationObject!.coordinate.latitude
            let currentLongitude: CLLocationDistance = self.locationObject!.coordinate.longitude
            //weatherAPI.currentWeather(byLatitude: currentLatitude, andLongitude: currentLongitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        NSLog("Impossible to get the location of the device")
    }
    
    func didFinishRequest(withType type : OpenWeatherMapType, response : ResponseOpenWeatherMapProtocol?) {
        self.degrees.text = String(Int((response?.getTemperature()!)!)) + "˚"
        self.weatherLabel.text = response?.getDescription()
        self.location.text = response?.getCityName()
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
        // let outfitCalculator = OutfitCalculator(ResponseOpenWeatherMapProtocol)
        // let results : [String, Outfit] = outfitCalculator.calculate()
    }

}
