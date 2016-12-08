//
//  Students+CoreDataProperties.swift
//  School DataBase Management
//
//  Created by Aishwarya on 22/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import Foundation
import CoreData


extension Students {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Students> {
        return NSFetchRequest<Students>(entityName: "Students");
    }

    @NSManaged public var classGrade: String?
    @NSManaged public var studentName: String?
    @NSManaged public var classTeacher: ClassTeacher?
    @NSManaged public var grade: Classes?
    @NSManaged public var school: School?
    @NSManaged public var teachers: NSSet?

}

// MARK: Generated accessors for teachers
extension Students {

    @objc(addTeachersObject:)
    @NSManaged public func addToTeachers(_ value: Teachers)

    @objc(removeTeachersObject:)
    @NSManaged public func removeFromTeachers(_ value: Teachers)

    @objc(addTeachers:)
    @NSManaged public func addToTeachers(_ values: NSSet)

    @objc(removeTeachers:)
    @NSManaged public func removeFromTeachers(_ values: NSSet)

}
