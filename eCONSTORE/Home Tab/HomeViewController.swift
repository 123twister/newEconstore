//
//  HomeViewController.swift
//  eCONSTORE
//
//  Created by Jay Kaushal on 02/12/21.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var catalogue: [Catalogue] = []
    var ref: CollectionReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Firestore.firestore().collection("categories")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        GetData()
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catalogue.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCatalogueCollectionViewCell
        
        cell.catalogueTitle.text = catalogue[indexPath.row].title
        
        let imgUrl = URL(string: "\(catalogue[indexPath.row].image ?? "")")
        if let data = try? Data(contentsOf: imgUrl! ) {
            DispatchQueue.main.async {
                cell.catalogueImg.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width:90, height: 90)
       }
    
    func GetData()
    {
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
                    let data = documents.data()
                    let title = data["title"] as? String ?? ""
                    let image = data["image"] as? String ?? ""
                    
                    let newCatalogue = Catalogue(title: title, image: image)
                    self.catalogue.append(newCatalogue)
                }
                self.collectionView.reloadData()
            }
        }
    }
    

}
