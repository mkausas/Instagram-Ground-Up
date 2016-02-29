//
//  UserMedia.swift
//  Instagram
//
//  Created by Martynas Kausas on 2/23/16.
//  Copyright © 2016 martykausas. All rights reserved.
//

import Foundation
import Parse

class UserMedia: NSObject {
    /**
     * Other methods
     */
     
     /**
     Method to post user media to Parse by uploading image file
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let media = PFObject(className: "UserMedia")
        
        // Add relevant fields to the object
        media["media"] = getPFFileFromImage(image) // PFFile column type
        media["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        media["caption"] = caption
        media["likesCount"] = 0
        media["commentsCount"] = 0
        media["timestamp"] = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        
        // Save object (following function will save the object in Parse asynchronously)
        media.saveInBackgroundWithBlock(completion)
    }
    
    /**
     Method to post user media to Parse by uploading image file
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    class func getPost(objectId: String) {
        let query = PFQuery(className: "UserMedia")
        query.getObjectInBackgroundWithId(objectId) {
            (userMedia: PFObject?, error: NSError?) -> Void in
            if error == nil {
                print(userMedia)
            } else {
                print(error)
            }
        }
    }
    
    class func getPosts(completion: (posts: [PFObject]?, error: NSError?) -> ()) {
        let query = PFQuery(className: "UserMedia")
        query.addDescendingOrder("createdAt")
        query.includeKey("author")
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                print("success retrieving posts!")
                completion(posts: posts, error: nil)
            } else {
                print("Error fetching posts: \(error.debugDescription)")
                completion(posts: nil, error: error)
            }
        }
    }
}