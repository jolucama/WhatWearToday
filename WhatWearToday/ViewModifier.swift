//
//  ViewModifier.swift
//  WhatWearToday
//
//  Created by jlcardosa on 19/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation
import UIKit

class ViewModifier {
    
    public static func round(withUIImageView imageView : UIImageView, borderWidth : CGFloat = 0) {
        imageView.layer.cornerRadius = imageView.layer.bounds.size.width/2
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = borderWidth
    }
    
    public static func textToImage(drawText text: NSString, inImage imageView: UIImageView) -> UIImage {
        let textColor = UIColor.darkGray
        let textFont = UIFont(name: "Helvetica Bold", size: 12)!
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
            ] as [String : Any]

		let image = UIImage()
        image.draw(in: CGRect(origin: CGPoint.zero, size: imageView.bounds.size))
        
        let rect = CGRect(origin: image.accessibilityFrame.origin, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
		
		return newImage!
    }
	
	public static func createBlackFilter(frame: CGRect, opacity: CGFloat) -> UIView {
		let filter = UIView()
		filter.frame = frame
		filter.backgroundColor = UIColor.black
		filter.alpha = opacity
		
		return filter
	}
}
