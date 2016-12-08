//
//  StudentListViewModel.swift
//  School DataBase Management
//
//  Created by Aishwarya on 29/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import Foundation
import CoreData

class StudentListViewModel {
  
    var schools: [School]?
    var students: [Students]?
    var grades: [Classes]?
   
    func updateStudents(school: School) {
        let managedContext = PersistenceStack.sharedInstance.privateContext
        
        let predicate = NSPredicate(format: "schoolID = %@", (school.schoolID)!)
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = School.fetchRequest()
        fetchRequest.predicate = predicate
        
        do {
            try schools = managedContext.fetch(fetchRequest) as? [School]
        } catch {
            print(error)
        }
        
        let studentsInSchool = schools?[0].students
        students = studentsInSchool?.allObjects as? [Students]
    }
    
    func updateGrades(school: School?) {
        let managedContext = PersistenceStack.sharedInstance.privateContext
        
        let predicate = NSPredicate(format: "schoolID = %@", (school?.schoolID)!)
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = School.fetchRequest()
        fetchRequest.predicate = predicate
        
        do {
            try schools = managedContext.fetch(fetchRequest) as? [School]
        } catch {
            print(error)
        }
        
        let gradesInSchool = schools?[0].classes
        grades = gradesInSchool?.allObjects as? [Classes]

    }
}
