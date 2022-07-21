//
//  SecondTableViewCell.swift
//  Device State Test
//
//  Created by Developer Skromanglobal on 21/07/22.
//

import UIKit

class SecondTableViewCell: UITableViewCell {

    @IBOutlet weak var Test_Image: UIImageView!
    
    var test_image_value : String!
    
    @IBOutlet weak var fan_label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
