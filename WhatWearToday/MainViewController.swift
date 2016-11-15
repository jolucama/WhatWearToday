//
//  ViewController.swift
//  WhatWearToday
//
//  Created by J on 29/08/16.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var weatherPhoto: UIImageView!
    @IBOutlet weak var degrees: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var calculation: UIButton!
    
    let apiKey = "fbf896f8640c38fd302227bb61f3addc"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let now = Date()
        self.datePicker.setDate(now, animated: true)
        self.datePicker.minimumDate = now
        self.datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 14, to: now)
        
        let weatherAPI = OpenWeatherMapAPI(apiKey: apiKey)
        weatherAPI.setTemperatureUnit(unit: TemperatureFormat.Celsius)
        weatherAPI.setFormat(format: Format.Json)
        weatherAPI.currentWeather(byCityName: "London", onCompletion: { (data : Data?, response, error) in
            let string1 = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print(string1)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func datePickerAction(_ sender: Any) {
        // TODO, Call the API, change the weather here !!
        print(self.datePicker.date);
    }

}
