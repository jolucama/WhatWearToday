//
//  RequestOpenWeatherMap.swift
//  WhatWearToday
//
//  Created by jlcardosa on 14/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation


class RequestOpenWeatherMap {
    
    let baseURLString = "http://api.openweathermap.org/data/"
    let apiVersion = "2.5/"
    var type : String
    let method = "GET"
    var parameters : [String: String]
    
    init(withType type : String, andParameters parameters:[String: String]) {
        self.type = type
        self.parameters = parameters
    }
    
    func request(onCompletion : @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        let paramString = self.stringFromHttpParameters()
        let url = URL(string: baseURLString + apiVersion + type + "?" + paramString)!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        
        let task = session.dataTask(with: request, completionHandler: onCompletion)
        task.resume()
        
    }
    
    private func stringFromHttpParameters() -> String {
        var parameterArray = [String]()
        for (key, value) in self.parameters {
            parameterArray.append(key + "=" + value.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        }
        
        return parameterArray.joined(separator: "&")
    }
}
