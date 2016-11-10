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
    
    var toPass : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.type.text = self.toPass;
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
        
        let imageData = UIImageJPEGRepresentation(previewImage.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        
        let outfit = Clothes(
            title: self.pieceTitle.text!,
            type: self.type.text!,
            color: self.color.text!,
            season: self.season.titleForSegment(at: self.season.selectedSegmentIndex)!,
            pieceDescription: self.pieceDescripiton.text!,
            previewPhoto: self.previewImage.image!
        )
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entity(forEntityName: "Clothes", in:managedContext)
        
        let outfitDAO = NSManagedObject(entity: entity!, insertInto: managedContext)
        outfitDAO.setValue(outfit.title, forKey: "title");
        outfitDAO.setValue(outfit.type, forKey: "type");
        outfitDAO.setValue(outfit.color, forKey: "color");
        outfitDAO.setValue(outfit.season, forKey: "season");
        outfitDAO.setValue(outfit.pieceDescription, forKey: "pieceDescription");
        
        do {
            try managedContext.save()
            
            performSegue(withIdentifier: "goToMainView", sender: nil)
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}
