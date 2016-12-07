//
//  AddPostVC.swift
//  MyHood
//
//  Created by Patrick Robertson on 6/12/16.
//  Copyright © 2016 Patrick Robertson. All rights reserved.
//

import UIKit

class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var descField: UITextField!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postImg.layer.cornerRadius = 120
        
        imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self

    }
    
    @IBAction func addPicBtnPressed(_ sender: Any) {
        (sender as AnyObject).setTitle("", for: .normal)
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func makePostBtnPressed(_ sender: Any) {
        if let title = titleField.text, let desc = descField.text, let img = postImg.image {
            
            let imgPath = DataService.instance.saveImageAndCreatePath(img)
            
            let post = Post(imagePath: imgPath, title: title, postDescription: desc)
            
            DataService.instance.addPost(post: post)
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imagePicker.dismiss(animated: true, completion: nil)
        postImg.image = selectedImage
    }
    
}
