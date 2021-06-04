//
//  LoginViewController.swift
//  song-swap
//
//  Created by Simonne Contreras on 5/12/21.
//

import UIKit
import Alamofire
import Parse

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { (success, error) in
            if success{
                self.performSegue(withIdentifier: "signUpToSetup", sender: nil)
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                let parameters = ["client_id" : "6c3984f1051543b280ec9a840492850c",
                                  "client_secret" : "b7d3fa0e55564dd1a086a1b053222bd0",
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
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
        

    }
    
    
    
}
