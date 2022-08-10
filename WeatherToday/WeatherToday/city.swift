//
//  city.swift
//  WeatherToday
//
//  Created by 이주환 on 2022/08/09.
//

import Foundation


//    {
//       "city_name":"베를린",
//       "state":12,
//       "celsius":10.8,
//       "rainfall_probability":60
//    }


struct City: Codable {
    let cityName: String
    let state: Int
    let celsius: Double
    let rainfallProbability: Int
    
    var TempString: String {
        return "섭씨 " + String(self.celsius) + "도" + "/화씨 " + String(format: "%.1f", self.celsius*9/5+32) + "도"
    }
    var rainfallString: String {
        return "강수확률 " + String(self.rainfallProbability) + "%"
    }
        
    enum CodingKeys: String, CodingKey {
    case cityName = "city_name"
    case rainfallProbability = "rainfall_probability"
    case state,celsius
    }
}
