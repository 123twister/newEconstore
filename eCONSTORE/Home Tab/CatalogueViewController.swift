//
//  CatalogueViewController.swift
//  eCONSTORE
//
//  Created by Yashas Bhadregowda on 02/12/21.
//

import UIKit
import Firebase
import SVProgressHUD

struct Catalogue {
    let title: String?
    let image: String?
}

class CatalogueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    
    @IBOutlet weak var tableView: UITableView!
    
    var catalogue: [Catalogue] = []
    var ref: CollectionReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ref = Firestore.firestore().collection("categories")
        
        tableView.delegate = self
        tableView.dataSource = self
        GetData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.isHidden = false
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catalogue.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tabBarController?.selectedIndex = 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CatalogueTableViewCell
        cell.titleLbl.text = catalogue[indexPath.row].title
        
        let imgUrl = URL(string: "\(catalogue[indexPath.row].image ?? "")")
        if let data = try? Data(contentsOf: imgUrl! ) {
            DispatchQueue.main.async {
                cell.typeImg.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    func GetData()
    {
        tableView.isHidden = true
        SVProgressHUD.show()
        ref.getDocuments { (snapshot, error) in
            if let error = error {
                // SHOW ERROR
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okBtn)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                // FETCHING DATA
                
                guard let snapshot = snapshot else { return }
                for documents in snapshot.documents {
                    SVProgressHUD.dismiss()
                    self.tableView.isHidden = false
                    let data = documents.data()
                    let title = data["title"] as? String ?? ""
                    let image = data["image"] as? String ?? ""
                    
                    let newCatalogue = Catalogue(title: title, image: image)
                    self.catalogue.append(newCatalogue)
                }
                self.tableView.reloadData()
            }
        }
    }
}

