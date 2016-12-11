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
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		selector.transform = CGAffineTransform.identity
	}
	
	public func setOutfitImagesWithLabelFallback(outfits: NSSet) {
		let viewDictionary = [
			"headwear1" : self.expandableResultView.headwear1,
			"headwear2" : self.expandableResultView.headwear2,
			"upperBody1": self.expandableResultView.upperBody1,
			"upperBody2": self.expandableResultView.upperBody2,
			"legs"		: self.expandableResultView.legs,
			"footwear"	: self.expandableResultView.footwear
		]
		var modelDictionary:[String:Outfit?] = ["headwear1" : nil, "headwear2" : nil, "upperBody1": nil, "upperBody2": nil, "legs": nil, "footwear": nil]
		
		for case let outfit as Outfit in outfits {
			
			switch Int(outfit.typePart) {
			case Outfit.TypeParts.Headwear.rawValue:
				if modelDictionary["headwear1"]! == nil {
					modelDictionary["headwear1"] = outfit
				} else {
					modelDictionary["headwear2"] = outfit
				}
			case Outfit.TypeParts.UpperBody.rawValue:
				if modelDictionary["upperBody1"]! == nil {
					modelDictionary["upperBody1"] = outfit
				} else {
					modelDictionary["upperBody2"] = outfit
				}
			case Outfit.TypeParts.Legs.rawValue:
				modelDictionary["legs"] = outfit
			case Outfit.TypeParts.Footwear.rawValue:
				modelDictionary["footwear"] = outfit
			default:
				break
			}
		}
		
		for imageViewKeyValue in viewDictionary {
			self.setImageWithLabelFallback(outfitView: imageViewKeyValue.value!, outfit: modelDictionary[imageViewKeyValue.key]!)
		}
	}
	
	private func setImageWithLabelFallback(outfitView: UIImageView, outfit: Outfit?) {
		if (outfit != nil) {
			if (outfit?.photo != nil) {
				outfitView.image = UIImage(data: outfit?.photo as! Data)
			} else {
				self.expandableResultView.createUILabelInTheCenter(frame: outfitView.frame, withText: (outfit?.title)!, ofSize: 10.0)
			}
		} else {
			self.expandableResultView.createUILabelInTheCenter(frame: outfitView.frame, withText: "No Results", ofSize: 10.0)
		}
	}
	
	func cleanValuesAdded(){
		self.expandableResultView.headwear1.image = nil
		self.expandableResultView.headwear2.image = nil
		self.expandableResultView.upperBody1.image = nil
		self.expandableResultView.upperBody2.image = nil
		self.expandableResultView.legs.image = nil
		self.expandableResultView.footwear.image = nil
		
		for subview in self.expandableResultView.subviews {
			if subview is UILabel {
				subview.removeFromSuperview()
			}
		}
	}
	
	func customizeImages() {
		ViewModifier.round(withUIImageView: self.expandableResultView.headwear1)
		ViewModifier.round(withUIImageView: self.expandableResultView.headwear2)
		ViewModifier.round(withUIImageView: self.expandableResultView.upperBody1)
		ViewModifier.round(withUIImageView: self.expandableResultView.upperBody2)
		ViewModifier.round(withUIImageView: self.expandableResultView.legs)
		ViewModifier.round(withUIImageView: self.expandableResultView.footwear)
	}
}
