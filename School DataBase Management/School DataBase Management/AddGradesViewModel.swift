//
//  AddGradesViewModel.swift
//  School DataBase Management
//
//  Created by Aishwarya on 29/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import Foundation
import CoreData

enum AddGradesCell: Int {
    case gradeName
}

class AddGradesViewModel {
    var classGrade = [Classes]()
    var schools: [School]?
    
    func addGrades(school: School?, gradeName: String) {
        let managedContext = PersistenceStack.sharedInstance.privateContext

        let predicate = NSPredicate(format: "schoolID = %@", (school?.schoolID)!)
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = School.fetchRequest()
        fetchRequest.predicate = predicate
        
        do {
            try schools = managedContext.fetch(fetchRequest) as? [School]
        } catch {
            print(error)
        }
        
        classGrade = schools?[0].classes?.allObjects as! [Classes]
        
          let duplicateGrade = (classGrade as NSArray).filtered(using: NSPredicate(format: "gradeName = %@", gradeName)) as! [Classes]
        
        if ((duplicateGrade.isEmpty)) {
            let gradeEntity = NSEntityDescription.entity(forEntityName: "Classes", in: managedContext)
            let grade = Classes(entity: gradeEntity!, insertInto: managedContext)
            
            grade.gradeName = gradeName
            grade.school = school
            
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        }
    }
}
