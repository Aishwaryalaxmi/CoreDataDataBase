//
//  SchollDetailsVC.swift
//  School DataBase Management
//
//  Created by Aishwarya on 18/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class SchoolDetailsViewController: UIViewController, editSchoolDetails{
    
    var school: School?
    var viewModel = SchoolDetailViewModel()
   
    @IBOutlet weak var schoolNameLabel: UILabel!
    
    @IBOutlet weak var studentListButton: UIButton!
    
    @IBOutlet weak var teachingStaffButton: UIButton!
    
    @IBOutlet weak var schoolPropagandaButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let schoolName = school?.schoolName {
        self.title = "\(schoolName)"
        }
        schoolNameLabel.layer.cornerRadius = 10
        schoolNameLabel.layer.masksToBounds = true
        studentListButton.layer.cornerRadius = 10
        teachingStaffButton.layer.cornerRadius = 10
        schoolPropagandaButton.layer.cornerRadius = 10

        let rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editSchoolDetails))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        if let schoolName = school?.schoolName, let scoolAddress = school?.addressLine1, let schoolCity = school?.cityName, let schoolState = school?.stateName, let schoolPinCode = school?.pinCode {
            formattedSchoolAddress(schoolName: schoolName, schoolAddress: scoolAddress, schoolCity: schoolCity, schoolState: schoolState, schoolPinCode: schoolPinCode)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = view.backgroundColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func editSchoolDetails() {
        if let editVC = self.storyboard?.instantiateViewController(withIdentifier: "AddSchoolViewControllerID") as? AddSchoolViewController {
            editVC.school = school
            editVC.addSchoolType = AddSchoolTpe.edit
            editVC.editSchoolDelegate = self
            self.navigationController?.pushViewController(editVC, animated: true)
        }
    }
    
    func updateSchoolDetails() {
        viewModel.updateSchoolDetails(school: school!)
        self.title = school?.schoolName
        if let schoolName = school?.schoolName, let scoolAddress = school?.addressLine1, let schoolCity = school?.cityName, let schoolState = school?.stateName, let schoolPinCode = school?.pinCode {
            formattedSchoolAddress(schoolName: schoolName, schoolAddress: scoolAddress, schoolCity: schoolCity, schoolState: schoolState, schoolPinCode: schoolPinCode)
        }
        
    }
    
    func formattedSchoolAddress(schoolName: String, schoolAddress: String, schoolCity: String, schoolState: String,schoolPinCode: String  ) {
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let schoolName = NSMutableAttributedString(string: "\(schoolName) \n ")
        let schoolAddressDetail = NSMutableAttributedString(string: "\(schoolAddress) \n \(schoolCity) \n \(schoolState) \n \(schoolPinCode)")
        
        schoolName.addAttribute(NSFontAttributeName, value: UIFont(name: "Helvetica Neue", size: 22)!, range: NSMakeRange(0, schoolName.length))
        schoolAddressDetail.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 14), range: NSMakeRange(0, schoolAddressDetail.length))
        
        let attributedText = NSMutableAttributedString()
        attributedText.append(schoolName)
        attributedText.append(schoolAddressDetail)
        schoolNameLabel.attributedText = attributedText
        
    }
    
    @IBAction func didSelectStudentListButton(_ sender: AnyObject) {
        if let studentListVC = self.storyboard?.instantiateViewController(withIdentifier: "StudentListViewControllerID") as? StudentListViewController {
            studentListVC.school = school
            self.navigationController?.pushViewController(studentListVC, animated: true)
        }
    }
    
   
    @IBAction func didSelectTeachingStaffButton(_ sender: AnyObject) {
        if let teachingStaffVC = self.storyboard?.instantiateViewController(withIdentifier: "TeachingStaffViewControllerID") as? TeachingStaffViewController {
            teachingStaffVC.school = school
            self.navigationController?.pushViewController(teachingStaffVC, animated: true)
        }

    }
    
    @IBAction func didSelectSchoolPropagandaButton(_ sender: AnyObject) {
    }
    
    
}


