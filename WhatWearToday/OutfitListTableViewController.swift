//
//  OutfitListTableViewController.swift
//  WhatWearToday
//
//  Created by jlcardosa on 11/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit
import CoreData

class OutfitListTableViewController: UITableViewController {

    var outfitList = [NSManagedObject]()
    var outfitRepository : OutfitRepository!
    var selectedRow : Int?
	var noOutfitLabel : UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView();
		
		self.outfitRepository = OutfitRepository()
		do {
			try self.outfitList = self.outfitRepository.fetchByDescendingDate()
		} catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
		self.showHideNoOutfitLabel()
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
        return outfitList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OutfitUITableViewCell", for: indexPath) as? OutfitUITableViewCell

        let outfit = self.outfitList[indexPath.row] as! Outfit
        cell?.outfitTitle!.text = outfit.title
        switch Outfit.Season(rawValue: Int(outfit.season))! {
            case Outfit.Season.SpringAutumn:
                cell?.outfitSeason.text = "Sprint/Autum"
            case Outfit.Season.Summer:
                cell?.outfitSeason.text = "Summer"
            case Outfit.Season.Winter:
                cell?.outfitSeason.text = "Winter"
        }
		if (outfit.photo != nil) {
			cell?.outfitPhoto.image = UIImage(data: outfit.photo as! Data)
		}

        return cell!
    }
	
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
	
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.selectedRow = indexPath.row
        
        return indexPath
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
			self.outfitRepository.delete(outfit: outfitList[indexPath.row] as! Outfit)
            outfitList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
			self.showHideNoOutfitLabel()
        }
    }
	
	override func didMove(toParentViewController parent: UIViewController?) {
		super.didMove(toParentViewController: parent)
		
		parent?.navigationItem.leftBarButtonItem = self.editButtonItem
		parent?.setEditing(true, animated: true)
	}

	private func showHideNoOutfitLabel() {
		if self.outfitList.count != 0 {
			self.tableView.backgroundView = nil
		} else {
			self.noOutfitLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
			self.noOutfitLabel?.text = "No Outfits"
			self.noOutfitLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 30)
			self.noOutfitLabel?.textColor = UIColor.darkGray
			self.noOutfitLabel?.textAlignment = .center
			tableView.backgroundView = self.noOutfitLabel
			tableView.separatorStyle = .none
		}
	}
	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editOutfitSegue",
            self.isEditing == true,
            self.selectedRow != nil,
            let addTableViewController = segue.destination as? AddClothesTableViewController {
                let selectedOutfit = outfitList[self.selectedRow!] as! Outfit
                addTableViewController.updateOutfit = selectedOutfit
        }
    }

}
