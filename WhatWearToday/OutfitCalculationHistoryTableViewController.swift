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
		
		cell.setNeedsLayout()
		cell.layoutIfNeeded()
		
		let outfitCalculationHistory = self.outfitCalculationHistory[indexPath.row]
		
		cell.titleCalculation.text = outfitCalculationHistory.title
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = DateFormatter.Style.full
		cell.dateCalculation.text = dateFormatter.string(from: outfitCalculationHistory.date as! Date)
		
		self.setOutfitImagesWithLabelFallback(cell: cell, outfits: outfitCalculationHistory.outfits!)
		self.customizeImages(cell: cell)
		
		if (selectedIndex == indexPath.row) {
			UIView.animate(withDuration: 0.5, animations: {
				cell.selector.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
			})
		}
		
        return cell
    }
	
	private func setOutfitImagesWithLabelFallback(cell: OutfitCalculationHistoryTableViewCell,outfits: NSSet) {
		var headwear1Filled = false
		var upperBody1Filled = false
		for case let outfit as Outfit in outfits {
			
//			
//			
//			if (outfit?.typePart == Int16(type.rawValue)) {
//				if (outfit?.photo != nil) {
//					outfitView.image = UIImage(data: outfit?.photo as! Data)
//				} else {
//					cell.expandableResultView.createUILabelInTheCenter(frame: outfitView.frame, withText: (outfit?.title)!, ofSize: 10.0)
//				}
//			} else {
//				cell.expandableResultView.createUILabelInTheCenter(frame: outfitView.frame, withText: "No Results", ofSize: 10.0)
//			}
//			
//			
//			
//			
//			
//			
//			if (outfit.typePart == Int16(Outfit.TypeParts.Headwear.rawValue) && headwear1Filled == false) {
//				self.setImageWithLabelFallback(forCell: cell, outfitView: cell.expandableResultView.headwear1, outfit: outfit,type: Outfit.TypeParts.Headwear)
//				headwear1Filled = true
//			} else (outfit.typePart == Int16(Outfit.TypeParts.Headwear.rawValue) && headwear1Filled == true) {
//				
//			}
//			self.setImageWithLabelFallback(forCell: cell, outfitView: cell.expandableResultView.legs, outfit: outfit,type: Outfit.TypeParts.Legs)
			self.setImageWithLabelFallback(forCell: cell, outfitView: cell.expandableResultView.footwear, outfit: outfit,type: Outfit.TypeParts.Footwear)
		}
	}
	
	private func setImageWithLabelFallback(forCell cell: OutfitCalculationHistoryTableViewCell, outfitView: UIImageView, outfit: Outfit?, type: Outfit.TypeParts) {
		if (outfit != nil && outfit?.typePart == Int16(type.rawValue)) {
			if (outfit?.photo != nil) {
				outfitView.image = UIImage(data: outfit?.photo as! Data)
			} else {
				cell.expandableResultView.createUILabelInTheCenter(frame: outfitView.frame, withText: (outfit?.title)!, ofSize: 10.0)
			}
		} else {
			cell.expandableResultView.createUILabelInTheCenter(frame: outfitView.frame, withText: "No Results", ofSize: 10.0)
		}
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if (selectedIndex == indexPath.row) {
			return 480
		} else {
			return 75
		}
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if (selectedIndex == indexPath.row) {
			selectedIndex = -1
		} else {
			selectedIndex = indexPath.row
		}
		tableView.beginUpdates()
		tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
		tableView.endUpdates()
	}
	
	private func customizeImages(cell: OutfitCalculationHistoryTableViewCell) {
		ViewModifier.round(withUIImageView: cell.expandableResultView.headwear1)
		ViewModifier.round(withUIImageView: cell.expandableResultView.headwear2)
		ViewModifier.round(withUIImageView: cell.expandableResultView.upperBody1)
		ViewModifier.round(withUIImageView: cell.expandableResultView.upperBody2)
		ViewModifier.round(withUIImageView: cell.expandableResultView.legs)
		ViewModifier.round(withUIImageView: cell.expandableResultView.footwear)
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
