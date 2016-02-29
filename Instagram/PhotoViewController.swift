//
//  PhotoViewController.swift
//  Instagram
//
//  Created by Martynas Kausas on 2/23/16.
//  Copyright © 2016 martykausas. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UINavigationControllerDelegate {

    var imagePickerController: UIImagePickerController!
    var postImage: UIImage?

    
    @IBOutlet weak var captionTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(imagePickerController, animated: true, completion: nil)
        
    }

    
    @IBAction func onPostImage(sender: AnyObject) {
        UserMedia.postUserImage(postImage, withCaption: captionTextField.text) { (success: Bool, error: NSError?) -> Void in
            if success {
                print("success posting image!")
            } else {
                print("error posting image!")
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension PhotoViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            imagePickerController.dismissViewControllerAnimated(true, completion: nil)
            
            postImage = editedImage
            
//            UserMedia.postUserImage(postImage, withCaption: <#T##String?#>, withCompletion: <#T##PFBooleanResultBlock?##PFBooleanResultBlock?##(Bool, NSError?) -> Void#>)
            
    }
}