//
//  AddSchoolViewModel.swift
//  School DataBase Management
//
//  Created by Aishwarya on 29/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import Foundation
import CoreData

enum AddSchoolVcCells: Int{
    case schoolName
    case schoolAdressLine1
    case cityName
    case stateName
    case pinCode
    
    static let count = AddSchoolVcCells.pinCode.hashValue + 1
}

class AddSchoolViewModel {
    
    
    func addSchool(schoolName: String, schoolAdressLine1: String, schoolCityName: String, schoolStateName: String, schoolPinCode: String) {
        let managedContext = PersistenceStack.sharedInstance.privateContext
        
        let schoolEntity = NSEntityDescription.entity(forEntityName: "School", in: managedContext)
        let school = School(entity: schoolEntity!, insertInto: managedContext)
        let schoolID = String(describing: school.objectID)
        
        school.schoolName = schoolName
        school.schoolID = schoolID
        
        
        school.schoolID = schoolID
        school.addressLine1 = schoolAdressLine1
        school.cityName = schoolCityName
        school.stateName = schoolStateName
        school.pinCode = schoolPinCode

        
        do {
            try managedContext.save()
        } catch {
            print("Could not save. An error occured \(error)")
        }
    }
}

