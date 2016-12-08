//
//  Teachers+CoreDataProperties.swift
//  School DataBase Management
//
//  Created by Aishwarya on 22/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import Foundation
import CoreData


extension Teachers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Teachers> {
        return NSFetchRequest<Teachers>(entityName: "Teachers");
    }

    @NSManaged public var iD: Int16
    @NSManaged public var name: String?
    @NSManaged public var classes: NSSet?
    @NSManaged public var school: School?
    @NSManaged public var students: NSSet?

}

// MARK: Generated accessors for classes
extension Teachers {

    @objc(addClassesObject:)
    @NSManaged public func addToClasses(_ value: Classes)

    @objc(removeClassesObject:)
    @NSManaged public func removeFromClasses(_ value: Classes)

    @objc(addClasses:)
    @NSManaged public func addToClasses(_ values: NSSet)

    @objc(removeClasses:)
    @NSManaged public func removeFromClasses(_ values: NSSet)

}

// MARK: Generated accessors for students
extension Teachers {

    @objc(addStudentsObject:)
    @NSManaged public func addToStudents(_ value: Students)

    @objc(removeStudentsObject:)
    @NSManaged public func removeFromStudents(_ value: Students)

    @objc(addStudents:)
    @NSManaged public func addToStudents(_ values: NSSet)

    @objc(removeStudents:)
    @NSManaged public func removeFromStudents(_ values: NSSet)

}
