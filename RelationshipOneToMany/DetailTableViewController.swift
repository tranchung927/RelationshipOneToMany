//
//  DetailTableViewController.swift
//  RelationshipOneToMany
//
//  Created by Chung Sama on 4/5/17.
//  Copyright © 2017 Chung Sama. All rights reserved.
//
import UIKit

class DetailTableViewController: UITableViewController {
    
    var nameStudent: String?
    var nameCourse: String?
    var listCourse: [Course]?
    var listStudent: [Student]?
    let courseDelegate = CourseDelegate()
    let courseDataSource = CourseDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        guard nameStudent != nil else {
            guard nameCourse != nil else {
                return
            }
            self.title = "List Student of course \(nameCourse ?? "")"
            return
        }
        self.title = "List Course of \(nameStudent ?? "")"
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard nameStudent != nil else {
            guard nameCourse != nil else {
                return 0
            }
            return listStudent!.count
        }
        return listCourse!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        if nameStudent != nil {
            cell.textLabel?.text = listCourse![indexPath.row].nameCourse
        } else if nameCourse != nil {
            cell.textLabel?.text = listStudent![indexPath.row].lastName
        }
        
        return cell
    }

}
