//
//  UserInfoItem.swift
//  User
//
//  Created by Shamly KH on 27/04/21.
//

import UIKit
///Model used to hold data
struct UserInfo: Codable{
    var id: Int?
    var email: String?
    var first_name: String?
    var last_name: String?
    var avatar: String?
}
