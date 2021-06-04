//
//  FriendViewController.swift
//  song-swap
//
//  Created by Tiffany Meng on 6/3/21.
//

import UIKit
import Parse
import Alamofire
import AlamofireImage

class FriendViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var friends = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //query friends table for friends of current user
        let query = PFQuery(className: "Friends")
        let user_id = PFUser.current()
        query.includeKey("user")
        query.includeKey("friend")
        query.whereKey("user", equalTo: user_id!)
        
        //save query to friends array
        query.findObjectsInBackground { (friends, error) in
                    if friends != nil {
                        self.friends = friends!
                        self.collectionView.reloadData()
                    }
            }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCollectionViewCell", for: indexPath) as! FriendCollectionViewCell
        
        let friendObject = friends[indexPath.item]
        let friend = friendObject["friend"] as! PFUser

        cell.username.text = friend.username
        
        if(friend["profilePicture"] != nil)  {
            let imageFile = friend["profilePicture"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            cell.userImage.af.setImage(withURL: url)
        } else {
            cell.userImage.image = nil
        }
        
        cell.userImage.layer.masksToBounds = true
        cell.userImage.layer.cornerRadius = cell.userImage.bounds.width / 2
        cell.userImage.layer.borderWidth = 3
        cell.userImage.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        
        return cell
    }

    @IBAction func onAddFriends(_ sender: Any) {
        self.performSegue(withIdentifier: "addFriendsModal", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
