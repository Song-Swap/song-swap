//
//  CreatePostTableViewCell.swift
//  song-swap
//
//  Created by Sravya Balasa on 5/29/21.
//

import UIKit

class CreatePostTableViewCell: UITableViewCell {

    @IBOutlet var albumImage: UIImageView!
    @IBOutlet var songTitle: UILabel!
    @IBOutlet var songArtist: UILabel!
    
    var spotifyURL: URL!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialize()
    }
    
    func initialize() {
        let backgroundView = UIView()
        backgroundView.frame = CGRect(
            x: self.frame.minX + 10,
            y: self.frame.minY - 10,
            width: self.frame.width - 20,
            height: self.frame.height - 20)
        self.contentView.insertSubview(backgroundView, at: 0)
        
        backgroundView.backgroundColor = UIColor.white
        backgroundView.layer.cornerRadius = 15
        
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 3, height: 3)
        backgroundView.layer.shadowOpacity = 0.7
        backgroundView.layer.shadowRadius = 4.0
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func onSpotifyIconClick(_ sender: Any) {
        UIApplication.shared.open(spotifyURL)
    }
}
