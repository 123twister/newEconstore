//
//  CartDetailsViewController.swift
//  eCONSTORE
//
//  Created by Jay Kaushal on 06/12/21.
//

import UIKit

class CartDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var imageUrl: String?
    var starRating: Int?
    var productName: String?
    var productPrice: Int?
    var productDetails: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tabBarController?.tabBar.isHidden = true

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartDetailsTableViewCell
        
        cell.productNameLbl.text = productName
        cell.productDetailsLbl.text = productDetails
        cell.productPriceLbl.text = "\(productPrice ?? 0).00 CAD"
        
        let newUrl = URL(string: "https://firebasestorage.googleapis.com/v0/b/econstore-7b317.appspot.com/o/Screenshot%202021-12-01%20at%2012.28.41%20AM.png?alt=media&token=4a1e8997-2dad-4f30-8cd0-9ea876f6c249")
        
        let imgUrl = URL(string: "\(imageUrl ?? "")") ?? newUrl
        if let data = try? Data(contentsOf: imgUrl! ) {
            DispatchQueue.main.async {
                cell.productImg.image = UIImage(data: data)
            }
        }
        
        if starRating == 1
        {
            cell.starImg.image = #imageLiteral(resourceName: "1star")
        }
        if starRating == 2
        {
            cell.starImg.image = #imageLiteral(resourceName: "2star")
        }
        if starRating == 3
        {
            cell.starImg.image = #imageLiteral(resourceName: "3star")
        }
        if starRating == 4
        {
            cell.starImg.image = #imageLiteral(resourceName: "4star")
        }
        if starRating == 5
        {
            cell.starImg.image = #imageLiteral(resourceName: "5star")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1230
    }
    

    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addCartBtn(_ sender: UIButton) {
    }
    
    @IBAction func wishlistBtn(_ sender: UIButton) {
    }
    
}
