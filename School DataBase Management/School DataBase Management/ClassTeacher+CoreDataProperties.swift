//
//  ClassTeacher+CoreDataProperties.swift
//  School DataBase Management
//
//  Created by Aishwarya on 22/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import Foundation
import CoreData


extension ClassTeacher {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClassTeacher> {
        return NSFetchRequest<ClassTeacher>(entityName: "ClassTeacher");
    }

    @NSManaged public var iD: Int16
    @NSManaged public var name: String?
    @NSManaged public var claases: NSSet?
    @NSManaged public var school: School?
    @NSManaged public var students: NSSet?

}

// MARK: Generated accessors for claases
extension ClassTeacher {

    @objc(addClaasesObject:)
    @NSManaged public func addToClaases(_ value: Classes)

    @objc(removeClaasesObject:)
    @NSManaged public func removeFromClaases(_ value: Classes)

    @objc(addClaases:)
    @NSManaged public func addToClaases(_ values: NSSet)

    @objc(removeClaases:)
    @NSManaged public func removeFromClaases(_ values: NSSet)

}

// MARK: Generated accessors for students
extension ClassTeacher {

    @objc(addStudentsObject:)
    @NSManaged public func addToStudents(_ value: Students)

    @objc(removeStudentsObject:)
    @NSManaged public func removeFromStudents(_ value: Students)

    @objc(addStudents:)
    @NSManaged public func addToStudents(_ values: NSSet)

    @objc(removeStudents:)
    @NSManaged public func removeFromStudents(_ values: NSSet)

}
