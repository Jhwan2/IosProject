//
//  UserInformation.swift
//  SignUp_Project
//
//  Created by 이주환 on 2022/08/01.
//

import Foundation
import UIKit

class UserInformation{
    static let shared: UserInformation = UserInformation()
    
    var id: String?
    var pw: String?
    var Number: String?
    var Image: UIImage?
    var selfIntroduce: String?
    var birthday: String?
    
}
