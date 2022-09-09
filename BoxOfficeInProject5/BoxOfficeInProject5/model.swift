//
//  model.swift
//  BoxOfficeInProject5
//
//  Created by 이주환 on 2022/09/02.
//

import Foundation

//struct APIResponse: Codable{
//    let results: [movie]
//}

struct movie: Codable{
    
    let grade: Int
    let thumb: String
    let reservationGrade: Int
    let title: String
    let reservationRate: Double
    let userRating: Double
    let date: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
    case grade, thumb, title, date, id
    case reservationGrade = "reservation_grade"
    case reservationRate = "reservation_rate"
    case userRating = "user_rating"
    }
}

struct Movies: Codable{
    
    let orderType: Int
    let movies: [movie]
    
    enum CodingKeys: String, CodingKey {
    case movies
    case orderType = "order_type"
    }
}


//{
//    order_type:1,
//    movies:
//    [
//        {
//            grade: 12,
//       thumb:"http://movie.phinf.naver.net/20171201_181/1512109983114kcQVl_JPEG/movie_image.
//            jpg?type=m99_141_2",
//            reservation_grade: 1,
//            title: "신과함께-죄와벌",
//            reservation_rate: 35.5,
//            user_rating: 7.98,
//            date: "2017-12-20",
//            id: "5a54c286e8a71d136fb5378e"
//        },
//        {
//            grade: 12,
//       thumb:"http://movie2.phinf.naver.net/20170925_296/150631600340898aUX_JPEG/movie_image
//            .jpg?type=m99_141_2",
//            reservation_grade: 2,
//            title: "저스티스 리그",
//            reservation_rate: 12.63,
//            user_rating: 7.8,
//            date: "2017-11-15",
//            id: "5a54c1e9e8a71d136fb5376c"
//        }
//    ]
// }
