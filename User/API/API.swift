//
//  API.swift
//  User
//
//  Created by Shamly KH on 27/04/21.
//

import UIKit
import Alamofire

class API: NSObject {
    var onData :(([UserInfo]) -> Void)?
    private var userDetails = [UserInfo]()
    private let url = "https://reqres.in/api/users"
    
    init(response: @escaping (([UserInfo]) -> Void)) {
        super.init()
        self.onData = response
        getData()
    }
    
    ///Call api to get user details
    private func getData(){
        let param = ["Content-Type" : "application/json","Accept" : "application/json"]
        _ = AF.request(url, encoding: JSONEncoding.default, headers: HTTPHeaders(param)).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                if let jsonResp = value as? [String: Any] {
                    let userDict = jsonResp["data"] as! [[String: Any]]
                    for user in userDict{
                        if  let jsonData =  try? JSONSerialization.data(withJSONObject: user){
                            if let userInfo = try? JSONDecoder().decode(UserInfo.self, from: jsonData){
                                self.userDetails.append(userInfo)
                            }
                        }
                    }
                    print(self.userDetails)
                    self.onData?(self.userDetails)
                }
                
            case .failure( _):
                self.onData?(self.userDetails)
            }
        }
    }
}

