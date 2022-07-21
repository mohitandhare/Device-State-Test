//
//  TableViewCell.swift
//  Device State Test
//
//  Created by Developer Skromanglobal on 18/07/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var label: UILabel!
 
    @IBOutlet weak var imagess: UIImageView!
    
    @IBOutlet weak var dim_value_image: UIImageView!
    
    @IBOutlet weak var Hard_Button_label: UILabel!
    
    
    var l_state_value : String!
    var confid_dim_value : String!
    var config_button_value : String!
    
    
    var test_fan : String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
