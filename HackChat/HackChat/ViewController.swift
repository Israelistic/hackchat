//
//  ViewController.swift
//  HackChat
//
//  Created by Luke on 2018-10-20.
//  Copyright © 2018 luke. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var text1: UITextField!
    
    @IBOutlet weak var text2: UITextField!
    
    @IBOutlet weak var textLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseApp.configure()
        
        textLabel.text = "Welcome to HackChat"
        
        text1.placeholder = "email"
        
        text2.placeholder = "password"
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func buttonOnPress(_ sender: Any) {
        
        
        
    }

    
}

