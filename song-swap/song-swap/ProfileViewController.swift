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
        loadFriends()
    }
    
    func loadPosts() {
        let query = PFQuery(className: "Posts")
        query.whereKey("author", equalTo: PFUser.current()!)
        query.order(byDescending: "createdAt")
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    func loadFriends() {
        let queryFollowing = PFQuery(className: "Friends")
        queryFollowing.whereKey("user", equalTo: PFUser.current()!)
        queryFollowing.findObjectsInBackground { users, error in
            if users != nil {
                self.followingCount.text = String((users! as [PFObject]).count)
            }
        }
        
        let queryFollowers = PFQuery(className: "Friends")
        queryFollowers.whereKey("friend", equalTo: PFUser.current()!)
        queryFollowers.findObjectsInBackground { users, error in
            if users != nil {
                self.followersCount.text = String((users! as [PFObject]).count)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ProfilePostCell
        UIApplication.shared.open(cell.spotifyURL)
        tableView.deselectRow(at: indexPath, animated: true)
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

        cell.spotifyURL = URL(string: (post["spotify_url"] as? String)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count;
    }
    
    @IBAction func onClickLogout(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        delegate.window?.rootViewController = loginViewController
    }
}
