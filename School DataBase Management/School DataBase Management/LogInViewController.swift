//
//  ViewController.swift
//  School DataBase Management
//
//  Created by Aishwarya on 17/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import UIKit
import CoreData

class LogInViewController: UIViewController {

    @IBOutlet weak var logInTable: UITableView!
  
    @IBOutlet var tableFooterView: UIView!
   
    @IBOutlet weak var logInButton: UIButton!
    
    let userName = "user"
    let password = "password"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Log In"
        
        logInTable.tableFooterView = tableFooterView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = view.backgroundColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didSelectLogIn(_ sender: AnyObject) {
        
//        let userNameCell = logInTable.cellForRow(at: IndexPath(row: 0, section: 0)) as! LoginDetailsCell
//        let passWordCell = logInTable.cellForRow(at: IndexPath(row: 1, section: 0)) as! LoginDetailsCell
        
//        if (userNameCell.textField.text == userName) && (passWordCell.textField.text == password) {
        
            if let listOfSchoolsVC = self.storyboard?.instantiateViewController(withIdentifier: "ListOfSchoolsViewControllerID") as? ListOfSchoolsViewController {
                self.navigationController?.pushViewController(listOfSchoolsVC, animated: true)
            }
//        } else {
            let alertController = UIAlertController(title: "Oops", message: "Invalid UserName or Password", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
//        }
    }
}

extension LogInViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension LogInViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return LogInDetailFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoginDetailsCellID") as! LoginDetailsCell
        return cell
    }
    
    
}

