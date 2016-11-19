//
//  ResponseOpenWeatherMapProtocol.swift
//  WhatWearToday
//
//  Created by jlcardosa on 17/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation


public class ResponseOpenWeatherMap {
    
    enum FormatError: Error {
        case XmlNotSupported
        case HtmlNotSupported
    }
    
    var rawDataString : String
    var rawData : Dictionary<String, Any>!
    
    init(data : Data, type : Format) {
        self.rawDataString = String(data: data, encoding: String.Encoding.utf8)!
        do {
            switch type {
            case Format.Json:
                try self.rawData = JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves) as! Dictionary<String, AnyObject>
                break
            case Format.Xml:
                //let xmlParser = XMLParser(data: data)
                //XMLParser.dictionaryWithValues(<#T##NSObject#>)
                //self.rawData = XMLParser(data: data)
                // "Format XML not supported yet by the API Client"
                throw FormatError.XmlNotSupported
            default:
                break
                
            }
        } catch let error as NSError {
            NSLog("%@", error)
        }
    }
    
    public func getDataRawString() -> String? {
        return self.rawDataString
    }
}
