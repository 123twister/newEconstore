//
//  ViewController.swift
//  eCONSTORE
//
//  Created by Jay Kaushal on 18/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        animate(images: [ UIImage(named: "kurta")!, UIImage(named: "tshirt")!, UIImage(named: "startedNew")!])
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
    
    // FOR SHOWCASING DIFFERENT IMAGES WITH ANIMATIONS
    
    func animate(images: [UIImage], index: Int = 0) {
        UIView.transition(with: imgView, duration: 2, options: .transitionCrossDissolve, animations: {
            self.imgView.image = images[index]
            }, completion: { value in
                let idx = index == images.count-1 ? 0 : index+1
                self.animate(images: images, index: idx)
        })
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

