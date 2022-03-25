//
//  ViewController.swift
//  IOS-MidTerm-Review
//
//  Created by user203175 on 10/17/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtName : UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == Segue.toStudentList {
        
            guard let name : String = txtName.text else {
                print("Please, enter a valid name!")
                return false
            }
            
            if name.count > 3 {
                print("Please, enter a name with at least 3 chars!")
                return false
            }
            
            return true
        
        }
        
        return false
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.toStudentList {
        
            let studentList = (segue.destination as! StudentListViewController)
            
        }
        
        
    }
   

}

