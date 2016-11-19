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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headwear1.alpha = 0.0
        self.headwear2.alpha = 0.0
        self.upperBody1.alpha = 0.0
        self.upperBody2.alpha = 0.0
        self.legs.alpha = 0.0
        self.footwear.alpha = 0.0

        // Do any additional setup after loading the view.
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
                    // Carry on with the chain
                })
            })
        })
        
        // TODO Move them to the chain
        self.upperBody2.alpha = 1.0
        self.legs.alpha = 1.0
        self.footwear.alpha = 1.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func customizeImages() {
        
        ViewModifier.round(withUIImageView: self.headwear1)
        ViewModifier.round(withUIImageView: self.headwear2)
        ViewModifier.round(withUIImageView: self.upperBody1)
        ViewModifier.round(withUIImageView: self.upperBody2)
        ViewModifier.round(withUIImageView: self.legs)
        ViewModifier.round(withUIImageView: self.footwear)
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
