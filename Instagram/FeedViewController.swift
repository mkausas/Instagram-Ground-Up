//
//  FeedViewController.swift
//  Instagram
//
//  Created by Martynas Kausas on 2/24/16.
//  Copyright © 2016 martykausas. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [3, 2, 1] //: [PFObject]!
    
    let postTableViewCellIdentifier = "com.martykausas.PostTableViewCell"
    let postHeaderTableViewCellIdentifier = "com.martykausas.PostHeaderTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 448.0; // set to whatever your "average" cell height is


        let cellNib = UINib(nibName: "PostTableViewCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(cellNib, forCellReuseIdentifier: postTableViewCellIdentifier)
        
        let headerNib = UINib(nibName: "PostHeaderTableViewCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(headerNib, forHeaderFooterViewReuseIdentifier: postHeaderTableViewCellIdentifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(postTableViewCellIdentifier, forIndexPath: indexPath) as! PostTableViewCell
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Header"
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(44)
    }
    
    

    
}
