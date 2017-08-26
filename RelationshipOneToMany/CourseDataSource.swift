//
//  CourseDataSource.swift
//  RelationshipOneToMany
//
//  Created by Chung Sama on 4/5/17.
//  Copyright © 2017 Chung Sama. All rights reserved.
//
import UIKit

class CourseDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.shared.courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = DataService.shared.courses[indexPath.row].nameCourse
        return cell
    }
}
