//
//  ViewController.swift
//  ButterChat
//
//  Created by Steven Shang on 1/20/17.
//  Copyright © 2017 Steven Shang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var chatrooms: [Chatroom] = []
    var lastIconUsed: Int?
    
    var networkHelper: NetworkHelper = NetworkHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if chatrooms.count == 0 {
            tableView.isHidden = true
        }
        tableView.rowHeight = 70
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBAction func addButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Find Group!", message: "Enter the secret group code.", preferredStyle: .alert)
        
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
