//
//  AddStudentsViewModel.swift
//  School DataBase Management
//
//  Created by Aishwarya on 29/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import Foundation
import CoreData

enum AddStudentsVcCells: Int {
    case studentName
    case grade
}

class AddStudentsViewModel {
    func addStudents (grades: [Classes], studentGrade: String, studentName: String, school: School?) {
        let managedContext = PersistenceStack.sharedInstance.privateContext
        
        let studentsEntity = NSEntityDescription.entity(forEntityName: "Students", in: managedContext)
        let students = Students(entity: studentsEntity!, insertInto: managedContext)
        
        students.studentName = studentName
        
        students.classGrade = studentGrade
        
        let grade = (grades as NSArray).filtered(using: NSPredicate(format: "gradeName = %@", students.classGrade!)) as? [Classes]
        students.school = school
        if  !(grade?.isEmpty)! {
            students.grade = grade?[0]
        }
        
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
    }
}
