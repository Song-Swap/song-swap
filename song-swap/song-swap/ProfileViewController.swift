//
//  ProfileViewController.swift
//  song-swap
//
//  Created by Sravya Balasa on 6/4/21.
//

import UIKit
import AlamofireImage
import Parse

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet var followersCount: UILabel!
    @IBOutlet var followingCount: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    var posts = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageFile = PFUser.current()?["profilePicture"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!

        profilePicture.af.setImage(withURL: url)
        profilePicture.layer.masksToBounds = true
        profilePicture.layer.cornerRadius = profilePicture.bounds.width / 2
        profilePicture.layer.borderWidth = 3
        profilePicture.layer.borderColor = UIColor.black.cgColor
        
        self.navigationItem.title = "@" + (PFUser.current()?.username)!
        usernameLabel.text = "@" + (PFUser.current()?.username)!
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadPosts()
    }
    
    func loadPosts() {
        let query = PFQuery(className: "Posts")
        query.whereKey("author", equalTo: PFUser.current()!)
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfilePostCell") as! ProfilePostCell

        let post = posts[indexPath.row]
        cell.postUsername.text = PFUser.current()?.username
        cell.postCaption.text = post["caption"] as? String
        cell.artistLabel.text = post["artist"] as? String
        cell.songTitle.text = post["song_title"] as? String

        let songURL = URL(string:(post["URL"] as! String))!
        cell.albumImage.af.setImage(withURL: songURL)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count;
    }
    
}
