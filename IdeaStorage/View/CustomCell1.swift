//
//  CustomCell1.swift
//  IdeaStorage
//
//  Created by 手塚友健 on 2020/11/16.
//

import UIKit

class CustomCell1: UITableViewCell {
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var amountOfNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        container.layer.cornerRadius = 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
