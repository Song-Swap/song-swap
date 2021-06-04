//
//  AddFriendsTableViewCell.swift
//  song-swap
//
//  Created by Tiffany Meng on 6/3/21.
//

import UIKit
import Parse

class AddFriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var unfriendButton: UIButton!
    
    var user: PFUser!
    
    @IBAction func onAddButton(_ sender: Any) {
        let friend = PFObject(className: "Friends")
        friend["user"] = PFUser.current()
        friend["friend"] = user
        
        friend.saveInBackground{ (success, error) in
                    if success {
                        self.addButton.setTitle("Friends", for: .normal)
                        self.addButton.backgroundColor = UIColor.systemGreen
                        self.unfriendButton.isHidden = false
                        self.addButton.isEnabled = false
                    } else {
                    }
                }
    }
    
    @IBAction func onUnfriend(_ sender: Any) {
        let query = PFQuery(className: "Friends")
        query.whereKey("user", equalTo: PFUser.current())
        query.whereKey("friend", equalTo: user)
        
        query.findObjectsInBackground { (friends:[PFObject]?, error) in
            PFObject.deleteAll(inBackground: friends)
        }
        
        self.unfriendButton.isHidden = true
        self.addButton.setTitle("Add Friend", for: .normal)
        self.addButton.backgroundColor = UIColor.systemBlue
        self.addButton.isEnabled = true
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
