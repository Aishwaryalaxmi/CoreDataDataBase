//
//  ListOfSchoolsViewController.swift
//  School DataBase Management
//
//  Created by Aishwarya on 18/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import UIKit
import CoreData

class ListOfSchoolsViewController: UIViewController, updateSchools {
    
    var schools = [School]()

    @IBOutlet weak var schoolListTableView: UITableView!
    
    var viewModel = ListOfSchoolsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Schools"
        edgesForExtendedLayout = []
                
        let rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(didSelectAddSchool))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = view.backgroundColor
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        updateListOfSchools()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didSelectAddSchool() {
        if let addSchoolVC = self.storyboard?.instantiateViewController(withIdentifier: "AddSchoolViewControllerID") as? AddSchoolViewController {
            addSchoolVC.delegate = self
            self.navigationController?.pushViewController(addSchoolVC, animated: true)
        }
    }

    func updateListOfSchools() {
        viewModel.updateSchools()
        schools = viewModel.schools!
        schoolListTableView.reloadData()
    }
}

extension ListOfSchoolsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        tableView.deselectRow(at: indexPath, animated: true)
        if let schoolDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "SchoolDetailsViewControllerID") as? SchoolDetailsViewController {
            schoolDetailVC.school = schools[indexPath.row]
            self.navigationController?.pushViewController(schoolDetailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension ListOfSchoolsViewController: UITableViewDataSource {
    
       func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schools.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfSchoolsCellID") as! ListOfSchoolsCell
        cell.schoolNameLabel.text = schools[indexPath.row].schoolName
        cell.schoolNameLabel.layer.cornerRadius = 10
        cell.schoolNameLabel.layer.masksToBounds = true
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let school = schools[indexPath.row]
            let managedContext = PersistenceStack.sharedInstance.privateContext
            managedContext.delete(school)
            schools.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    

    
}
