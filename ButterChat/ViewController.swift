//
//  ViewController.swift
//  ButterChat
//
//  Created by Steven Shang on 1/20/17.
//  Copyright © 2017 Steven Shang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var chatrooms: [Chatroom] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBAction func addButtonPressed(_ sender: Any) {
        
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
