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
    @IBOutlet weak var txtStudentEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        if editMode {
            title = "Editing student"
            btnDelete.isHidden = false
            txtStudentName.text = selectedStudent!.getName()
            txtStudentEmail.text = selectedStudent!.getEmail()
            
        } else {
            title = "Adding new student"
            btnDelete.isHidden = true
        }

    }

    
    @IBAction func btnSave(_ sender: Any) {
        
        if let studentName : String = txtStudentName.text {
            
            if studentName.count < 3 {
                print("Please, enter a student name with at least 3 chars!")
                self.alert(message: "Please, enter a student name with at least 3 chars!")
                return
            }
            
            if !isValidEmail(self.txtStudentEmail.text!) {
                
                self.alert(message: "Please, enter a valid email address!")
                return
            }
            
            if editMode {
                
                selectedStudent!.setName(name: studentName)
                selectedStudent!.setEmail(email: self.txtStudentEmail.text!)
                
            
            } else {

                let student = Student()
                
                student.setName(name: studentName)
                student.setEmail(email: self.txtStudentEmail.text!)
                student.setId(id: Student.getNextId())
                StudentProvider.addStudent(student: student)

            }
           
            delegate?.refresh()  /// auto-refresh the list - don't touch this code
            
            navigationController!.popViewController(animated: true)
            
            
        } else {
            print("Enter a valid name!")
            self.alert(message: "Enter a valid name!")
        }
        
        
    }
    
    
    @IBAction func btnDeleteTouchUp(_ sender: Any) {
        
        let alert = UIAlertController(title: "Message", message: "Do you really want to delete  " + "\(self.txtStudentName.text!) ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] action in
            
            StudentProvider.removeStudent(studentId: selectedStudent!.getId())
            self.delegate?.refresh()
            self.navigationController?.popViewController(animated: true)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    


}

extension StudentInfoViewController
{
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
