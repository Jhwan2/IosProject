//
//  CustomTableViewCell.swift
//  WeatherToday
//
//  Created by 이주환 on 2022/08/09.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var img: UIImageView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var rainLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
