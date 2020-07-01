//
//  LoginViewController.swift
//  MERCYDA TRACK
//
//  Created by Vinod on 30/06/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

   
    @IBOutlet weak var loginTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        loginTableView.register(cellType:LoginTableviewCell.self)
    }
    
   @objc func loginButtonClicked(_ sender: UIButton){

    let indexpath = IndexPath.init(row:0, section: 0)
    if let cell = loginTableView.cellForRow(at: indexpath) as?LoginTableviewCell {
        let userName = cell.usernameTextfeild.text!
        let passWord = cell.passwordTextfeild.text!
        print(userName,passWord)

      }
  
}
}


extension LoginViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:CellID.LoginCell.rawValue, for: indexPath) as! LoginTableviewCell
        cell.selectionStyle = .none
        cell.loginButton.addTarget(self, action:  #selector(LoginViewController.loginButtonClicked(_:)), for: .touchUpInside)
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
}
