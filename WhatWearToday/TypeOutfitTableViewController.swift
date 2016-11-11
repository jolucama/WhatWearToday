//
//  TypeOutfitTableViewController.swift
//  WhatWearToday
//
//  Created by jlcardosa on 09/11/2016.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit

class TypeOutfitTableViewController: UITableViewController {

    var titleInNavigation: String?
    var values: [String] = []
    var typeList: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.title = self.titleInNavigation;
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
        return self.values.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "typeCell", for: indexPath) 

        cell.textLabel?.text = self.values[indexPath.item]
        // Configure the cell...

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToAddOutfitSegue",
            let addClothesTableViewController = segue.destination as? AddClothesTableViewController ,
            let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedValue = self.values[indexPath.row]
            if self.typeList == "type" {
                addClothesTableViewController.typeSelected = selectedValue;
            } else if self.typeList == "color" {
                addClothesTableViewController.colorSelected = selectedValue;
            }
        }
    }

}
