//
//  ForgotPasswordViewController.swift
//  eCONSTORE
//
//  Created by Jay Kaushal on 19/11/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTfView: UIView!
    @IBOutlet weak var emailTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTfView.layer.borderColor = UIColor(rgb: 0xE1E1E1).cgColor
        emailTfView.layer.borderWidth = 2
    }

    @IBAction func submitBtn(_ sender: UIButton) {
    }
    

}
