//
//  OutfitUITableViewCell.swift
//  WhatWearToday
//
//  Created by jlcardosa on 12/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit

class OutfitUITableViewCell: UITableViewCell {

    @IBOutlet weak var outfitPhoto: UIImageView!
    @IBOutlet weak var outfitTitle: UILabel!
    @IBOutlet weak var outfitSeason: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Make the image view as a circle
        self.outfitPhoto.layer.cornerRadius = self.outfitPhoto.frame.size.height/2
        self.outfitPhoto.layer.masksToBounds = true
        self.outfitPhoto.layer.borderWidth = 0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
