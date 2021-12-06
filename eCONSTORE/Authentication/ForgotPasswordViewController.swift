//
//  ForgotPasswordViewController.swift
//  eCONSTORE
//
//  Created by Jay Kaushal on 19/11/21.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTfView: UIView!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var emailErrorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTfView.layer.borderColor = UIColor(rgb: 0xE1E1E1).cgColor
        emailTfView.layer.borderWidth = 2
        emailErrorLbl.isHidden = true
        
        emailTf.delegate = self
    }

    @IBAction func submitBtn(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        let email = emailTf.text ?? ""
        if (email == "") {
            SVProgressHUD.dismiss()
            emailErrorLbl.isHidden = false
        } else {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    SVProgressHUD.dismiss()
                    let alertController = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
                    let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    
                    alertController.addAction(okBtn)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    SVProgressHUD.dismiss()
                    let alertController = UIAlertController(title: "Success", message: "Link sent successfully to the registered email address.", preferredStyle: .alert)
                    let okBtn = UIAlertAction(title: "Ok", style: .default) { alert in
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "login") as! LoginViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                    alertController.addAction(okBtn)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTf.resignFirstResponder()
        
        return true
    }
}
