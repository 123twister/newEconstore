//
//  OneCardViewController.swift
//  eCONSTORE
//
//  Created by Jay Kaushal on 03/12/21.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD

class OneCardViewController: UIViewController {

    @IBOutlet weak var oneCardImg: UIImageView!
    
    @IBOutlet weak var conestogaIdView: UIView!
    @IBOutlet weak var conestogaIdTxt: UITextField!
    @IBOutlet weak var conestogaIdErrLol: UILabel!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var nameErrLbl: UILabel!
    
    let imagePicker = UIImagePickerController()
    var ref = DatabaseReference.init()
    var reff: CollectionReference!
    var number = 0
    let uid = UserDefaults.standard.string(forKey: "UID")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabBarController?.tabBar.isHidden = true
        ref = Database.database().reference()
        reff = Firestore.firestore().collection("users")
        
        conestogaIdView.layer.borderColor = UIColor(rgb: 0xE1E1E1).cgColor
        conestogaIdView.layer.borderWidth = 2
        nameView.layer.borderColor = UIColor(rgb: 0xE1E1E1).cgColor
        nameView.layer.borderWidth = 2
        
        conestogaIdErrLol.isHidden = true
        nameErrLbl.isHidden = true
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(OneCardViewController.openGallery(tapGesture:)))
        oneCardImg.isUserInteractionEnabled = true
        oneCardImg.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func openGallery(tapGesture: UITapGestureRecognizer)
    {
        self.setUpImagePicker()
    }

    @IBAction func submitBtn(_ sender: UIButton) {
        SVProgressHUD.show()
        
        if (conestogaIdTxt.text == "") || (nameTxt.text == "") || (conestogaIdTxt.text?.count ?? 0 < 7) || (conestogaIdTxt.text?.count ?? 0 > 7){
            SVProgressHUD.dismiss()
            conestogaIdErrLol.isHidden = false
            nameErrLbl.isHidden = false
            
        } else {
            SVProgressHUD.dismiss()
            conestogaIdErrLol.isHidden = true
            nameErrLbl.isHidden = true
            
            reff = Firestore.firestore().collection("onecard")
            reff.getDocuments { (snapshot, error) in
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
                        let name = data["name"] as? String ?? ""
                        let onecardID = data["onecardID"] as? String ?? ""
                        
                        if (self.conestogaIdTxt.text == onecardID) && (self.nameTxt.text == name) {
                            
                            self.saveData()
                            self.updateShopData()
                            self.navigationController?.popViewController(animated: true)
                        } else {
                            let alert = UIAlertController(title: "Error", message: "Please fill in your proper details.", preferredStyle: .alert)
                            let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
                            alert.addAction(okBtn)
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    }
                }
            }
           
            
        }
        
        
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func saveData()
    {
        self.uploadImage(self.oneCardImg.image!) { url in
            self.saveImage(name: self.nameTxt.text ?? "", cID: self.conestogaIdTxt.text ?? "", profileURL: url!){ success in
                if success != nil {
                    print("Success")
                }
                
            }
        }
    }
    
    func updateShopData()
    {
        let db = Firestore.firestore()
        
        db.collection("shop").document("0yjxvJwNpSxziKkSce6Z").setData(["realPrice": 120], merge: true)
        db.collection("shop").document("9h8BC37BKQ5z92bpTdQb").setData(["realPrice": 120], merge: true)
        db.collection("shop").document("Ad6L99yRaEsCgNmndcd3").setData(["realPrice": 120], merge: true)
        db.collection("shop").document("Omxm1jw7fGgZJNdxFNEg").setData(["realPrice": 120], merge: true)
        db.collection("shop").document("bB9ZqdM0UT8nUoIoRROQ").setData(["realPrice": 120], merge: true)
        db.collection("shop").document("eQVjOWbi49wY7l1xxdw7").setData(["realPrice": 120], merge: true)
        db.collection("shop").document("gaSCNWJsgo0LbV8gfZDx").setData(["realPrice": 120], merge: true)
        db.collection("shop").document("ie0Wy0ETIZScwDI6x3qh").setData(["realPrice": 120], merge: true)
        db.collection("shop").document("vriAUHFv2nfYWqvHUDpD").setData(["realPrice": 120], merge: true)
    }
    
    }

extension OneCardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func setUpImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.delegate = self
            imagePicker.isEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        oneCardImg.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    func uploadImage(_ image: UIImage, completion: @escaping((_ url: URL?) -> ())) {
        
        number = number + 1
        
        let storageRef = Storage.storage().reference().child("ONECARD\(number).png")
        let imgData = (oneCardImg.image?.pngData())!
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData, metadata: metaData) { (metadata, error) in
            if let error = error {
                // Fetch Error
                print(error.localizedDescription)
            } else {
                storageRef.downloadURL { (url, error) in
                    completion(url)
                }
            }
        }
    }
    
    func saveImage(name: String, cID: String, profileURL: URL, completion: @escaping((_ url: URL?) -> ()))
    {
        let dict = ["profileURL": profileURL.absoluteString, "onecard": conestogaIdTxt.text ?? "", "name": nameTxt.text ?? ""] as [String: Any]
        let db = Firestore.firestore()
        
        self.ref.child("onecard").childByAutoId().setValue(dict)
        reff.getDocuments { (snapshot, error) in
            if let error = error {
                // SHOW ERROR

                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okBtn)
                self.present(alert, animated: true, completion: nil)

            } else {
                // FETCHING DATA

                guard let snapshot = snapshot else { return }
                for documents in snapshot.documents{
                    let data = documents.data()
                    let userUid = data["uid"] as? String ?? ""

                    if self.uid == userUid {
                        db.collection("users").document("b49yJuPNWmqJK0gxNgT6").setData(dict, merge: true)
                }
            }
        }
    }

}
}
