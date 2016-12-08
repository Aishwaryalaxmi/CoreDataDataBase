//
//  TeachingStaffViewModel.swift
//  School DataBase Management
//
//  Created by Aishwarya on 29/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import Foundation
import CoreData

class TeachingStaffViewModel {
    
    var schools: [School]?
    var teachers: [Teachers]?
    
    func updateTeachingStaff(school: School?) {
        let managedContext = PersistenceStack.sharedInstance.privateContext
        
        let predicate = NSPredicate(format: "schoolID = %@", (school?.schoolID)!)
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = School.fetchRequest()
        fetchRequest.predicate = predicate
        
        do {
            try schools = managedContext.fetch(fetchRequest) as? [School]
        } catch {
            print(error)
        }
        
        let teachersInScool = schools?[0].teachers
        teachers = teachersInScool?.allObjects as? [Teachers]
    }
    
}

