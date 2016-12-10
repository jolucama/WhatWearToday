//
//  OutfitCalculationHistoryTableViewCell.swift
//  WhatWearToday
//
//  Created by jlcardosa on 10/12/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit

class OutfitCalculationHistoryTableViewCell: UITableViewCell {

	@IBOutlet weak var titleCalculation: UILabel!
	@IBOutlet weak var dateCalculation: UILabel!
	@IBOutlet weak var selector: UIImageView!
	@IBOutlet weak var expandableResultView: OutfitResultUIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
