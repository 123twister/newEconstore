//
//  WishlistViewController.swift
//  eCONSTORE
//
//  Created by Sudhir Dhameliya on 02/12/21.
//

import UIKit

class WishlistViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.isHidden = false
    }
    
}
