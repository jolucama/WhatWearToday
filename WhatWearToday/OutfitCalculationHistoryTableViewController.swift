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
		
		cell.cleanValuesAdded()
		
		cell.setNeedsLayout()
		cell.layoutIfNeeded()
		
		let outfitCalculationHistory = self.outfitCalculationHistory[indexPath.row]
		cell.titleCalculation.text = (outfitCalculationHistory.title == "") ? "No Title" : outfitCalculationHistory.title
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = DateFormatter.Style.full
		cell.dateCalculation.text = dateFormatter.string(from: outfitCalculationHistory.date as! Date)
		
		if (selectedIndex == indexPath.row) {
			cell.customizeImages()
			cell.setOutfitImagesWithLabelFallback(outfits: outfitCalculationHistory.outfits!)
			UIView.animate(withDuration: 0.5, animations: {
				cell.selector.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
			})
		}
		
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
		if (selectedIndex == indexPath.row) {
			selectedIndex = -1
		} else {
			selectedIndex = indexPath.row
		}
		tableView.beginUpdates()
		tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
		tableView.endUpdates()
	}
	
    @IBAction func leftBarButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "goToMainViewController", sender: sender)
    }
}
