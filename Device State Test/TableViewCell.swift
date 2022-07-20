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
    
    
    var L1 : String!
    var L2 : String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
