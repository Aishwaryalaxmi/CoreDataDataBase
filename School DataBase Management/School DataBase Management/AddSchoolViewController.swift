//
//  AddSchoolViewController.swift
//  School DataBase Management
//
//  Created by Aishwarya on 18/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import UIKit
import CoreData
import Foundation

protocol updateSchools: class {
    func updateListOfSchools()
}

protocol editSchoolDetails: class {
    func updateSchoolDetails()
}

enum AddSchoolTpe: Int {
    case add
    case edit
}

class AddSchoolViewController: UIViewController {

    @IBOutlet weak var addSchoolTableView: UITableView!
   
    @IBOutlet var tableFooterView: UIView!
  
    @IBOutlet weak var addButton: UIButton!
    
    weak var delegate: updateSchools?
    
    weak var editSchoolDelegate: editSchoolDetails?
    
    var school: School?
    
    var viewModel = AddSchoolViewModel()
    
    var addSchoolType = AddSchoolTpe.add
    
    var schoolDetailViewModel = SchoolDetailViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = "Add School"
        addSchoolTableView.tableFooterView = tableFooterView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = view.backgroundColor
    }
    
    
    @IBAction func didSelectAddButton(_ sender: AnyObject) {
        
        let schoolNameCell = addSchoolTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! LoginDetailsCell
        let schoolName = schoolNameCell.textField!.text
        
        let schoolAdressLine1Cell = addSchoolTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! LoginDetailsCell
        let schoolAdressLine1 = schoolAdressLine1Cell.textField!.text
        
        let schoolCityNameCell = addSchoolTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! LoginDetailsCell
        let schoolCityName = schoolCityNameCell.textField!.text
        
        let schoolStateNameCell = addSchoolTableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! LoginDetailsCell
        let schoolStateName = schoolStateNameCell.textField!.text
        
        let schoolPinCodeCell = addSchoolTableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! LoginDetailsCell
        let schoolPinCode = schoolPinCodeCell.textField!.text
        
        if ((schoolNameCell.textField.text?.isEmpty)! || (schoolAdressLine1Cell.textField.text?.isEmpty)! || (schoolCityNameCell.textField.text?.isEmpty)! || (schoolStateNameCell.textField.text?.isEmpty)! || (schoolPinCodeCell.textField.text?.isEmpty)!) {
            let alertController = UIAlertController(title: "" , message: "Enter all the fields", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else {
            
            switch addSchoolType {
            case .add:
                viewModel.addSchool(schoolName: schoolName!, schoolAdressLine1: schoolAdressLine1!, schoolCityName: schoolCityName!, schoolStateName: schoolStateName!, schoolPinCode: schoolPinCode!)
                delegate?.updateListOfSchools()
            case .edit:
                schoolDetailViewModel.editSchoolDetails(school: school!, schoolName: schoolName!, schoolAddressLine1: schoolAdressLine1!, schoolCityName: schoolCityName!, schoolStateName: schoolStateName!, schoolPinCode: schoolPinCode!)
                editSchoolDelegate?.updateSchoolDetails()
                
            }
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
}

extension AddSchoolViewController: UITableViewDelegate {
    
}

extension AddSchoolViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension AddSchoolViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddSchoolVcCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoginDetailsCellID") as! LoginDetailsCell
        
        let currentRow = AddSchoolVcCells(rawValue: indexPath.row)!
        
        switch currentRow {
        case .schoolName:
            cell.textField.placeholder = "School Name"
            cell.textField.text = school?.schoolName

        case .schoolAdressLine1:
            cell.textField.placeholder = "School Adress"
           cell.textField.text = school?.addressLine1
        case .cityName:
            cell.textField.placeholder = "City Name"
            cell.textField.text = school?.cityName
        case .stateName:
            cell.textField.placeholder = "State Name"
            cell.textField.text = school?.stateName
        case .pinCode:
            cell.textField.placeholder = "Pin Code"
            cell.textField.text = school?.pinCode
        }
        return cell
    }
}
