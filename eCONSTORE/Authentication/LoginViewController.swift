//
//  LoginViewController.swift
//  eCONSTORE
//
//  Created by Jay Kaushal on 19/11/21.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTfView: UIView!
    @IBOutlet weak var passwordTfView: UIView!
    @IBOutlet weak var emailRf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    
    @IBOutlet weak var emailErrorLbl: UILabel!
    @IBOutlet weak var passwordErrorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTfView.layer.borderColor = UIColor(rgb: 0xE1E1E1).cgColor
        emailTfView.layer.borderWidth = 2
        passwordTfView.layer.borderColor = UIColor(rgb: 0xE1E1E1).cgColor
        passwordTfView.layer.borderWidth = 2
        
        emailErrorLbl.isHidden = true
        passwordErrorLbl.isHidden = true
        
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        
        SVProgressHUD.show()
        let email = emailRf.text ?? ""
        let password = passwordTf.text ?? ""
        
        if ((email == "") || (password == "")) {
            SVProgressHUD.dismiss()
            emailErrorLbl.isHidden = false
            passwordErrorLbl.isHidden = false
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    SVProgressHUD.dismiss()
                    let alertController = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
                    let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    
                    alertController.addAction(okBtn)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    SVProgressHUD.dismiss()
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "homeTab")
                    self.view.window?.rootViewController = vc
                    self.view.window?.makeKeyAndVisible()
                }

            }
        }
    }
    
    @IBAction func skipBtn(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "homeTab")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signUpBtn(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "signup") as! SignUpViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func forgotPasswordBtn(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "forgotpassword") as! ForgotPasswordViewController
        navigationController?.pushViewController(vc, animated: true)
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
