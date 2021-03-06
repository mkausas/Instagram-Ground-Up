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
    var refreshControl: UIRefreshControl!

    var posts: [PFObject]? //: [PFObject]!
    
    let postTableViewCellIdentifier = "com.martykausas.PostTableViewCell"
    let postHeaderTableViewCellIdentifier = "com.martykausas.PostHeaderTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewSetup()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        grabData()
    }
    
    func grabData() {
        UserMedia.getPosts { (posts, error) -> () in
            if error == nil {
                self.posts = posts
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableViewSetup() {
        
        // implement pull to refresh
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        grabData()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 448.0; // set to whatever your "average" cell height is
        
        let cellNib = UINib(nibName: "PostTableViewCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(cellNib, forCellReuseIdentifier: postTableViewCellIdentifier)
        
        let headerNib = UINib(nibName: "PostHeaderTableViewCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(headerNib, forHeaderFooterViewReuseIdentifier: postHeaderTableViewCellIdentifier)
    }

    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        grabData()
        refreshControl.endRefreshing()
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
        let cell = tableView.dequeueReusableCellWithIdentifier(postTableViewCellIdentifier, forIndexPath: indexPath) as! PostTableViewCell
        
        cell.postDetails = posts![indexPath.section]
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let author = posts![section].valueForKey("author")?.username
        return author!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let posts = posts {
            return posts.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(44)
    }
    
    

    
}
