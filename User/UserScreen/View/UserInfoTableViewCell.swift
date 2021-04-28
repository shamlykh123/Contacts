//
//  UserInfoTableViewCell.swift
//  User
//
//  Created by Shamly KH on 27/04/21.
//

import UIKit
import Alamofire

class UserInfoTableViewCell: UITableViewCell {
    var clickAction: ((_ cell: UserInfoTableViewCell) -> Void)?
    var titleLabel: UILabel?

    var cellInfo:UserInfo? {
        didSet {
            userName.text = "\(cellInfo?.first_name ?? "")  \(cellInfo?.last_name ?? "")"
            emailId.text = cellInfo?.email
            
            if let url = URL(string: cellInfo?.avatar ?? "") {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    DispatchQueue.main.async { /// execute on main thread
                        self.titleLabel?.removeFromSuperview()
                        self.userImage?.image = nil
                        self.userImage?.cornerRadius = (self.userImage?.frame.height)! / 2
                        if(self.tag % 2 != 0){
                     
                        self.userImage?.image = UIImage(data: data)
                        }else{
                            self.titleLabel?.removeFromSuperview()
                            self.titleLabel = UILabel(frame: CGRect(x: 20, y: 20, width: self.userImage.frame.width , height: 30))
                            
                            let first = self.cellInfo?.first_name?.first?.description ?? ""
                            let second = self.cellInfo?.last_name?.first?.description ?? ""
                            let name =  first.capitalized + second.capitalized
                            self.titleLabel?.text = name
                            self.titleLabel?.textColor = UIColor.black
                            self.titleLabel?.font = UIFont(name:"chalkboard SE", size: 18)
                            self.userImage.addSubview(self.titleLabel!)
                           // self.textToImage(drawText: "cvbb", inImage: UIImage(data: data)!, atPoint: CGPoint(x: 10.0, y: 10.0))
                        }
                    }
                }
                
                task.resume()
            }
        }
    }
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var emailId: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}
