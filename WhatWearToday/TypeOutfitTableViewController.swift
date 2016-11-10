//
//  TypeOutfitTableViewController.swift
//  WhatWearToday
//
//  Created by jlcardosa on 09/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit

class TypeOutfitTableViewController: UITableViewController {

    let typesOutfit = ["Dress", "Hat", "Trousers", "Necklace", "Sunglasses", "Shoes"]
    var selectedRow: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return typesOutfit.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "typeCell", for: indexPath) 

        cell.textLabel?.text = typesOutfit[indexPath.item]
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.item
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToAddOutfitSegue" {
            let addClothesNavigationController = segue.destination as? UINavigationController
            let addClothesTableViewController = addClothesNavigationController?.topViewController as? AddClothesTableViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            addClothesTableViewController?.toPass = typesOutfit[(indexPath?.row)!]
        }
    }

}
