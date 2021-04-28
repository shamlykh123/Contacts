//
//  DetailViewController.swift
//  User
//
//  Created by Shamly KH on 27/04/21.
//

import UIKit

class DetailViewController: UIViewController {
    var viewModel = DetailViewModel()
    var onSave: ((UserInfo,Int) -> Void)?

    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    var titleLabel: UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.titleLabel?.removeFromSuperview()
            self.userImage?.image = nil
            self.userEmail.text = self.viewModel.userInfo?.email
            self.userName.text = "\(self.viewModel.userInfo?.first_name ?? "")  \(self.viewModel.userInfo?.last_name ?? "")"
            self.userImage?.cornerRadius = (self.userImage?.frame.height)! / 2
            if(self.viewModel.index! % 2 == 0){
                self.titleLabel?.removeFromSuperview()
                self.titleLabel = UILabel(frame: CGRect(x: 40, y: 40, width: self.userImage.frame.width , height: 30))
                let first = self.viewModel.userInfo?.first_name?.first?.description ?? ""
                let second = self.viewModel.userInfo?.last_name?.first?.description ?? ""
                let name =  first.capitalized + second.capitalized
                self.titleLabel?.text = name
                self.titleLabel?.textColor = UIColor.black
                self.titleLabel?.font = UIFont(name:"chalkboard SE", size: 18)
                self.userImage.addSubview(self.titleLabel!)
            }else{
                self.userImage.image = self.viewModel.imageView?.image
                self.userName.delegate = self
            }
            
            
        }
        // Do any additional setup after loading the view.
    }
    
    /// User tapped save, will send updated info
    func saveTapped(){
        if let  name = userName.text?.split(whereSeparator: {$0 == " "}).map(String.init){
            viewModel.userInfo?.first_name = name.first
            viewModel.userInfo?.last_name = name.last
        }
        self.dismiss(animated: true) {
            self.onSave?(self.viewModel.userInfo!,self.viewModel.index ?? 0)

        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /*
    // MARK: - IBAction
    */
    @IBAction func didTapSave(_ sender: Any) {
        saveTapped()
    }
}
//Textfield Delegate
extension DetailViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textfield: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}
