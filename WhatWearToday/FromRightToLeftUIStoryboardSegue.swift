//
//  FromRightToLeftUIStoryboardSegue.swift
//  WhatWearToday
//
//  Created by jlcardosa on 10/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit

class FromRightToLeftUIStoryboardSegue: UIStoryboardSegue {
    
    override func perform() {
        let src: UIViewController = self.source
        let dst: UIViewController = self.destination
        let transition: CATransition = CATransition()
        let timeFunc : CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.duration = 0.35
        transition.timingFunction = timeFunc
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        src.navigationController!.view.layer.add(transition, forKey: kCATransition)
        src.navigationController!.pushViewController(dst, animated: false)
    }
}
