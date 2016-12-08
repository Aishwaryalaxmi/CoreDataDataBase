//
//  AddStudentsViewController.swift
//  School DataBase Management
//
//  Created by Aishwarya on 24/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import UIKit
import CoreData
import Foundation

protocol AddStudentsViewControllerDelegate: class {
    func updateStudents()
}

class AddStudentsViewController: UIViewController {

    @IBOutlet weak var addStudentsTableView: UITableView!
  
    @IBOutlet var tableFooterView: UIView!
    
    weak var delegate: AddStudentsViewControllerDelegate?
    
    var school: School?
    
    var grades = [Classes]()
    
    var viewModel = AddStudentsViewModel()
    
    let gradePicker = UIPickerView()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStudentsTableView.tableFooterView = tableFooterView
        gradePicker.delegate = self
    
        addStudentsTableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didClickAddButton(_ sender: AnyObject) {

        let studentNameCell = addStudentsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! LoginDetailsCell
        let studentName = studentNameCell.textField!.text
        
        let studentGradeCell = addStudentsTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! LoginDetailsCell
        let studentGrade = studentGradeCell.textField!.text

        viewModel.addStudents(grades: grades, studentGrade: studentGrade!, studentName: studentName!, school: school)

        delegate?.updateStudents()
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension AddStudentsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension AddStudentsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 2
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoginDetailsCellID") as! LoginDetailsCell
            
            let currentRow = AddStudentsVcCells(rawValue: indexPath.row)!
            
            switch currentRow {
            case .studentName:
                cell.textField.placeholder = "Student Name"
                
            case .grade:
                cell.textField.placeholder = "Student Grade"
                cell.textField.inputView = gradePicker
            }
            
            return cell
    }
}

extension AddStudentsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return grades[row].gradeName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let cell = addStudentsTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! LoginDetailsCell
        if !(grades.isEmpty){
        cell.textField.text = grades[row].gradeName
        }
    }
}

extension AddStudentsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return grades.count
    }

}
