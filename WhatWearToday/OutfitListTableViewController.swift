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
    var managedContext : NSManagedObjectContext?
    var selectedRow : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView();
		
		let outfitRepository = OutfitRepository()
		do {
			try self.outfitList = outfitRepository.fetchAll()
		} catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
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
        cell?.outfitPhoto.image = UIImage(data: outfit.photo as! Data)

        return cell!
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.selectedRow = indexPath.row
        
        return indexPath
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.managedContext?.delete(outfitList[indexPath.row])
            outfitList.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
