//
//  PostsViewController.swift
//  Twitter
//
//  Created by Taylor McLaughlin on 10/8/18.
//  Copyright © 2018 Taylor McLaughlin. All rights reserved.
//

import UIKit
import Parse

class PostsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var postTableView: UITableView!
    var refreshController: UIRefreshControl!
    
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTableView.dataSource = self
        postTableView.rowHeight = UITableViewAutomaticDimension
        postTableView.estimatedRowHeight = 300

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postTableView.dequeueReusableCell(withIdentifier: "postCell") as! PostCell
        let post = posts[indexPath.row]
        cell.indexPath = indexPath
        if let imageFile : PFFile = post.media {
            imageFile.getDataInBackground { (data, error) in
                if (error != nil) {
                    print(error.debugDescription)
                }
                else {
                    cell.postImageView.image = UIImage(data: data!)
                }
            }
        }
        cell.captionLabel.text = post.caption
        
        return cell
    }
    
    func fetchPostsData() {
        
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.includeKey("createdAt")
        query?.limit = 20
        
        // Fetch data asynchronously
        query?.findObjectsInBackground(block: { (posts, error) in
            if let posts = posts {
                self.posts = posts as! [Post]
                self.postTableView.reloadData()
                self.refreshController.endRefreshing()
            }
            else {
                print(error.debugDescription)
            }
        })
        
    }

}
