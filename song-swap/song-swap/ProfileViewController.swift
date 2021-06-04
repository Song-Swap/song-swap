//
//  ProfileViewController.swift
//  song-swap
//
//  Created by Sravya Balasa on 6/4/21.
//

import UIKit
import AlamofireImage
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet var followersCount: UILabel!
    @IBOutlet var followingCount: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    
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
