//
//  SigninViewController.swift
//  HackChat
//
//  Created by Haggai Lerman on 2018-10-20.
//  Copyright © 2018 luke. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuth

class SigninViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var password2Field: UITextField!
    @IBOutlet weak var password1Field: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBAction func submitOnPress(_ sender: Any) {
        if nameField.text != nil && emailField.text != nil && password1Field.text != nil && password2Field.text != nil && (password2Field.text == password1Field.text) {
            
            //create user ref in database
            
            Firestore.firestore().collection("User").whereField("email", isEqualTo: emailField.text).getDocuments { (snap, err) in
                if let err = err {
                    AppDelegate.alert(text: "\(err.localizedDescription)", title: "Cannot reach the ddatabase", vc: self, finish: {})
                } else {
                    if snap?.documents.count == 0 {
                        
                        Firestore.firestore().collection("User").addDocument(data: ["Username" : self.nameField.text, "Email": self.emailField.text]) { (err) in
                            if let err = err {
                                AppDelegate.alert(text: "\(err.localizedDescription)", title: "Error when creating user ref", vc: self, finish: {})
                            } else {
                                
                                //create user in auth
                                Auth.auth().createUser(withEmail: self.emailField.text!, password: self.password1Field.text!, completion: { (result, err) in
                                    if let err = err {
                                        AppDelegate.alert(text: "\(err.localizedDescription)", title: "Error when creating user", vc: self, finish: {})
                                    } else {
                                        self.performSegue(withIdentifier: "login", sender: nil)
                                    }
                                })
                            }
                            
                        }
                        
                    } else {
                        AppDelegate.alert(text: "Error", title: "The email is already exist", vc: self, finish: {})
                    }
                }
            }
            
        } else {
            AppDelegate.alert(text: "not valid", title: "chack emaill password", vc: self, finish: {})
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
