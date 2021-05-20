//
//  CreatePostViewController.swift
//  song-swap
//
//  Created by Sravya Balasa on 5/17/21.
//

import UIKit
import Alamofire

class CreatePostViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Find a Song"
        searchBar.delegate = self
    }
    
    func loadSongs() {
        let URL = "https://api.spotify.com/v1/search"

        let defaults = UserDefaults.standard
        let accessToken = defaults.object(forKey: "access_token")
        let headers : HTTPHeaders = ["Authorization" : "Bearer \(accessToken!)",
                                     "Content-Type" : "application/x-www-form-urlencoded"]

        let parameters = ["q": searchBar.text!,
                        "type":"track",
                        "limit":50] as [String : Any]
        
        AF.request(URL, method: .get, parameters: parameters, headers: headers).responseJSON { response in
            print(response.result)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (searchBar.text != nil) {
            loadSongs()
        }
    }
}
