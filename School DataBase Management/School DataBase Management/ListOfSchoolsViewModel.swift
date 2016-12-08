//
//  ListOfSchoolsViewModel.swift
//  School DataBase Management
//
//  Created by Aishwarya on 29/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import Foundation
import CoreData

class ListOfSchoolsViewModel {
    
    var schools: [School]?
    
    
    func updateSchools() {
        let managedContext = PersistenceStack.sharedInstance.privateContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "School")
        
        do {
            try schools = managedContext.fetch(fetchRequest) as? [School]
        } catch {
            print(error)
        }
    }
}

