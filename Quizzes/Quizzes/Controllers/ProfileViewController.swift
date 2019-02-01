//
//  ProfileViewController.swift
//  Quizzes
//
//  Created by Aaron Cabreja on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private var defaultUser = ""
//        didSet{
//            updateUser()
//        }
//    }
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var buttonOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagePickerViewController()
        configureNavBarAndLabel()
    }
    private var imagePickerViewController: UIImagePickerController!
    private func showImagePickerController(){
        present(imagePickerViewController, animated: true, completion: nil)
    }
    
    private func setupImagePickerViewController(){
        imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            buttonOutlet.setImage(image, for: .normal)
        } else {
            print("original image is nil")
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func photoChange(_ sender: UIButton) {
        showImagePickerController()
    }
    private func configureNavBarAndLabel() {
        navigationItem.title = "Login"
        
        // RETRIEVE / RESTORE / FETCH / GET BACK VALUE FROM USER DEFAULTS
        if let defaultUser = UserDefaults.standard.object(forKey: UserDefaultKeys.userLogin) as? String {
            // WE HAVE A VALUE (E.G THE ZIP CODE OR CITY NAME ENTERED) FROM USER DEFAULTS
            updateUser()
            self.defaultUser = defaultUser
        } else {
            updateUser()
        }
    }
    private func updateUser(){
        if self.defaultUser == "" {
            let alertController = UIAlertController(title: "Default User", message: "Please enter a default User e.g Aaron", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let submitAction = UIAlertAction(title: "Submit", style: .default) { alert in
                // access textfield from the alertController
                guard let defaultSearch = alertController.textFields?.first?.text else {
                    print("alertController textfield is nil")
                    return
                }
                self.defaultUser = defaultSearch
                UserDefaults.standard.set(defaultSearch, forKey: UserDefaultKeys.userLogin)
                
                self.userLabel.text = "@\(defaultSearch)"
                
            }
            alertController.addTextField { (textfield) in
                textfield.placeholder = "enter a login name"
                textfield.textAlignment = .center
            }
            alertController.addAction(cancelAction)
            alertController.addAction(submitAction)
            present(alertController, animated: true)
        } else {
            self.defaultUser = UserDefaultKeys.userLogin
        }
     
    }
}
