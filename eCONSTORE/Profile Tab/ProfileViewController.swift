//
//  ProfileViewController.swift
//  eCONSTORE
//
//  Created by Dilpreet Singh on 03/12/21.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutBtn(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (_) in
            self.signOutUser()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func signOutUser() {
        do
        {
            try Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: "LOGGEDIN")
            self.tabBarController?.tabBar.isHidden = true
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "login") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        catch let error
        {
            print(error.localizedDescription)
        }
    }
    

}
