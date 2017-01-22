//
//  ChatViewController.swift
//  ButterChat
//
//  Created by Steven Shang on 1/21/17.
//  Copyright © 2017 Steven Shang. All rights reserved.
//

import UIKit
import NMessenger

class ChatViewController: NMessengerViewController {

    @IBOutlet weak var titleItem: UINavigationItem!
    
    var user: User! = nil
    
    let network = NetworkHelper()
    
    @IBOutlet weak var networkLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connection()
        
        //self.addMessageToMessenger(sendText("Hello World", isIncomingMessage: true))
    }
    
    let SUCCESS_MESSAGE = "Hey Look, 😋! You're Connected with "
    let FAILURE_MESSAGE = "Yuckk, Sorry 😖... Connection Failure"
    
    func connection() {
        
        DispatchQueue.global().async {
            var text = ""
            if self.network.openConnection() && self.network.createNewUser(username: self.user.username, password: self.user.password) {
                
                self.network.getUsers(handler: { (users) in
                    text = self.SUCCESS_MESSAGE
                    for user in users {
                        text += "[\(user)]"
                    }
                })
            } else {
                text = self.FAILURE_MESSAGE
            }
            DispatchQueue.main.async {
                self.networkLabel.text = text
                self.view.addSubview(self.networkLabel)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("I AM CALLED")
        network.closeConnection()
    }
    
    override func sendText(_ text: String, isIncomingMessage: Bool) -> GeneralMessengerCell {
        
        networkLabel.isHidden = true
        sendToServer(text: text)
        print(text)
        let newMessage = createTextMessage(text, isIncomingMessage: isIncomingMessage)
        self.addMessageToMessenger(newMessage)
        return newMessage
    }
    
    func sendToServer(text: String) {
        
        DispatchQueue.global().async {
            if self.network.sendMessage(username: self.user.username, password: self.user.password, message: text) {
                print("message sent")
            } else {
                print("message failed to be sent")
            }
        }
    }
    
    override func sendImage(_ image: UIImage, isIncomingMessage: Bool) -> GeneralMessengerCell {
        print(image)
        let newMessage = self.createImageMessage(image, isIncomingMessage: isIncomingMessage)
        self.addMessageToMessenger(newMessage)
        return newMessage
    }
    
    
}







