//
//  ProfilePostCell.swift
//  song-swap
//
//  Created by Sravya Balasa on 6/4/21.
//

import UIKit

class ProfilePostCell: UITableViewCell {

    @IBOutlet var albumImage: UIImageView!
    @IBOutlet var songTitle: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var postUsername: UILabel!
    @IBOutlet var postCaption: UILabel!
    
    var spotifyURL: URL!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
