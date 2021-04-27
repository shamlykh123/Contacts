//
//  ViewModel.swift
//  User
//
//  Created by Shamly KH on 27/04/21.
//

import UIKit

class ViewModel: NSObject {
    var api: API? = nil
    var onData: (() -> Void)?
    private var userDetails = [UserInfo]()
    
    override init() {
        super.init()
        getUserInfo()
    }
    
    ///Fetch userinfo through API call
    func getUserInfo(){
        api = API( response: { [weak self](userList) in
            self?.userDetails = userList
            self?.onData?()
        })
    }
    
    ///Return userdetail count
    func cellCount() -> Int{
        return self.userDetails.count
    }
    
    ///Return userdetails using index
    func cellRowAtIndex(index: Int) -> UserInfo{
        return self.userDetails[index]
    }
    
    ///Delete row at index
    func deleteRowAtIndex(index: Int){
        self.userDetails.remove(at: index)
    }
    
    ///Insert/ update  data to userdata
    func insertAt(element : UserInfo, index: Int){
        self.userDetails[index] = element
    }

}
