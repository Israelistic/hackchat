//
//  SigninViewController.swift
//  HackChat
//
//  Created by Haggai Lerman on 2018-10-20.
//  Copyright © 2018 luke. All rights reserved.
//

import UIKit
import Firebase

class SigninViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var password2Field: UITextField!
    @IBOutlet weak var password1Field: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBAction func submitOnPress(_ sender: Any) {
        if nameField.text != nil && emailField.text != nil && password1Field.text != nil && password2Field.text != nil && (password2Field.text == password1Field.text) {
            Firestore.firestore().collection("User").addDocument(data: ["Username" : nameField.text, "Email": emailField.text])
        } else {
            print("not valid")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        refresh()
    }
    
    func refresh(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
