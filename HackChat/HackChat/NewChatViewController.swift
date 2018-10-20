//
//  NewChatViewController.swift
//  HackChat
//
//  Created by Haggai Lerman on 2018-10-20.
//  Copyright © 2018 luke. All rights reserved.
//

import UIKit

class NewChatViewController: UIViewController {

    @IBOutlet weak var userField: UITextField!
    
    @IBAction func newChatOnPress(_ sender: Any) {
    self.performSegue(withIdentifier: "chat", sender: self)
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
