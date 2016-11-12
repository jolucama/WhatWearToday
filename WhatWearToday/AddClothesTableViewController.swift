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
        /*
        let imageData = UIImageJPEGRepresentation(previewImage.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        */
        let outfit = Outfit(
            title: self.pieceTitle.text!,
            type: self.type.text!,
            color: self.color.text!,
            season: self.season.titleForSegment(at: self.season.selectedSegmentIndex)!,
            pieceDescription: self.pieceDescripiton.text!,
            previewPhoto: nil
        )
        
        let managedContext = CoreDataManager.getManagedObjectContext()
        let entity =  NSEntityDescription.entity(forEntityName: OutfitManagedObject.entityName, in:managedContext)
        let outfitManagedObject = OutfitManagedObject(entity: entity!, insertInto: managedContext)
        outfitManagedObject.persist(object: outfit)
        
        do {
            try managedContext.save()
            //performSegue(withIdentifier: "goToMainView", sender: nil)
        } catch let error as NSError  {
            let alert = UIAlertController(title: "Error", message: "An error occured saving your object", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                //execute some code when this option is selected
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
