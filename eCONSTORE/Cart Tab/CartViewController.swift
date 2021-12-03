//
//  CartViewController.swift
//  eCONSTORE
//
//  Created by Jay Kaushal on 02/12/21.
//

import UIKit
import Firebase

struct Cart {
    let cdiscountPercentage: Int?
    let discountPercentage: Int?
    let discountedPrice: Int?
    let image: String?
    let rating: Int?
    let realPrice: Int?
    let title: String?
}

class CartViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let spacing:CGFloat = 15.0
    var cart: [Cart] = []
    var ref: CollectionReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Firestore.firestore().collection("shop")
        collectionView.delegate = self
        collectionView.dataSource = self
        GetData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cart.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CartCollectionViewCell
        
        let carts = cart[indexPath.row]
        
        cell.productName.text = carts.title
        
        if carts.rating == 1
        {
            cell.ratingImg.image = #imageLiteral(resourceName: "1star")
        }
        if carts.rating == 2
        {
            cell.ratingImg.image = #imageLiteral(resourceName: "2star")
        }
        if carts.rating == 3
        {
            cell.ratingImg.image = #imageLiteral(resourceName: "3star")
        }
        if carts.rating == 4
        {
            cell.ratingImg.image = #imageLiteral(resourceName: "4star")
        }
        if carts.rating == 5
        {
            cell.ratingImg.image = #imageLiteral(resourceName: "5star")
        }
        
        if carts.realPrice == 0 {
            cell.realPrice.isHidden = true
            cell.lineView.isHidden = true
            cell.discountPrice.textColor = .black
            cell.discountPrice.text = "$\(carts.discountedPrice ?? 0)"
        } else {
            cell.realPrice.isHidden = false
            cell.realPrice.text = "$\(carts.realPrice ?? 0)"
            cell.lineView.isHidden = false
            cell.discountPrice.textColor = .red
            cell.discountPrice.text = "$\(carts.discountedPrice ?? 0)"
        }
        
        return cell
        
    }
    
    func GetData()
    {
        collectionView.isHidden = true
        ref.getDocuments { (snapshot, error) in
            if let error = error {
                // SHOW ERROR
                
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okBtn)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                // FETCHING DATA
                
                guard let snapshot = snapshot else { return }
                for documents in snapshot.documents {
                    self.collectionView.isHidden = false
                    let data = documents.data()
                    
                    let title = data["title"] as? String ?? ""
                    let image = data["image"] as? String ?? ""
                    let cdiscountPercentage = data["cdiscountPercentage"] as? Int ?? 0
                    let discountPercentage = data["discountPercentage"] as? Int ?? 0
                    let discountedPrice = data["discountedPrice"] as? Int ?? 0
                    let rating = data["rating"] as? Int ?? 0
                    let realPrice = data["realPrice"] as? Int ?? 0
                    
                    let newCart = Cart(cdiscountPercentage: cdiscountPercentage, discountPercentage: discountPercentage, discountedPrice: discountedPrice, image: image, rating: rating, realPrice: realPrice, title: title)
                    self.cart.append(newCart)
                }
                self.collectionView.reloadData()
            }
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let numberOfItemsPerRow:CGFloat = 2
            let spacingBetweenCells:CGFloat = 15
            
            let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
            
            if let collection = self.collectionView {
                let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
                return CGSize(width: width, height: 250)
            } else {
                return CGSize(width: 0, height: 250)
            }
        }

}
