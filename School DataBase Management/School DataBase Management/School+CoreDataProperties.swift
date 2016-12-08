//
//  School+CoreDataProperties.swift
//  School DataBase Management
//
//  Created by Aishwarya on 30/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import Foundation
import CoreData
 

extension School {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<School> {
        return NSFetchRequest<School>(entityName: "School");
    }

    @NSManaged public var propaganda: String?
    @NSManaged public var schoolID: String?
    @NSManaged public var schoolName: String?
    @NSManaged public var addressLine1: String?
    @NSManaged public var cityName: String?
    @NSManaged public var stateName: String?
    @NSManaged public var pinCode: String?
    @NSManaged public var classes: NSSet?
    @NSManaged public var classTeacher: NSSet?
    @NSManaged public var students: NSSet?
    @NSManaged public var teachers: NSSet?
    @NSManaged public var adress: NSManagedObject?

}

// MARK: Generated accessors for classes
extension School {

    @objc(addClassesObject:)
    @NSManaged public func addToClasses(_ value: Classes)

    @objc(removeClassesObject:)
    @NSManaged public func removeFromClasses(_ value: Classes)

    @objc(addClasses:)
    @NSManaged public func addToClasses(_ values: NSSet)

    @objc(removeClasses:)
    @NSManaged public func removeFromClasses(_ values: NSSet)

}

// MARK: Generated accessors for classTeacher
extension School {

    @objc(addClassTeacherObject:)
    @NSManaged public func addToClassTeacher(_ value: ClassTeacher)

    @objc(removeClassTeacherObject:)
    @NSManaged public func removeFromClassTeacher(_ value: ClassTeacher)

    @objc(addClassTeacher:)
    @NSManaged public func addToClassTeacher(_ values: NSSet)

    @objc(removeClassTeacher:)
    @NSManaged public func removeFromClassTeacher(_ values: NSSet)

}

// MARK: Generated accessors for students
extension School {

    @objc(addStudentsObject:)
    @NSManaged public func addToStudents(_ value: Students)

    @objc(removeStudentsObject:)
    @NSManaged public func removeFromStudents(_ value: Students)

    @objc(addStudents:)
    @NSManaged public func addToStudents(_ values: NSSet)

    @objc(removeStudents:)
    @NSManaged public func removeFromStudents(_ values: NSSet)

}

// MARK: Generated accessors for teachers
extension School {

    @objc(addTeachersObject:)
    @NSManaged public func addToTeachers(_ value: Teachers)

    @objc(removeTeachersObject:)
    @NSManaged public func removeFromTeachers(_ value: Teachers)

    @objc(addTeachers:)
    @NSManaged public func addToTeachers(_ values: NSSet)

    @objc(removeTeachers:)
    @NSManaged public func removeFromTeachers(_ values: NSSet)

}
