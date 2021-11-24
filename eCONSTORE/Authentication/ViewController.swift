//
//  ViewController.swift
//  eCONSTORE
//
//  Created by Jay Kaushal on 18/11/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if  UserDefaults.standard.bool(forKey: "STARTED") == true{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "login") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }

    @IBAction func startBtn(_ sender: UIButton) {
        
        UserDefaults.standard.set(true, forKey: "STARTED")
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "login") as! LoginViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

