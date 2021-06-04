//
//  PostViewController.swift
//  song-swap
//
//  Created by Simonne Contreras on 6/3/21.
//

import UIKit
import Alamofire
import AlamofireImage
import Parse

class PostViewController: UIViewController, UITextViewDelegate {
    
    var item: NSDictionary = NSDictionary()
    @IBOutlet weak var SongTitle: UILabel!
    @IBOutlet weak var Artist: UILabel!
    @IBOutlet weak var AlbumCover: UIImageView!
    @IBOutlet weak var Comment: UITextView!
    @IBOutlet weak var postButton: RoundButton!

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
        Comment.delegate = self
        Comment.text = "Add a caption... "
        Comment.textColor = UIColor.lightGray
    }
    

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Add a caption... "
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPost(_ sender: RoundButton) {
        let post = PFObject(className: "Posts")
        if Comment.text! == "Add a caption... " {
            post["caption"] = ""
        } else {
            post["caption"] = Comment.text!
        }
        post["author"] = PFUser.current()!
        post["song_title"] = SongTitle.text!
        post["artist"] = Artist.text!
        post["URL"] = ((item["album"] as! NSDictionary)["images"] as! [NSDictionary])[1]["url"] as! String

        post.saveInBackground{ (success, error) in
            if success {
                if let first = self.presentingViewController,
                    let second = first.presentingViewController {
                            first.view.isHidden = true
                                second.dismiss(animated: true)
                 }
            } else {
                print("error!")
            }
        }
    }
}
