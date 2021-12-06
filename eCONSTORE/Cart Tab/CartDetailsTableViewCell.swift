//
//  CartDetailsTableViewCell.swift
//  eCONSTORE
//
//  Created by Jay Kaushal on 06/12/21.
//

import UIKit

class CartDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImg: UIImageView!
    
    @IBOutlet weak var starImg: UIImageView!
    
    @IBOutlet weak var productNameLbl: UILabel!
    
    @IBOutlet weak var productPriceLbl: UILabel!
    
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    
    @IBOutlet weak var productDetailsLbl: UILabel!
    
    var colors = [UIColor]()
    let size = ["XS", "S", "M", "L", "XL", "XXL"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        colorCollectionView.delegate = self
        sizeCollectionView.delegate = self
        colorCollectionView.dataSource = self
        sizeCollectionView.dataSource = self
        
        colors.append(UIColor.red)
        colors.append(UIColor.blue)
        colors.append(UIColor.black)
        colors.append(UIColor.green)
        colors.append(UIColor.gray)
        colors.append(UIColor.systemPink)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CartDetailsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == colorCollectionView)
        {
            return colors.count
        } else {
            return size.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let colorCell = colorCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CartDetailsColorCollectionViewCell
        
        colorCell.colorView.backgroundColor = colors[indexPath.row]
        
        if(collectionView == sizeCollectionView) {
            
            let sizeCell = sizeCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CartDetailsSizeCollectionViewCell
            
            sizeCell.sizeLbl.text = size[indexPath.row]
            sizeCell.sizeView.layer.borderColor = UIColor(rgb: 0xE1E1E1).cgColor
            sizeCell.sizeView.layer.borderWidth = 1
            
            return sizeCell
        }
        
        return colorCell
    }
    
    
}
