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
    
    var timer = Timer()

    var user: User!
    
    let network = NetworkHelper()
    
    var messageCount: Int = 0
    
    @IBOutlet weak var networkLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = LoginViewViewController.superUser
        connection()
        messageCount = 0
    }
    
    let SUCCESS_MESSAGE = "Hey Look, 😋! You're Connected with "
    let FAILURE_MESSAGE = "Yuckk, Sorry 😖... Connection Failure"
    
    func connection() {
        
        DispatchQueue.global().async {
            var text = ""
            print("USERNAME: \(self.user.username)")
            if self.network.createNewUser(username: self.user.username, password: self.user.password) {
                
                self.network.getUsers(handler: { (users) in
                    text = ""
//                    for user in users {
//                        text += "[\(user)]"
//                    }
                })
            } else {
                text = self.FAILURE_MESSAGE
            }
            DispatchQueue.main.async {
                self.networkLabel.text = text
                self.view.addSubview(self.networkLabel)
                self.listen()
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
        //network.closeConnection()
    }
    
    override func sendText(_ text: String, isIncomingMessage: Bool) -> GeneralMessengerCell {
        
        messageCount += 1
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
    
    func listen() {
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(ChatViewController.pullFromServer), userInfo: nil, repeats: true)
    }
    
    func pullFromServer() {
        DispatchQueue.global().async {
            
            self.network.getMessage(langauge: self.user.language[1]) { (success, messages) in
                print(self.messageCount)
                self.networkLabel.isHidden = true
                if !success {
                    print("failed to get messages")
                    return
                }
                guard let messages = messages else {
                    return
                }
                let my = self.messageCount
                let balance = messages.count - my
                if (balance <= 0) {
                    return
                }
                for index in 0...(balance-1) {
                    
                    let message = messages[my + index].1
                    
                    
                    let usr = messages[index].0
                    print("\(usr) VS \(self.user.username)")
                    
                    let okay = self.sendText(message, isIncomingMessage: (usr != self.user.username))
                    print(okay)
                }
            }
        }
    }
}
