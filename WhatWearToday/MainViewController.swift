//
//  ViewController.swift
//  WhatWearToday
//
//  Created by J on 29/08/16.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, WeatherAPIDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var weatherPhoto: UIImageView!
    @IBOutlet weak var degrees: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var calculation: UIButton!
    
    var apiKey : String!
    var weatherAPI : OpenWeatherMapAPI!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let now = Date()
        self.datePicker.setDate(now, animated: true)
        self.datePicker.minimumDate = now
        self.datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 5, to: now)
        self.apiKey = PlistManager.getValue(forKey: "APIWeatherKey") as! String
        
        weatherAPI = OpenWeatherMapAPI(apiKey: self.apiKey)
        weatherAPI.delegate = self
        weatherAPI.setTemperatureUnit(unit: TemperatureFormat.Celsius)
        weatherAPI.currentWeather(byCityName: "London")
    }
    
    func didFinishRequest(withType type : OpenWeatherMapType, response : ResponseOpenWeatherMapProtocol?) {
        
        self.degrees.text = String(Int((response?.getTemperature()!)!)) + "˚"
        
        //Update the UI
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func datePickerAction(_ sender: Any) {
        // TODO, Call the API, change the weather here !!
        print(self.datePicker.date);
        
        weatherAPI.forecastWeather(byCityName: "London", andDate: self.datePicker.date)
    }

}
