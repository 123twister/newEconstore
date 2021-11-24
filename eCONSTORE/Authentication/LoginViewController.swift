//
//  LoginViewController.swift
//  eCONSTORE
//
//  Created by Jay Kaushal on 19/11/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTfView: UIView!
    @IBOutlet weak var passwordTfView: UIView!
    @IBOutlet weak var emailRf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTfView.layer.borderColor = UIColor(rgb: 0xE1E1E1).cgColor
        emailTfView.layer.borderWidth = 2
        passwordTfView.layer.borderColor = UIColor(rgb: 0xE1E1E1).cgColor
        passwordTfView.layer.borderWidth = 2
        
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
    }
    
    @IBAction func skipBtn(_ sender: UIButton) {
    }
    
    @IBAction func signUpBtn(_ sender: UIButton) {
    }
    
    @IBAction func forgotPasswordBtn(_ sender: UIButton) {
    }
}

// EXTENSION TO UICOLOR SO AS TO USE HEX COLOR CODE SCHEME

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
