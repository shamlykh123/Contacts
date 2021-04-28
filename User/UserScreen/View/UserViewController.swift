//
//  UserViewController.swift
//  User
//
//  Created by Shamly KH on 27/04/21.
//

import UIKit

class UserViewController: UIViewController {
    let viewModel = ViewModel()

    @IBOutlet weak var userTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onData = { [weak self]  in
           
            self?.userTableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    /// Present detail screen  with userinfo
    func presentDetailScreen(rowIndex: Int,cellImage: UIImageView){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        detailVC.viewModel = DetailViewModel()
        detailVC.viewModel.userInfo = self.viewModel.cellRowAtIndex(index: rowIndex)
        detailVC.viewModel.imageView = cellImage
        detailVC.viewModel.index = rowIndex
        detailVC.onSave = { [weak self] (userData, index) in
            self?.viewModel.insertAt(element: userData, index: index)
            DispatchQueue.main.async {
                self?.userTableView.reloadData()
            }
        }
        self.present(detailVC, animated: false, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UserViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserInfoTableViewCell
        cell.tag = indexPath.row
        cell.cellInfo = viewModel.cellRowAtIndex(index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        print("Deleted")
        viewModel.deleteRowAtIndex(index: indexPath.row)
        self.userTableView.deleteRows(at: [indexPath], with: .automatic)
        self.userTableView.reloadData()

      }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.userTableView.cellForRow(at: indexPath) as! UserInfoTableViewCell
        presentDetailScreen(rowIndex: indexPath.row, cellImage: (cell.userImage)! )
    }
    
}
