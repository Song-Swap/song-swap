//
//  CreatePostViewController.swift
//  song-swap
//
//  Created by Sravya Balasa on 5/17/21.
//

import UIKit
import Alamofire
import AlamofireImage

class CreatePostViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var tableItems = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Find a Song"
        searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor.clear;
        tableView.keyboardDismissMode = .onDrag
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

            switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any] {
                        self.tableItems = (json["tracks"] as! NSDictionary)["items"] as! [NSDictionary]
                        print(self.tableItems)
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (searchBar.text != nil) {
            loadSongs()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected cell")
        performSegue(withIdentifier: "createToIndividual", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let destinationVC = segue.destination as? PostViewController else {return}
            let selectedRow = indexPath.row
            destinationVC.item = tableItems[selectedRow]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreatePostTableViewCell") as! CreatePostTableViewCell
        
        let songInfo = tableItems[indexPath.row]

        let albumImageURL = URL(string:((songInfo["album"] as! NSDictionary)["images"] as! [NSDictionary])[1]["url"] as! String)!
        cell.albumImage.af.setImage(withURL: albumImageURL)
        cell.songTitle.text = (songInfo["name"] as! String)

        let artists = songInfo["artists"] as! [NSDictionary]
        let artistsText = artists.map({(artist) -> String in
            return (artist["name"] as? String ?? "")
        })
        cell.songArtist.text = artistsText.joined(separator: ", ")
        
        cell.spotifyURL = URL(string: (songInfo["external_urls"] as! NSDictionary)["spotify"] as! String)

        return cell
    }
    
}
