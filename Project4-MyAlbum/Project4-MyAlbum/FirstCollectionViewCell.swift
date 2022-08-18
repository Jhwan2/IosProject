//
//  FirstCollectionViewCell.swift
//  Project4-MyAlbum
//
//  Created by 이주환 on 2022/08/15.
//

import UIKit
import Photos

class FirstCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    var album: PHFetchResult<PHAsset>!
    
    
}
