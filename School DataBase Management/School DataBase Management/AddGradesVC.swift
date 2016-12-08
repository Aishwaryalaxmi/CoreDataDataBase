//
//  AddGradesVC.swift
//  School DataBase Management
//
//  Created by Aishwarya on 23/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import UIKit
import CoreData
import Foundation
protocol AddGradesVCViewControllerDelegate: class {
    func updateGrades()
}
class AddGradesVC: UIViewController {

    @IBOutlet weak var addGradesTableView: UITableView!
    
    @IBOutlet var tableFooterView: UIView!
    
    weak var delegate: AddGradesVCViewControllerDelegate?
    
    var viewModel = AddGradesViewModel()
    var school: School?
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradesTableView.tableFooterView = tableFooterView

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func didClickAddButton(_ sender: AnyObject) {
        
        let gradeNameCell = addGradesTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! LoginDetailsCell
        let gradeName = gradeNameCell.textField!.text
        
        viewModel.addGrades(school: school, gradeName: gradeName!)
        delegate?.updateGrades()
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddGradesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = addGradesTableView.cellForRow(at: indexPath) as! LoginDetailsCell
        cell.textField.isUserInteractionEnabled = false
    }
}

extension AddGradesVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoginDetailsCellID") as! LoginDetailsCell
    
        let currentRow = AddGradesCell(rawValue: indexPath.row)!
        
        switch currentRow {
        case .gradeName:
            cell.textField.placeholder = "Grade Name"
        }
                return cell
    }
}

