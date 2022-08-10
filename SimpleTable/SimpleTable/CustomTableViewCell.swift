//
//  CustomTableViewCell.swift
//  SimpleTable
//
//  Created by 이주환 on 2022/08/07.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var leftLable: UILabel!
    @IBOutlet var rightLable: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
