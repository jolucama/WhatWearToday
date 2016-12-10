//
//  OutfitCalculationHistoryTableViewController.swift
//  WhatWearToday
//
//  Created by jlcardosa on 06/12/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit

class OutfitCalculationHistoryTableViewController: UITableViewController {

	var outfitCalculationHistory: [OutfitCalculationHistory] = []
	var selectedIndex = -1
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.tableView.tableFooterView = UIView();

		let outfitCalculationHistoryRepository = OutfitCalculationHistoryRepository()
		outfitCalculationHistoryRepository.setLimit(limit: 100)
		outfitCalculationHistoryRepository.orderBy(key: "date", ascending: false)
		do {
			self.outfitCalculationHistory = try outfitCalculationHistoryRepository.fetch() as! [OutfitCalculationHistory]
		} catch let error as Error {
			//TODO Complete with error handling
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.outfitCalculationHistory.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: OutfitCalculationHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellOutfitCalculationHistory", for: indexPath) as! OutfitCalculationHistoryTableViewCell
		
		let outfitCalculationHistory = self.outfitCalculationHistory[indexPath.row]
		//cell.titleCalculation.text = outfitCalculationHistory.title
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = DateFormatter.Style.full
		cell.dateCalculation.text = dateFormatter.string(from: outfitCalculationHistory.date as! Date)
		
		cell.expandableResultView.headwear1.image = UIImage(named: "hoodie.jpg")
		cell.expandableResultView.headwear2.image = UIImage(named: "hoodie.jpg")
		cell.expandableResultView.legs.image = UIImage(named: "hoodie.jpg")
		
		/*
		var title = "| "
		for outfit in outfitCalculationHistory.outfits! {
			title += (outfit as! Outfit).title! + " | "
		}
		*/
		
        return cell
    }

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if (selectedIndex == indexPath.row) {
			return 480
		} else {
			return 75
		}
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let cell: OutfitCalculationHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellOutfitCalculationHistory", for: indexPath) as! OutfitCalculationHistoryTableViewCell
		
		UIView.animate(withDuration: 0.25, animations:{
			cell.selector.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
		})
		
//		if cell.selector.layer.animation(forKey: "com.whatweartoday.app") == nil {
//			let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
//			rotationAnimation.fromValue = 0.0
//			rotationAnimation.toValue = Float(M_PI * 2.0)
//			rotationAnimation.duration = 1
//			rotationAnimation.repeatCount = Float.infinity
//			cell.selector.layer.add(rotationAnimation, forKey: "com.whatweartoday.app")
//		}
//		
		if (selectedIndex == indexPath.row) {
			selectedIndex = -1
		} else {
			selectedIndex = indexPath.row
		}
		tableView.beginUpdates()
		tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
		tableView.endUpdates()
	}
	
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
