//
//  PostCell.swift
//  song-swap
//
//  Created by Farnia Nafarifard on 6/3/21.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    var spotifyURL: URL!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onSpotifyButton(_ sender: Any) {
        UIApplication.shared.open(spotifyURL)
    }
    
}
