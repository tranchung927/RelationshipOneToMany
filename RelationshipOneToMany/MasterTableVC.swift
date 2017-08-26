//
//  ViewController.swift
//  RelationshipOneToMany
//
//  Created by Chung Sama on 4/5/17.
//  Copyright © 2017 Chung Sama. All rights reserved.
//

import UIKit

class MasterTableVC: UITableViewController {
    
    let studentDelegate = StudentDelegate()
    let studentDataSource = StudentDataSource()
    let courseDelegate = CourseDelegate()
    let courseDataSource = CourseDataSource()
    var isSelectedStudentsOfSegment = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = studentDelegate
        tableView.dataSource = studentDataSource
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch segue.identifier ?? "" {
        case "addItem":
            print("Add new Item")
        case "showDetail":
            guard let detailTableVC = segue.destination as? DetailTableViewController else {
                return
            }
            let selectedIndexPath = tableView.indexPathForSelectedRow
            if isSelectedStudentsOfSegment {
                detailTableVC.nameStudent = DataService.shared.students[selectedIndexPath!.row].lastName
                let courses = DataService.shared.students[selectedIndexPath!.row].courses as! Set<Course>
                var tempCourses: [Course] = []
                for item in courses {
                    tempCourses.append(item)
                }
                detailTableVC.listCourse = tempCourses
            } else {
                detailTableVC.nameCourse = DataService.shared.courses[selectedIndexPath!.row].nameCourse
                let students = DataService.shared.courses[selectedIndexPath!.row].students as! Set<Student>
                var tempStudents: [Student] = []
                for item in students {
                    tempStudents.append(item)
                }
                detailTableVC.listStudent = tempStudents
            }
        default:
            break
        }
    }

    @IBAction func unwindToMasterTableVC(segue: UIStoryboardSegue) {
        guard let sourViewController = segue.source as? DetailViewController else {
            return
        }
        let nameStudent = sourViewController.nameOfStudent
        let nameCourse = sourViewController.nameOfCourse
        let result = DataService.shared.insertStudentAndCourseToDataBase(lastName: nameStudent, courseName: nameCourse)
        if isSelectedStudentsOfSegment {
            if result.0 { // ko trung hoc sinh
                let newIndexPath = IndexPath(row: DataService.shared.students.count-1, section: 0)
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        } else {
            if result.1 { // ko trung khoa hoc
                let newIndexPath = IndexPath(row: DataService.shared.courses.count-1, section: 0)
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        }
    }
    
    @IBAction func selectedSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            isSelectedStudentsOfSegment = true
            tableView.delegate = studentDelegate
            tableView.dataSource = studentDataSource
            tableView.reloadData()
        case 1:
            isSelectedStudentsOfSegment = false
            tableView.delegate = courseDelegate
            tableView.dataSource = courseDataSource
            tableView.reloadData()
        default:
            break
        }
    }
    
    
}

