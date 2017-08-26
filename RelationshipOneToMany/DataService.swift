//
//  DataService.swift
//  RelationshipOneToMany
//
//  Created by Chung Sama on 4/5/17.
//  Copyright © 2017 Chung Sama. All rights reserved.
//

import Foundation

class DataService {
    static var shared: DataService = DataService()
    private var _students: [Student] = []
    
    var students: [Student] {
        get {
            return getStudentsFromDataBase()
        }
        set {
            _students = newValue
        }
    }
    
    func getStudentsFromDataBase() -> [Student] {
        return try! DatabaseController.getContext().fetch(Student.fetchRequest()) as! [Student]
    }
    
    func insertStudentAndCourseToDataBase(lastName: String, courseName: String) -> (Bool, Bool) {
        let students = getStudentsFromDataBase()
        let tempStudents = students.filter { (student) -> Bool in
            return student.lastName == lastName
        }
        guard tempStudents.count == 0 else {
            // trung student
            let student = tempStudents[0]
            let tempCourses = student.courses as! Set<Course>
            for item in tempCourses {
                // trung khoa hoc
                if item.nameCourse == courseName {
                    return (false, false)
                }
            }
            // ko trung khoa hoc
            let course = Course(context: DatabaseController.getContext())
            course.nameCourse = courseName
            student.addToCourses(course)
            course.addToStudents(student)
            DatabaseController.saveContext()
            return (false, true)
        }
        // ko trung student
        let studentEntity = Student(context: DatabaseController.getContext())
        studentEntity.lastName = lastName

        let courses = getCoursesFromDataBase()
        let tempCourses = courses.filter { (course) -> Bool in
            return course.nameCourse == courseName
        }
        guard tempCourses.count == 0 else {
            // trung khoa hoc
            studentEntity.addToCourses(tempCourses[0])
            tempCourses[0].addToStudents(studentEntity)
            DatabaseController.saveContext()
            return (true, false)
        }
        // ko trung khoa hoc
        let course = Course(context: DatabaseController.getContext())
        course.nameCourse = courseName
        studentEntity.addToCourses(course)
        course.addToStudents(studentEntity)
        DatabaseController.saveContext()
        return (true, true)
    }
    
    private var _courses: [Course] = []
    var courses: [Course] {
        get {
            return getCoursesFromDataBase()
        }
        set {
            _courses = newValue
        }
    }
    
    func getCoursesFromDataBase() -> [Course] {
        return try! DatabaseController.getContext().fetch(Course.fetchRequest()) as! [Course]
    }
}
