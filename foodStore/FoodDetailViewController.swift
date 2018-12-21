//
//  FoodDetailViewController.swift
//  foodStore
//
//  Created by jbian on 12/13/18.
//  Copyright © 2018 Avantica. All rights reserved.
//

import UIKit

class FoodDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //
    @IBOutlet weak var rating: RatingControl!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Application loaded!!!")
        
        if let meal = meal {
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            rating.rating = meal.rating
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        print("Tab Gesture!!!!!")
        // call Image Library application same as  Intents of Android
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion:nil)
    }
    // cancel and hide the picker image
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // get selected image
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        // set image of my app
    photoImageView.image = selectedImage
        // hide image library
        dismiss(animated: true, completion: nil) 
        
    
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let button = sender as? UIBarButtonItem, button === saveButton {
            let name = nameTextField.text
            let photo = self.photoImageView.image
            let rating = self.rating.rating
            let id = meal != nil ? meal?.id:
                NSUUID().uuidString
            meal = Meal (id: id!, name: name!, photo: photo!, rating: rating)
        
        }else {
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
