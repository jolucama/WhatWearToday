//
//  AddClothesTableViewController.swift
//  WhatWearToday
//
//  Created by J on 30/08/16.
//  Copyright © 2016 Cardosa. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class AddClothesTableViewController: UITableViewController,
                                     UIImagePickerControllerDelegate,
                                     UINavigationControllerDelegate {

    @IBOutlet weak var pieceTitle: UITextField!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var season: UISegmentedControl!
    @IBOutlet weak var pieceDescripiton: UITextView!
    @IBOutlet weak var previewImage: UIImageView!
    
    var typeSelected : String? = ""
	var typeSelectedEnum : Outfit.Types?
    var colorSelected : String? = ""
    
    let typesOutfit = Outfit.Types.allValuesRaw
    let colorOutfit = ["Black", "White", "Red", "Lime", "Blue", "Yellow", "Cyan", "Aqua", "Magenta", "Fuchsia", "Silver", "Gray", "Maroon", "Olive", "Green", "Purple", "Teal", "Navy"]

    var updateOutfit : Outfit? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.type.text = "";
        self.color.text = "";
        
        if updateOutfit != nil {
            self.title = "Update " + (updateOutfit?.title)!
            self.pieceTitle.text = updateOutfit?.title
            self.type.text = updateOutfit?.type
            self.color.text = updateOutfit?.color
            self.season.selectedSegmentIndex = Int((updateOutfit?.season)!)
            self.pieceDescripiton.text = updateOutfit?.pieceDescription
            self.previewImage.image = UIImage(data: updateOutfit?.photo as! Data)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        previewImage.image = image
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func addPhoto(_ sender: UIButton, forEvent event: UIEvent) {
        
        /*
         OPEN THE CAMERA (JUST WITH REAL DEVICES)
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        */
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveObject(_ sender: AnyObject) {
        
        let managedObjectContext = CoreDataManager.getManagedObjectContext()
        
        var record : Outfit
        if self.updateOutfit != nil {
            record = managedObjectContext.object(with: (self.updateOutfit?.objectID)!) as! Outfit
        } else {
            // Create Entity
            let entity = NSEntityDescription.entity(forEntityName: Outfit.entityName, in: managedObjectContext)
            
            // Initialize Record
            record = Outfit(entity: entity!, insertInto: managedObjectContext)
        }
		
        record.title = self.pieceTitle.text!
        record.type =  self.type.text!
		record.typePart = Int16((self.typeSelectedEnum?.getTypePart().rawValue)!)
        record.color = self.color.text!
        record.season = Int16(self.season.selectedSegmentIndex)
        record.pieceDescription = self.pieceDescripiton.text!
		if (self.previewImage.image != nil) {
			record.photo = NSData(data: UIImageJPEGRepresentation(self.previewImage.image!, 1.0)!)
		} else {
			record.photo = nil
		}
        
        do {
            try managedObjectContext.save()
            performSegue(withIdentifier: "backToListOutfit", sender: self)
        } catch let error as NSError  {
            let alert = UIAlertController(title: "Error", message: "An error occured saving your object", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                NSLog("%@", error);
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTypeOutfitSegue",
            let typeOutfitTableViewController = segue.destination as? TypeOutfitTableViewController {
            typeOutfitTableViewController.titleInNavigation = "Type"
            typeOutfitTableViewController.typeList = "type"
            typeOutfitTableViewController.values = self.typesOutfit
        }
        if segue.identifier == "goToColorOutfitSegue",
            let typeOutfitTableViewController = segue.destination as? TypeOutfitTableViewController {
            typeOutfitTableViewController.titleInNavigation = "Color"
            typeOutfitTableViewController.typeList = "color"
            typeOutfitTableViewController.values = self.colorOutfit
        }
    }
    
    @IBAction func backFromDetailsType(segue:UIStoryboardSegue) {
        self.type.text = self.typeSelected;
		self.typeSelectedEnum = Outfit.Types(rawValue: self.typeSelected!)
        self.color.text = self.colorSelected;
    }
    
}
