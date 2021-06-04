//
//  PostViewController.swift
//  song-swap
//
//  Created by Simonne Contreras on 6/3/21.
//

import UIKit
import Alamofire
import AlamofireImage

class PostViewController: UIViewController {
    
    var item: NSDictionary = NSDictionary()
    @IBOutlet weak var SongTitle: UILabel!
    @IBOutlet weak var Artist: UILabel!
    @IBOutlet weak var AlbumCover: UIImageView!
    @IBOutlet weak var Comment: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let artists = item["artists"] as! [NSDictionary]
        let artistsText = artists.map({(artist) -> String in
            return (artist["name"] as? String ?? "")
        })
        Artist?.text = artistsText.joined(separator: ", ")
        
        SongTitle?.text = (item["name"] as! String)
        
        let albumImageURL = URL(string:((item["album"] as! NSDictionary)["images"] as! [NSDictionary])[1]["url"] as! String)!
        AlbumCover?.af.setImage(withURL: albumImageURL)
    }

}
