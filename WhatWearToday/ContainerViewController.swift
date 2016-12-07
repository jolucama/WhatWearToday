//
//  ContainerViewController.swift
//  WhatWearToday
//
//  Created by jlcardosa on 04/12/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
	@IBOutlet weak var backButton: UIButton!
	
	var backButtonImage: UIImage?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		if (backButton != nil) {
			self.backButton.setBackgroundImage(self.backButtonImage, for: UIControlState.normal)
		}
		
		backButton.layer.cornerRadius = backButton.frame.size.height/2
		backButton.layer.masksToBounds = true
		backButton.layer.borderWidth = 1.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backToMainViewController(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
