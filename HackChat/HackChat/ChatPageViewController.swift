//
//  ChatPageViewController.swift
//  HackChat
//
//  Created by Haggai Lerman on 2018-10-20.
//  Copyright © 2018 luke. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase



class ChatPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var listener: ListenerRegistration?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell")!
        let message = messageList[indexPath.row]
        cell.textLabel?.text = message.text
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        cell.detailTextLabel?.text = df.string(from: message.date)
        return cell
    }
    
    
    var firendUID:String?
    var messageList: [Message] = []
    @IBOutlet weak var chatField: UITextField!
    
    @IBAction func sendChat(_ sender: Any) {
        if let message = chatField.text {
            Firestore.firestore().collection("Message").addDocument(data: ["text" : message, "date": Date(), "from": Auth.auth().currentUser?.uid, "to": firendUID ?? "unknown"]) { (err) in
                if let err = err{
                    AppDelegate.alert(text: err.localizedDescription, title: "Error when sending message", vc: self, finish: nil)
                } else {
                    self.chatField.text = ""
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listener = Firestore.firestore().collection("Message").addSnapshotListener { (snap, err) in
            if let doc = snap?.documents{
                for docs in doc {
                    if let from = docs.data()["from"] as? String, let text = docs.data()["from"] as? String, let date = docs.data()["date"] as? Date{
                        let message = Message(messageID: docs.documentID, from: from, text: text, date: date)
                        self.messageList.append(message)
                        self.messageList.sort(by: { (msg1, msg2) -> Bool in
                            msg1.date > msg2.date
                        })
                    }
                }
            }
        }
        
        // Do any additional setup after loading the view.
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        self.listener?.remove()
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
