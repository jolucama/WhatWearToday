//
//  ResultViewController.swift
//  WhatWearToday
//
//  Created by jlcardosa on 19/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit
import CoreData

class ResultViewController: UIViewController {
    
    @IBOutlet weak var titleResult: UITextField!
    @IBOutlet weak var outfitsResult: OutfitResultUIView!
	
	
	
	var headwear1Outfit: Outfit?
	var headwear2Outfit: Outfit?
	var upperBody1Outfit: Outfit?
	var upperBody2Outfit: Outfit?
	var legsOutfit: Outfit?
	var footwearOutfit: Outfit?
	
	var record : OutfitCalculationHistory!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.outfitsResult.setNeedsLayout()
		self.outfitsResult.layoutIfNeeded()

		self.setUIImagesViewAlpha(alpha: 0.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
		
		self.initOutfitsViews(outfitView: self.outfitsResult.headwear1, outfit: self.headwear1Outfit)
		self.initOutfitsViews(outfitView: self.outfitsResult.headwear2, outfit: self.headwear2Outfit)
		self.initOutfitsViews(outfitView: self.outfitsResult.upperBody1, outfit: self.upperBody1Outfit)
		self.initOutfitsViews(outfitView: self.outfitsResult.upperBody2, outfit: self.upperBody2Outfit)
		self.initOutfitsViews(outfitView: self.outfitsResult.legs, outfit: self.legsOutfit)
		self.initOutfitsViews(outfitView: self.outfitsResult.footwear, outfit: self.footwearOutfit)
		
		self.customizeImages()
		
        UIView.animate(withDuration: 0.6, animations: {
            self.outfitsResult.headwear1.alpha = 1.0
        }, completion: {
            (finished: Bool) -> Void in
            UIView.animate(withDuration: 0.6, animations: {
                self.outfitsResult.headwear2.alpha = 1.0
            }, completion: {
                (finished: Bool) -> Void in
                UIView.animate(withDuration: 0.6, animations: {
                    self.outfitsResult.upperBody1.alpha = 1.0
                }, completion: {
                    (finished: Bool) -> Void in
					UIView.animate(withDuration: 0.6, animations: {
						self.outfitsResult.upperBody2.alpha = 1.0
					}, completion: {
						(finished: Bool) -> Void in
						UIView.animate(withDuration: 0.6, animations: {
							self.outfitsResult.legs.alpha = 1.0
						}, completion: {
							(finished: Bool) -> Void in
							UIView.animate(withDuration: 0.6, animations: {
								self.outfitsResult.footwear.alpha = 1.0
							}, completion: {
								(finished: Bool) -> Void in
								// End
							})
						})
					})
                })
            })
        })
//		
//		for view in self.view.subviews {
//			print(view.frame)
//		}
//		
//		print("--------------------")
//		
//		for view in self.outfitsResult.subviews {
//			print(view.frame)
//		}
//		
//		print("--------------------")
//		
//		for view in self.outfitsResult.view.subviews {
//			print(view.restorationIdentifier)
//			print(view.frame)
//		}
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func outfitCalculationResult(_ sender: UIBarButtonItem) {
		let managedObjectContext = CoreDataManager.getManagedObjectContext()
		let entity = NSEntityDescription.entity(forEntityName: OutfitCalculationHistory.entityName, in: managedObjectContext)
		self.record = OutfitCalculationHistory(entity: entity!, insertInto: managedObjectContext)

		self.record.title = self.titleResult.text
		self.record.date = NSDate()
		self.checkAndAddOutfit(outfit: self.headwear1Outfit)
		self.checkAndAddOutfit(outfit: self.headwear2Outfit)
		self.checkAndAddOutfit(outfit: self.upperBody1Outfit)
		self.checkAndAddOutfit(outfit: self.upperBody2Outfit)
		self.checkAndAddOutfit(outfit: self.legsOutfit)
		self.checkAndAddOutfit(outfit: self.footwearOutfit)
		
		do {
			try managedObjectContext.save()
			performSegue(withIdentifier: "showOutfitHistory", sender: self)
		} catch let error as NSError  {
			let alert = UIAlertController(title: "Error", message: "An error occured saving your object", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
				NSLog("%@", error);
			}))
			self.present(alert, animated: true, completion: nil)
		}

	}
	
	private func checkAndAddOutfit (outfit : Outfit?) {
		if (outfit != nil) {
			self.record.addToOutfits(outfit!)
		}
	}
	
	private func initOutfitsViews(outfitView: UIImageView, outfit: Outfit?)
	{
		if (outfit != nil) {
			if (outfit?.photo != nil) {
				outfitView.image = UIImage(data: outfit?.photo as! Data)
			} else {
				self.outfitsResult.createUILabelInTheCenter(frame: outfitView.frame, withText: (outfit?.title)!, ofSize: 14.0)
			}
		} else {
			self.outfitsResult.createUILabelInTheCenter(frame: outfitView.frame, withText: "No Results", ofSize: 14.0)
		}
	}
	
    private func customizeImages() {
        
        ViewModifier.round(withUIImageView: self.outfitsResult.headwear1)
        ViewModifier.round(withUIImageView: self.outfitsResult.headwear2)
        ViewModifier.round(withUIImageView: self.outfitsResult.upperBody1)
        ViewModifier.round(withUIImageView: self.outfitsResult.upperBody2)
        ViewModifier.round(withUIImageView: self.outfitsResult.legs)
        ViewModifier.round(withUIImageView: self.outfitsResult.footwear)
    }
	
	private func setUIImagesViewAlpha(alpha: CGFloat) {
		self.outfitsResult.headwear1.alpha = alpha
		self.outfitsResult.headwear2.alpha = alpha
		self.outfitsResult.upperBody1.alpha = alpha
		self.outfitsResult.upperBody2.alpha = alpha
		self.outfitsResult.legs.alpha = alpha
		self.outfitsResult.footwear.alpha = alpha
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
