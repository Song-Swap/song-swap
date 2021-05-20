//
//  LoginViewController.swift
//  song-swap
//
//  Created by Simonne Contreras on 5/12/21.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onLoginButton(_ sender: Any) {
        let parameters = ["client_id" : "6f136c586d624386a2700f8b8127c012",
                          "client_secret" : "850f3952b3fa41d79d1fff03ef6eed45",
                          "grant_type" : "client_credentials"]

        AF.request("https://accounts.spotify.com/api/token", method: .post, parameters: parameters).responseJSON(completionHandler: {
            response in
            switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any] {
                        let defaults = UserDefaults.standard
                        print(json["access_token"]!)
                        defaults.setValue(json["access_token"], forKey: "access_token")
                        self.performSegue(withIdentifier: "loginToHome", sender: self)
                    }
                case .failure(let error):
                    print(error)
            }
        })
    }
    
}
