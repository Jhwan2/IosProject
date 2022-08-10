//
//  country.swift
//  WeatherToday
//
//  Created by 이주환 on 2022/08/08.
//

import Foundation
import UIKit

//{"korean_name":"한국","asset_name":"kr"}
struct Country: Codable  {
    let koreanName: String
    let assetName: String
    
//    guard; let ImageAsset: NSDataAsset = NSDataAsset(name:assetName)!; else { return }
    
    enum CodingKeys: String, CodingKey {
    case assetName = "asset_name"
    case koreanName = "korean_name"
    }
    
}


