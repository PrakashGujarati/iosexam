//
//  ViewController.swift
//  IOS-MidTerm-Review
//
//  Created by user203175 on 10/17/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtName : UITextField!
    @IBOutlet weak var txtPswd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == Segue.toStudentList {
        
            guard let name : String = txtName.text else {
                print("Please, enter a valid name!")
                self.alert(message: "Please, enter a valid name!")
                return false
            }
            
            if name.count > 7 || name.count > 8 {
                print("Please, enter a name with at least 7 or 8  chars!")
                self.alert(message: "Please, enter a name with at least 7 or 8 chars!")
                return false
            }
            
            if self.txtName.text != "2111849" && self.txtPswd.text != "adm123" {
                return false
            }
            return true
        }
        
        return false
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.toStudentList {
        
            let studentList = (segue.destination as! StudentListViewController)
            studentList.userName = self.txtName.text!
        }
        
        
    }
   

}


extension UIViewController {
  func alert(message: String, title: String = "") {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}

extension ViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
