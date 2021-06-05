//
//  AddFriendsViewController.swift
//  song-swap
//
//  Created by Tiffany Meng on 6/3/21.
//

import UIKit
import Parse

class AddFriendsViewController: UIViewController,
    UISearchBarDelegate,
    UITableViewDelegate,
    UITableViewDataSource, UIAdaptivePresentationControllerDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var tableItems = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Find a Friend"
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor.clear
        tableView.keyboardDismissMode = .onDrag
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (searchBar.text != nil) {
            loadFriendSuggestions();
        }
    }
    
    func loadFriendSuggestions() {
        let query = PFUser.query()
        query?.whereKey("username", contains: searchBar.text)
        query?.findObjectsInBackground { (users, error) in
                    if users != nil {
                        self.tableItems = users!
                        self.tableView.reloadData()
                    }
                }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddFriendsTableViewCell") as! AddFriendsTableViewCell
        
        
        let user = tableItems[indexPath.row] as! PFUser
        
        cell.username.text = user.username
    
        if(user["profilePicture"] != nil)  {
            let imageFile = user["profilePicture"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            cell.userPhoto.af.setImage(withURL: url)
        } else {
            cell.userPhoto.image = nil
        }
        
        cell.userPhoto.layer.masksToBounds = true
        cell.userPhoto.layer.cornerRadius = cell.userPhoto.bounds.width / 2
        cell.userPhoto.layer.borderWidth = 3
        cell.userPhoto.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        
        let query = PFQuery(className: "Friends")
        query.whereKey("user", equalTo: PFUser.current()!)
        query.whereKey("friend", equalTo: user)
        query.findObjectsInBackground { (friends, error) in
                    if friends != [] {
                        cell.addButton.setTitle("Friends", for: .normal)
                        cell.addButton.backgroundColor = UIColor.systemGreen
                        cell.addButton.isEnabled = false
                        cell.unfriendButton.isHidden = false
                    } else {
                        cell.addButton.setTitle("Add Friend", for: .normal)
                        cell.addButton.backgroundColor = UIColor.systemBlue
                        cell.addButton.isEnabled = true
                        cell.unfriendButton.isHidden = true
                    }
        }
        
        cell.addButton.layer.cornerRadius = 15
        cell.unfriendButton.layer.cornerRadius = 15
        
        cell.user = user
        
        return cell
    }
    
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didAddFriends"),
                                      object: nil)
    }
    
}
