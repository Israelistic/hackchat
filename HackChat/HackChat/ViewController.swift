//
//  ViewController.swift
//  HackChat
//
//  Created by Luke on 2018-10-20.
//  Copyright © 2018 luke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = "Hey"
        
        text1.placeholder = "email"
        
        text2.placeholder = "password"
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var text1: UITextField!
    
    @IBOutlet weak var text2: UITextField!
    
    @IBOutlet weak var textLabel: UILabel!
    
    
}

