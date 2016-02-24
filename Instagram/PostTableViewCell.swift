//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by Martynas Kausas on 2/24/16.
//  Copyright © 2016 martykausas. All rights reserved.
//

import UIKit
import Parse
import AFNetworking

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    
    var postDetails: PFObject! {
        didSet {
            if let userPicture = postDetails.valueForKey("media") {
                userPicture.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                    if error == nil {
                        print("successfully retrieved post image")
                        self.postImageView.image = UIImage(data: imageData!)
                        
                    } else {
                        print("error retrieving post image")
                    }
                    
                    }, progressBlock: { (progress: Int32) -> Void in
                        
                })
            }
            
            
            
            descriptionLabel.text = postDetails
            .valueForKey("caption") as? String
            likeCountLabel.text = "\(postDetails.valueForKey("likesCount") as! Int) likes"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
