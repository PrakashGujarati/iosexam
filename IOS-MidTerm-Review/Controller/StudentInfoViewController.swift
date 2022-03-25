//
//  StudentInfoViewController.swift
//  IOS-MidTerm-Review
//
//  Created by user203175 on 10/17/21.
//

import UIKit


protocol TableViewRefresh {
    /// Protocol to auto-refresh the list - don't touch this code.
    func refresh()
}


class StudentInfoViewController: UIViewController {

    public var selectedStudent : Student?
    public var editMode : Bool = false
    
    var delegate : TableViewRefresh?  /// delegate to auto-refresh the list  - don't touch this code.
    
    @IBOutlet weak var txtStudentName : UITextField!
    @IBOutlet weak var btnDelete : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        if editMode {
            title = "Adding new student"
            btnDelete.isHidden = true
            txtStudentName.text = selectedStudent!.getName()
        } else {
            title = "Editing student"
            btnDelete.isHidden = true
        }
        

    }

    
    @IBAction func btnSave(_ sender: Any) {
        
        if let studentName : String = txtStudentName.text {
            
            if studentName.count < 3 {
                print("Please, enter a student name with at least 3 chars!")
                return
            }
            
            if editMode {
                
                selectedStudent!.setName(name: studentName)
                selectedStudent!.setEmail(email: studentName)
                
            
            } else {

                let student = Student()
                
                student.setName(name: studentName)
                student.setEmail(email: studentName)
                student.setId(id: Student.getNextId())
                
                StudentProvider.addStudent(student: student)

            }
           
            delegate?.refresh()  /// auto-refresh the list - don't touch this code
            
            navigationController!.popViewController(animated: true)
            
            
        } else {
            print("Enter a valid name!")
        }
        
        
    }
    
    
    @IBAction func btnDeleteTouchUp(_ sender: Any) {
        
        StudentProvider.removeStudent(studentId: selectedStudent!.getId())
        
        delegate?.refresh()
        navigationController?.popViewController(animated: true)
    }
    


}
