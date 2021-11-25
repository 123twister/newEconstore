//
//  SignUpViewController.swift
//  eCONSTORE
//
//  Created by Jay Kaushal on 19/11/21.
//

import UIKit
import FirebaseAuth
import Firebase
import SVProgressHUD

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTfView: UIView!
    @IBOutlet weak var emailTfView: UIView!
    @IBOutlet weak var passwordTfView: UIView!
    @IBOutlet weak var confirmPasswordTfView: UIView!
    
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var confirmPasswordTf: UITextField!
    
    @IBOutlet weak var nameErrorLbl: UILabel!
    @IBOutlet weak var emailErrorLbl: UILabel!
    @IBOutlet weak var passwordErrorLbl: UILabel!
    @IBOutlet weak var confirmPasswordLbl: UILabel!
    
    
    @IBAction func nameTfChanged(_ sender: UITextField) {
        if nameTf.text == "" {
            nameErrorLbl.isHidden = false
        } else {
            nameErrorLbl.isHidden = true
        }
    }
    
    @IBAction func emailTfChanged(_ sender: Any) {
        if ((emailTf.text == "") || (isValidEmail(emailTf.text ?? "") == false)) {
            emailErrorLbl.isHidden = false
        } else {
            emailErrorLbl.isHidden = true
        }

    }
    
    @IBAction func passwordTfChanged(_ sender: Any) {
        if ((passwordTf.text == "") || (isPasswordValid(passwordTf.text ?? "") == false)) {
            passwordErrorLbl.isHidden = false
        } else {
            passwordErrorLbl.isHidden = true
        }

    }
    
    @IBAction func confirmPassTfChanged(_ sender: Any) {
        if nameTf.text == "" {
            confirmPasswordLbl.isHidden = false
        } else {
            confirmPasswordLbl.isHidden = true
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTfView.layer.borderColor = UIColor(rgb: 0xE1E1E1).cgColor
        nameTfView.layer.borderWidth = 2
        emailTfView.layer.borderColor = UIColor(rgb: 0xE1E1E1).cgColor
        emailTfView.layer.borderWidth = 2
        passwordTfView.layer.borderColor = UIColor(rgb: 0xE1E1E1).cgColor
        passwordTfView.layer.borderWidth = 2
        confirmPasswordTfView.layer.borderColor = UIColor(rgb: 0xE1E1E1).cgColor
        confirmPasswordTfView.layer.borderWidth = 2
        
        nameErrorLbl.isHidden = true
        emailErrorLbl.isHidden = true
        passwordErrorLbl.isHidden = true
        confirmPasswordLbl.isHidden = true
    }

    @IBAction func signUpBtn(_ sender: UIButton) {
        
        let name = nameTf.text
        let email = emailTf.text
        let password = passwordTf.text
        let confirmPassword = confirmPasswordTf.text
        
        if ((name == "") || (email == "") || (password == "") || (confirmPassword == "")){
            let alertController = UIAlertController(title: "Alert", message: "Please enter all the information", preferredStyle: .alert)
            let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alertController.addAction(okBtn)
            present(alertController, animated: true, completion: nil)
        } else {
            SVProgressHUD.show()
            // CREATING USER LOGIN ACCOUNT AND SAVING THE INFORMATION INTO DATABASE
            Auth.auth().createUser(withEmail: email ?? "", password: password ?? "") { (result, error) in
                
                // HANDLING ERRORS
                if let error = error {
                    SVProgressHUD.dismiss()
                    let alertController = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
                    let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    
                    alertController.addAction(okBtn)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    
                    let db = Firestore.firestore()
                    
                    // SAVING THE USER INFORMATION IN DATABASE
                    db.collection("users").addDocument(data: ["name": name ?? "", "email": email ?? "", "password": password ?? "", "uid": result?.user.uid ?? ""]) { (error) in
                        
                        // HANDLING ERRORS
                        if error != nil {
                            SVProgressHUD.dismiss()
                            let alertController = UIAlertController(title: "Alert", message: "There was a problem while submitting information.", preferredStyle: .alert)
                            let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
                            
                            alertController.addAction(okBtn)
                            self.present(alertController, animated: true, completion: nil)
                        } else {
                            SVProgressHUD.dismiss()
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "login") as! LoginViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func skipBtn(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "homeTab")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "login") as! LoginViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // FOR PASSWORD VALIDATION
    public func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@","^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8,}$")
        return passwordTest.evaluate(with: password)
    }

    // FOR EMAIL VALIDATION
    public func isValidEmail(_ email: String) -> Bool {
        let emailTest = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailTest)
        return emailPred.evaluate(with: email)
    }
    
}
