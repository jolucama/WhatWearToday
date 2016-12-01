//
//  Array.swift
//  WhatWearToday
//
//  Created by jlcardosa on 01/12/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import Foundation


extension Array {
	mutating func extractRamdonItem() -> Element? {
		if (self.count == 0) {
			return nil
		}
		let index = Int(arc4random_uniform(UInt32(self.count)))
		let element = self[index]
		self.remove(at: index)
		return element
	}
}
