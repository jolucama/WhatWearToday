//
//  OutfitResultUIView.swift
//  WhatWearToday
//
//  Created by jlcardosa on 10/12/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit

class OutfitResultUIView: UIView {
	var contentView : UIView?
	
    @IBOutlet var view: UIView!
    @IBOutlet weak var headwear1: UIImageView!
    @IBOutlet weak var headwear2: UIImageView!
    @IBOutlet weak var upperBody1: UIImageView!
    @IBOutlet weak var upperBody2: UIImageView!
    @IBOutlet weak var legs: UIImageView!
    @IBOutlet weak var footwear: UIImageView!
    
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		UINib(nibName: String(describing: type(of: self)), bundle: nil).instantiate(withOwner: self, options: nil)
		addSubview(view)
		view.frame = self.bounds
	}
}
