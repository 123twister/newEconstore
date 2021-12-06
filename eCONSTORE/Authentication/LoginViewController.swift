//
//  LoginViewController.swift
//  eCONSTORE
//
//  Created by Lovepreet Singh Sandhu on 19/11/21.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate {

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
        emailRf.delegate = self
        passwordTf.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if  UserDefaults.standard.bool(forKey: "LOGGEDIN") == true {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "homeTab")
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
                    UserDefaults.standard.set(true, forKey: "LOGGEDIN")
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "homeTab")
                    self.navigationController?.pushViewController(vc, animated: true)
                    let uid = Auth.auth().currentUser?.uid ?? ""
                    UserDefaults.standard.setValue(uid, forKey: "UID")
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailRf.resignFirstResponder()
        passwordTf.resignFirstResponder()
        
        return true
    }
}


