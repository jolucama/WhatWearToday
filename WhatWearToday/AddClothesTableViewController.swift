//
//  AddClothesTableViewController.swift
//  WhatWearToday
//
//  Created by J on 30/08/16.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit
import Foundation

class AddClothesTableViewController: UITableViewController {

    @IBOutlet weak var pieceTitle: UITextField!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var season: UISegmentedControl!
    @IBOutlet weak var pieceDescripiton: UITextView!
    @IBOutlet weak var previewImage: UIImageView!
    
    @IBAction func addPhoto(sender: UIButton, forEvent event: UIEvent) {
    }
}
