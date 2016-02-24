//
//  PostHeaderTableViewCell.swift
//  Instagram
//
//  Created by Martynas Kausas on 2/24/16.
//  Copyright © 2016 martykausas. All rights reserved.
//

import UIKit

class PostHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
