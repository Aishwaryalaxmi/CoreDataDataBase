//
//  AddTeachingStaffViewModel.swift
//  School DataBase Management
//
//  Created by Aishwarya on 29/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import Foundation
import CoreData

class AddTeachingStaffViewModel {
    func addTeachingStaff(school: School?, teacherName: String) {
        let managedContext = PersistenceStack.sharedInstance.privateContext
        
        let teacherEntity = NSEntityDescription.entity(forEntityName: "Teachers", in: managedContext)
        let teacher = Teachers(entity: teacherEntity!, insertInto: managedContext)
        teacher.name = teacherName
        
        teacher.school = school
        
        do {
            try managedContext.save()
        } catch {
            print("Could not save. An error occured \(error)")
        }
    }
}
