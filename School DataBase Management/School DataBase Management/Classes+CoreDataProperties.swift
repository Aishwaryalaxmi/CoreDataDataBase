//
//  Classes+CoreDataProperties.swift
//  School DataBase Management
//
//  Created by Aishwarya on 22/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import Foundation
import CoreData


extension Classes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Classes> {
        return NSFetchRequest<Classes>(entityName: "Classes");
    }

    @NSManaged public var gradeName: String?
    @NSManaged public var numberOfStudents: Int16
    @NSManaged public var classTeacher: ClassTeacher?
    @NSManaged public var school: School?
    @NSManaged public var students: NSSet?
    @NSManaged public var teachers: NSSet?

}

// MARK: Generated accessors for students
extension Classes {

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
extension Classes {

    @objc(addTeachersObject:)
    @NSManaged public func addToTeachers(_ value: Teachers)

    @objc(removeTeachersObject:)
    @NSManaged public func removeFromTeachers(_ value: Teachers)

    @objc(addTeachers:)
    @NSManaged public func addToTeachers(_ values: NSSet)

    @objc(removeTeachers:)
    @NSManaged public func removeFromTeachers(_ values: NSSet)

}
