//
//  studentListCell.swift
//  School DataBase Management
//
//  Created by Aishwarya on 18/11/16.
//  Copyright © 2016 Aishwarya. All rights reserved.
//

import UIKit
import CoreData
import Foundation


class studentListCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var studentListTableView: UITableView!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var gradeListDisplayButton: UIButton!
    
    @IBOutlet weak var tableFooterView: UIView!
    
    var students: [Students]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        studentListTableView.tableFooterView = tableFooterView
        studentListTableView.reloadData()
        
    }
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let students = students {
            return students.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfSchoolsCellID") as! ListOfSchoolsCell
        if let students = students {
            cell.schoolNameLabel.text = students[indexPath.row].studentName
        }
        return cell
    }
}
