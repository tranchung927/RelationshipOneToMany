//
//  DetailViewController.swift
//  RelationshipOneToMany
//
//  Created by Chung Sama on 4/5/17.
//  Copyright © 2017 Chung Sama. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameStudent: UITextField!
    @IBOutlet weak var nameCourse: UITextField!
    
    var nameOfStudent: String = ""
    var nameOfCourse: String = ""
    
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        nameOfStudent = nameStudent.text ?? ""
        nameOfCourse = nameCourse.text ?? ""
    }
}
