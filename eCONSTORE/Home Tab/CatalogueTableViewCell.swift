//
//  CatalogueTableViewCell.swift
//  eCONSTORE
//
//  Created by Yashas Bhadregowda on 02/12/21.
//

import UIKit

class CatalogueTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var typeImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
