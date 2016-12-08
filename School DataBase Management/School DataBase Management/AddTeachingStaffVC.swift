//
//  AddTeachingStaffVC.swift
//  School DataBase Management
//
//  Created by Aishwarya on 23/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class AddTeachingStaffVC: UIViewController {

    @IBOutlet weak var addTeachingStaffTableView: UITableView!
    
    var school: School?
    
    var viewModel = AddTeachingStaffViewModel()
    
    weak var delegate: updateTeachingStaff?
   
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet var tableFooterView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Teaching Staff"
        
        addTeachingStaffTableView.tableFooterView = tableFooterView

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addTeachingStaff(_ sender: AnyObject) {
       
        let teacherNameCell = addTeachingStaffTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! LoginDetailsCell
        let teacherName = teacherNameCell.textField!.text

        viewModel.addTeachingStaff(school: school, teacherName: teacherName!)
       
        delegate?.updateTeachingStaff()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func didSelectAddStudentButton(_ sender: AnyObject) {
    }
}

extension AddTeachingStaffVC: UITableViewDelegate {
    
}

extension AddTeachingStaffVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoginDetailsCellID") as! LoginDetailsCell
        cell.textField.placeholder = "Teacher Name"
        return cell
    }
}
