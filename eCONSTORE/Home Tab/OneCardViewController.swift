//
//  OneCardViewController.swift
//  eCONSTORE
//
//  Created by Jay Kaushal on 03/12/21.
//

import UIKit
import Firebase
import FirebaseDatabase

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
    var number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        
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
        
        saveData()
    }
    
    func saveData()
    {
        self.uploadImage(self.oneCardImg.image!) { url in
            self.saveImage(name: "OneCard", profileURL: url!){ success in
                if success != nil {
                    print("Success")
                }
                
            }
        }
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
    
    func saveImage(name: String, profileURL: URL, completion: @escaping((_ url: URL?) -> ()))
    {
        let dict = ["profileURL": profileURL.absoluteString] as [String: Any]
        self.ref.child("onecard").childByAutoId().setValue(dict)
    }
}
