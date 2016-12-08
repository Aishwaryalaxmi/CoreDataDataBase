//
//  StudentListViewController.swift
//  School DataBase Management
//
//  Created by Aishwarya on 18/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import UIKit
import CoreData
import Foundation





class StudentListViewController: UIViewController, AddStudentsViewControllerDelegate, AddGradesVCViewControllerDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var gradeListTableView: UITableView!
    
    @IBOutlet var addGrades: UIView!
    
    var predicate: String?
    
    var schools = [School]()
    
    var students = [Students]()
    
    var school: School?
    
    var grades = [Classes]()
    
    var filteredGrades = [Classes]()
    
    var viewModel = StudentListViewModel()
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.isPagingEnabled = true
        
        let rightBarButtonItem = UIBarButtonItem(title: "Grade List", style: .plain, target: self, action: #selector(displayGradeList))
        rightBarButtonItem.tintColor = UIColor(red: 0, green: 0.7, blue: 0.8, alpha: 1.0)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem

        layoutSetting()
        gradeListTableVieewAppearence()
        
        updateGrades()
        updateStudents()
    }
    
    func layoutSetting() {
        let layOut = UICollectionViewFlowLayout()
        layOut.itemSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        layOut.minimumInteritemSpacing = 0
        layOut.minimumLineSpacing = 0
        layOut.scrollDirection = .horizontal
        collectionView!.collectionViewLayout = layOut
    }
    
    func gradeListTableVieewAppearence() {
        gradeListTableView.contentSize.height = ((CGFloat(gradeListTableView.numberOfRows(inSection: 0)) * gradeListTableView.rowHeight) + (10 * (gradeListTableView.tableFooterView?.frame.height)!))

        gradeListTableView.frame = CGRect(x: 5 , y: 60, width: view.frame.width, height:view.frame.height)
        gradeListTableView.delegate = self
        gradeListTableView.dataSource = self
//        gradeListTableView.addSubview(addGrades)
//        gradeListTableView.tableFooterView = addGrades
//        addGrades.frame = CGRect(x: 0, y: view.frame.maxY - addGrades.frame.height, width: view.bounds.width, height: 50)
        
//        gradeListTableView.contentSize.height = ((CGFloat(gradeListTableView.numberOfRows(inSection: 0)) * gradeListTableView.rowHeight) + (10 * (gradeListTableView.tableFooterView?.frame.height)!))
        view.addSubview(gradeListTableView)
        gradeListTableView.isHidden = true
        gradeListTableView.reloadData()
    }
    
    func displayGradeList() {
        gradeListTableView.isHidden = !gradeListTableView.isHidden
        updateGrades()
        updateStudents()
    }
    
    @IBAction func didSelectAddGradesButton(_ sender: AnyObject) {
        if let addGradesVC = self.storyboard?.instantiateViewController(withIdentifier: "AddGradesVCID") as? AddGradesVC {
            addGradesVC.school = school
            addGradesVC.delegate = self
            self.navigationController?.pushViewController(addGradesVC, animated: true)
        }
    }
    
    @IBAction func didSelectAddStudentsButton(_ sender: AnyObject) {
        if let  addStudentsVC = self.storyboard?.instantiateViewController(withIdentifier: "AddStudentsViewControllerID") as? AddStudentsViewController {
            addStudentsVC.school = school
            addStudentsVC.grades = grades
            addStudentsVC.delegate = self
            gradeListTableView.isHidden = true
            
            self.navigationController?.pushViewController(addStudentsVC, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = view.backgroundColor
    }
    
    func updateGrades() {
        viewModel.updateGrades(school: school)
       
        grades = viewModel.grades!
        collectionView.reloadData()
        gradeListTableView.reloadData()
    }
    
    func updateStudents() {
        viewModel.updateStudents(school: school!)
        schools = viewModel.schools!
        students = viewModel.students!
        collectionView.reloadData()
    }
}


extension StudentListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return grades.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        grades.sort{
            (s1, s2) -> Bool in
            return (s1.gradeName!).localizedStandardCompare(s2.gradeName!) == .orderedDescending
        }
        let grade = grades[indexPath.row]
        let student = grade.students?.allObjects as! [Students]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! studentListCell
        cell.students = student
        cell.studentListTableView.reloadData()
        return cell
    }
}

extension StudentListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let gradeName = grades[indexPath.item].gradeName {
        self.title = "Class Grade  \(gradeName)"
        }
    }
}

extension StudentListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return addGrades
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gradeListTableView.isHidden = true
        self.collectionView.scrollToItem(at: indexPath, at: .right, animated: false)
    }
}

extension StudentListViewController: UITableViewDataSource {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfSchoolsCellID") as! ListOfSchoolsCell
        grades.sort{
            (s1, s2) -> Bool in
            return (s1.gradeName!).localizedStandardCompare(s2.gradeName!) == .orderedDescending
        }
       
        cell.schoolNameLabel.text = grades[indexPath.row].gradeName
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let grade = grades[indexPath.row]
            let managedContext = PersistenceStack.sharedInstance.privateContext
            managedContext.delete(grade)
            grades.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        }
    }
}





