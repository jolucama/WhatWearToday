//
//  ResultViewController.swift
//  WhatWearToday
//
//  Created by jlcardosa on 19/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
	
    @IBOutlet weak var headwear1: UIImageView!
    @IBOutlet weak var headwear2: UIImageView!
    @IBOutlet weak var upperBody1: UIImageView!
    @IBOutlet weak var upperBody2: UIImageView!
    @IBOutlet weak var legs: UIImageView!
    @IBOutlet weak var footwear: UIImageView!
	
	var headwear1Outfit: Outfit?
	var headwear2Outfit: Outfit?
	var upperBody1Outfit: Outfit?
	var upperBody2Outfit: Outfit?
	var legsOutfit: Outfit?
	var footwearOutfit: Outfit?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.initOutfitsViews(outfitView: self.headwear1, outfit: self.headwear1Outfit)
		self.initOutfitsViews(outfitView: self.headwear2, outfit: self.headwear2Outfit)
		self.initOutfitsViews(outfitView: self.upperBody1, outfit: self.upperBody1Outfit)
		self.initOutfitsViews(outfitView: self.upperBody2, outfit: self.upperBody2Outfit)
		self.initOutfitsViews(outfitView: self.legs, outfit: self.legsOutfit)
		self.initOutfitsViews(outfitView: self.footwear, outfit: self.footwearOutfit)

		self.setUIImagesViewAlpha(alpha: 0.0)
        self.customizeImages()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
		
        UIView.animate(withDuration: 0.7, animations: {
            self.headwear1.alpha = 1.0
        }, completion: {
            (finished: Bool) -> Void in
            UIView.animate(withDuration: 0.6, animations: {
                self.headwear2.alpha = 1.0
            }, completion: {
                (finished: Bool) -> Void in
                UIView.animate(withDuration: 0.5, animations: {
                    self.upperBody1.alpha = 1.0
                }, completion: {
                    (finished: Bool) -> Void in
					UIView.animate(withDuration: 0.4, animations: {
						self.upperBody2.alpha = 1.0
					}, completion: {
						(finished: Bool) -> Void in
						UIView.animate(withDuration: 0.3, animations: {
							self.legs.alpha = 1.0
						}, completion: {
							(finished: Bool) -> Void in
							UIView.animate(withDuration: 0.2, animations: {
								self.footwear.alpha = 1.0
							}, completion: {
								(finished: Bool) -> Void in
								// End
							})
						})
					})
                })
            })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	private func initOutfitsViews(outfitView: UIImageView, outfit: Outfit?)
	{
		if (outfit != nil) {
			if (outfit?.photo != nil) {
				outfitView.image = UIImage(data: outfit?.photo as! Data)
			} else {
				self.createLabel(frame: outfitView.frame, text: (outfit?.title)!)
			}
		} else {
			self.createLabel(frame: outfitView.frame, text: "No Results")
		}
	}
	
	private func createLabel(frame: CGRect, text: String)
	{
		let titleLabel = UILabel(frame: frame)
		titleLabel.textAlignment = NSTextAlignment.center
		titleLabel.font = UIFont(name: "Helvetica Bold", size: 15.0)
		titleLabel.text = text
		titleLabel.textColor = UIColor.white
		self.view.addSubview(titleLabel)
	}
	
    private func customizeImages() {
        
        ViewModifier.round(withUIImageView: self.headwear1)
        ViewModifier.round(withUIImageView: self.headwear2)
        ViewModifier.round(withUIImageView: self.upperBody1)
        ViewModifier.round(withUIImageView: self.upperBody2)
        ViewModifier.round(withUIImageView: self.legs)
        ViewModifier.round(withUIImageView: self.footwear)
    }
	
	private func setUIImagesViewAlpha(alpha: CGFloat) {
		self.headwear1.alpha = alpha
		self.headwear2.alpha = alpha
		self.upperBody1.alpha = alpha
		self.upperBody2.alpha = alpha
		self.legs.alpha = alpha
		self.footwear.alpha = alpha
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
