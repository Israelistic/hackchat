//
//  ChatListViewController.swift
//  HackChat
//
//  Created by Haggai Lerman on 2018-10-20.
//  Copyright © 2018 luke. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth



class ChatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var chatList:[String:[Message]] = [:] // list of uid
    var myID:String?
    
    func asyncUsernameLoopup(){
        //loopup username
        for uid in chatList.keys {
            Firestore.firestore().collection("User").document(uid).getDocument { (snap, err) in
                if let snap = snap {
                    if let username = snap.data()?["Username"] as? String {
                        AppDelegate.usernameList[uid] = username
                    }
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myID = Auth.auth().currentUser?.uid
        let listenerFrom = Firestore.firestore().collection("Message").whereField("to", isEqualTo: self.myID).addSnapshotListener { (snap, err) in
            if let snap = snap {
                for doc in snap.documents {
                    if let fromID = doc.data()["from"] as? String, let date = doc.data()["date"] as? Date, let text = doc.data()["text"] as? String {
                        if self.chatList[fromID] == nil {
                            
                            self.chatList[fromID] = [Message(messageID: doc.reference.documentID, from: fromID, text: text, date: date)]
                        } else {
                            self.chatList[fromID]?.append(Message(messageID: doc.reference.documentID, from: fromID, text: text, date: date))
                        }
                    }
                }
            }
            
        }
        
        let listenerTo = Firestore.firestore().collection("Message").whereField("from", isEqualTo: self.myID).addSnapshotListener { (snap, err) in
            if let snap = snap {
                for doc in snap.documents {
                    if let toID = doc.data()["to"] as? String, let date = doc.data()["date"] as? Date, let text = doc.data()["text"] as? String {
                        if self.chatList[toID] == nil {
                            self.chatList[toID] = [Message(messageID: doc.reference.documentID, from: toID, text: text, date: date)]
                        } else {
                            self.chatList[toID]?.append(Message(messageID: doc.reference.documentID, from: toID, text: text, date: date))
                        }
                    }
                }
            }
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatcell", for: indexPath)
        let messages = self.chatList[Array(self.chatList.keys)[indexPath.row]]
        if let message = messages {
            if message.count != 0 {
                cell.textLabel?.text = AppDelegate.usernameList[Array(self.chatList.keys)[indexPath.row]] ?? Array(self.chatList.keys)[indexPath.row]
                cell.detailTextLabel?.text = message[0].text
            }
        }
        return cell
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
