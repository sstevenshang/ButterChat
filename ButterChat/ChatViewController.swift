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

class ChatViewController: BaseChatViewController {

    @IBOutlet weak var titleItem: UINavigationItem!
    
    let chatName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //self.chatDataSource = MessageDataSource()
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
            print(text)
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
    
    
    public typealias ChatItemType = String
    
    public override func createPresenterBuilders() -> [ChatItemType: [ChatItemPresenterBuilderProtocol]] {
        return [ChatItemType: [ChatItemPresenterBuilderProtocol]]()
    }
    
//    public protocol ChatItemPresenterBuilderProtocol {
//        func canHandleChatItem(chatItem: ChatItemProtocol) -> Bool
//        func createPresenterWithChatItem(chatItem: ChatItemProtocol) -> ChatItemPresenterProtocol
//        var presenterType: ChatItemPresenterProtocol.Type { get }
//    }
    
}







