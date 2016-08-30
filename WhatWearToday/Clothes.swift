//
//  Clothes.swift
//  WhatWearToday
//
//  Created by J on 30/08/16.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit

class Clothes: NSObject {

    var title : String!
    var type : String!
    var color : String!
    var season : String!
    var pieceDescription : String!
    var previewPhoto : UIImage!
    
    init(title: String, type: String, color: String, season: String, pieceDescription: String, previewPhoto: UIImage) {
        self.title = title
        self.type = type
        self.color = color
        self.season = season
        self.pieceDescription = pieceDescription
        self.previewPhoto = previewPhoto
    }
}
