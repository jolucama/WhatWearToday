//
//  FormatReturn.swift
//  WhatWearToday
//
//  Created by jlcardosa on 14/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation


public enum FormatReturn {
    
    case JSON(JSONSerialization)
    
    case XML(XMLParser)
    
    case HTML(String)
}
