//
//  LoginViewController.swift
//  song-swap
//
//  Created by Simonne Contreras on 5/12/21.
//

import UIKit

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        SpotifyAPICaller.client.login(sender)
        self.performSegue(withIdentifier: "loginToHome", sender: self)
    }
    
}
