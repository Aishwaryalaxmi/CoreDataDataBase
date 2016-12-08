//
//  File.swift
//  School DataBase Management
//
//  Created by Aishwarya on 17/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import Foundation

enum LogInDetailFields: Int {
    case userName
    case password
    
    static let count = LogInDetailFields.password.hashValue + 1
}
