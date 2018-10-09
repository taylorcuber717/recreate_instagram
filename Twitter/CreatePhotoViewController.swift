//
//  CreatePhotoViewController.swift
//  Twitter
//
//  Created by Taylor McLaughlin on 10/8/18.
//  Copyright © 2018 Taylor McLaughlin. All rights reserved.
//

import UIKit

class CreatePhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var takePhotoImageView: UIImageView!
    @IBOutlet weak var takePhotoLabel: UILabel!
    @IBOutlet weak var captionTextField: UITextField!
    @IBAction func postPhoto(_ sender: Any) {
        let caption = captionTextField.text ?? ""
        let image = takePhotoImageView.image
        Post.postUserImage(image: image, withCaption: caption) { (success, error) in
            if (error != nil) {
                print(error.debugDescription)
            }
        }
        tabBarController?.selectedIndex = 1
        
    }
    
    @IBAction func photoTapped(_ sender: Any) {
        
        takePhotoLabel.isHidden = true
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
            self.present(vc, animated: true, completion: nil)
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        takePhotoImageView.image = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    

}
