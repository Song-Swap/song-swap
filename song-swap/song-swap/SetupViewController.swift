//
//  SetupViewController.swift
//  song-swap
//
//  Created by Sravya Balasa on 6/4/21.
//

import UIKit
import Parse

class SetupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text =  "@" + (PFUser.current()?.username)!
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSaveSetup(_ sender: Any) {
        let currentUser = PFUser.current()!

        let imageData = profilePicture.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        currentUser["profilePicture"] = file
        
        currentUser.saveInBackground { success, error in
            if success {
                self.performSegue(withIdentifier: "setupToHome", sender: nil)
            } else {
                print(error!)
            }
        }
    }
    
    @IBAction func onAddProfilePicture(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        profilePicture.image = scaledImage
        dismiss(animated: true, completion: nil)
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
