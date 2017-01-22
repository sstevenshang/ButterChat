//
//  ViewController.swift
//  ButterChat
//
//  Created by Steven Shang on 1/20/17.
//  Copyright © 2017 Steven Shang. All rights reserved.
//

import UIKit
import DropDown

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var user: User = User(username: "Steven", password: "password", language: ["English","en"])
    let dropDown = DropDown()
    
    var langDict: [String:String] = [
        "Arabic" : "ar",
        "Chinese" : "zh-CHS",
        "English" : "en",
        "French" : "fr",
        "German" : "de",
        "Hindi" : "hi",
        "Italian" : "it",
        "Japanese" : "ja",
        "Korean" : "ko",
        "Polish" : "pl",
        "Russian" : "ru",
        "Spanish" : "es",
        "Turkish" : "tr"
    ]
    
    @IBOutlet weak var langButton: UIBarButtonItem!
    
    @IBAction func langButtonPressed(_ sender: Any) {
        dropDown.show()
    }
    
    
    var chatrooms: [Chatroom] = []
    var lastIconUsed: Int?
    
    var networkHelper: NetworkHelper = NetworkHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if chatrooms.count == 0 {
            tableView.isHidden = true
        }
        tableView.rowHeight = 60
        
        dropDown.anchorView = self.tableView
        
        //dropDown.bottomOffset = CGPoint(x: 0, y: 60)

        var langs: [String] = []
        for (key, _) in langDict {
            langs.append(key)
        }
        dropDown.dataSource = langs
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            guard let langSelected = self.langDict[item] else {
                print("LANG SETTING GONE WRONG!!")
                return
            }
            self.user.language = [item,langSelected]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBAction func addButtonPressed(_ sender: Any) {
    
        let alert = UIAlertController(title: "Find Chat!", message: "Enter secret chat code.", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            
            let textField = alert!.textFields![0]
            guard let text = textField.text else {
                return
            }
            if text.replacingOccurrences(of: " ", with: "") == "" {
                return
            }
            
            let group = Chatroom(name: text, icon: self.iconRandomizer())
            self.chatrooms.append(group)
            self.tableView.isHidden = false
            self.tableView.reloadData()
            
        })
        
        //okAction.isEnabled = false // TODO
        alert.addAction(okAction)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func iconRandomizer() -> UIImage {
        
        var rand = Int(arc4random_uniform(3))
        print(rand)
        if lastIconUsed != nil {
            if rand == lastIconUsed {
                rand = (rand + 1)%3
            }
        }
        lastIconUsed = rand
        return getIcon(i: rand)
    }

    func getIcon(i: Int) -> UIImage {
        
        switch i {
        case 0:
            return UIImage(named: "banana")!
        case 1:
            return UIImage(named: "lemon")!
        case 2:
            return UIImage(named: "grape")!
        default:
            print("an error has occured setting icon")
            return UIImage()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChatSegue" {
            
            let nextScene = segue.destination as? ChatViewController
            nextScene?.title = chatrooms[(tableView.indexPathForSelectedRow?.row)!].name
            nextScene?.user = user
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatrooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatroom", for: indexPath) as! ChatroomTableViewCell
        cell.nameLabel.text = chatrooms[indexPath.row].name
        cell.iconImageView.image = chatrooms[indexPath.row].icon
        return cell
    }

}
