//
//  teachingStaffViewController.swift
//  School DataBase Management
//
//  Created by Aishwarya on 18/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import UIKit
import CoreData
import Foundation

protocol updateTeachingStaff: class {
    func updateTeachingStaff()
}

class TeachingStaffViewController: UIViewController, updateTeachingStaff {
    var teachers = [Teachers]()
    var school: School?
    var schools = [School]()
    var viewModel = TeachingStaffViewModel()
    
    
    @IBOutlet weak var teachingStaffTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Teaching Staff"
        
        let rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTeachingStaff))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        updateTeachingStaff()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = view.backgroundColor
        updateTeachingStaff()
    }
    
    func addTeachingStaff() {
        if let addTeachingStaffVC = self.storyboard?.instantiateViewController(withIdentifier: "AddTeachingStaffVCID") as? AddTeachingStaffVC {
            addTeachingStaffVC.school = school
            addTeachingStaffVC.delegate = self
            self.navigationController?.pushViewController(addTeachingStaffVC, animated: true)
        }
    }
    
    func updateTeachingStaff() {
        viewModel.updateTeachingStaff(school: school)
        schools = viewModel.schools!
        teachers = viewModel.teachers!
        teachingStaffTableView.reloadData()
    }
}

extension TeachingStaffViewController: UITableViewDelegate {
    
}

extension TeachingStaffViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return teachers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfSchoolsCellID") as! ListOfSchoolsCell
        cell.schoolNameLabel.text = teachers[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let teacher = teachers[indexPath.row]
            let managedContext = PersistenceStack.sharedInstance.privateContext
            managedContext.delete(teacher)
            teachers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        }
    }

}
