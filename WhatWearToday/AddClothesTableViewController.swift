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
    var colorSelected : String? = ""
    
    let typesOutfit = ["Dress", "Hat", "Trousers", "Necklace", "Sunglasses", "Shoes"]
    let colorOutfit = ["AliceBlue","AntiqueWhite","Aqua","Aquamarine","Azure","Beige","Bisque","Black","BlanchedAlmond","Blue","BlueViolet","Brown","BurlyWood","CadetBlue","Chartreuse"]
    
    var outfitList = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.type.text = "";
        self.color.text = "";
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
        
        var managedObjectContext = CoreDataManager.getManagedObjectContext()
        // Create Entity
        let entity = NSEntityDescription.entity(forEntityName: Outfit.entityName, in: managedObjectContext)
        
        // Initialize Record
        let record = Outfit(entity: entity!, insertInto: managedObjectContext)
        record.title = self.pieceTitle.text!
        record.type =  self.type.text!
        record.color = self.color.text!
        record.season = self.season.titleForSegment(at: self.season.selectedSegmentIndex)!
        record.pieceDescription = self.pieceDescripiton.text!
        record.photo = NSData(data: UIImageJPEGRepresentation(self.previewImage.image!, 1.0)!)
        
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
        self.color.text = self.colorSelected;
    }
    
}
