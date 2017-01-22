//
//  ChatViewController.swift
//  ButterChat
//
//  Created by Steven Shang on 1/21/17.
//  Copyright © 2017 Steven Shang. All rights reserved.
//

import UIKit
import Chatto
import ChattoAdditions
import NMessenger

class ChatViewController: BaseChatViewController {

    @IBOutlet weak var titleItem: UINavigationItem!
    
    let chatName = ""
    
    let messengerView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.messengerView = NMessenger(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        messengerView.delegate = self
        self.view.addSubview(self.messengerView)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ChatInputView
    
    var chatInputPresenter: BasicChatInputBarPresenter!
    
    override func createChatInputView() -> UIView {
        let chatInputView = ChatInputBar.loadNib()
        var appearance = ChatInputBarAppearance()
        appearance.sendButtonAppearance.title = NSLocalizedString("Send", comment: "")
        appearance.textInputAppearance.placeholderText = NSLocalizedString("Type a message", comment: "")
        self.chatInputPresenter = BasicChatInputBarPresenter(chatInputBar: chatInputView, chatInputItems: self.createChatInputItems(), chatInputBarAppearance: appearance)
        chatInputView.maxCharactersCount = 1000
        return chatInputView
    }
    
    func createChatInputItems() -> [ChatInputItemProtocol] {
        var items = [ChatInputItemProtocol]()
        items.append(self.createTextInputItem())
        items.append(self.createPhotoInputItem())
        return items
    }
    
    func createTextInputItem() -> TextChatInputItem {
        let item = TextChatInputItem()
        item.textInputHandler = { [weak self] text in
            
        }
        return item
    }
    
    func createPhotoInputItem() -> PhotosChatInputItem {
        let item = PhotosChatInputItem(presentingController: self)
        item.photoInputHandler = { [weak self] image in
            print(image)
        }
        return item
    }
    
//    func sendText(text: String, isIncomingMessage:Bool) -> GeneralMessengerCell {
//        
//    }
//    
//    func sendImage(image: UIImage, isIncomingMessage:Bool) -> GeneralMessengerCell {
//        
//    }
    
}







