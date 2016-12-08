//
//  SchoolDetailViewmodel.swift
//  School DataBase Management
//
//  Created by Aishwarya on 18/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import Foundation
import CoreData

enum SchoolDetail: Int {
    case schoolName
    case classes
    case teachers
    case propaganda
    
    static let count = SchoolDetail.propaganda.hashValue + 1
}

class SchoolDetailViewModel{
    var schools: [School]?
    var editedSchool: School?
    
    func editSchoolDetails(school: School, schoolName: String, schoolAddressLine1: String, schoolCityName: String, schoolStateName: String, schoolPinCode: String) {
        let managedContext = PersistenceStack.sharedInstance.privateContext
        let predicate = NSPredicate(format: "schoolID = %@", school.schoolID!)
        let fetchRequest:NSFetchRequest <NSFetchRequestResult> = School.fetchRequest()
        fetchRequest.predicate = predicate
        
        do {
            try schools = managedContext.fetch(fetchRequest) as? [School]
        } catch {
            print(error)
        }
        
        let school = schools?[0]
        
        school?.schoolName = schoolName
        school?.addressLine1 = schoolAddressLine1
        school?.cityName = schoolCityName
        school?.stateName = schoolStateName
        school?.pinCode = schoolPinCode
        do {
           try managedContext.save()
        } catch {
            print(error)
        }
    }
    
    func updateSchoolDetails(school: School) {
       
        let managedContext = PersistenceStack.sharedInstance.privateContext
        let predicate = NSPredicate(format: "schoolID = %@", school.schoolID!)
        let fetchRequest:NSFetchRequest <NSFetchRequestResult> = School.fetchRequest()
        fetchRequest.predicate = predicate
        
        do {
            try schools = managedContext.fetch(fetchRequest) as? [School]
        } catch {
            print(error)
        }
        
         editedSchool = schools?[0]
    }
}
