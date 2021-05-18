//
//  CreatePostViewController.swift
//  song-swap
//
//  Created by Sravya Balasa on 5/17/21.
//

import UIKit

class CreatePostViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Find a Song"
        // Do any additional setup after loading the view.
    }
    
    func loadSongs() {
        let URL = "https://api.spotify.com/v1/search"
        // authorization param?
        let myParams = ["q": searchBar.text!,
                        "type":"track",
                        "limit":50] as [String : Any]
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
