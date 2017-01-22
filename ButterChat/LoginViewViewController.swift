//
//  LoginViewViewController.swift
//  ButterChat
//
//  Created by Steven Shang on 1/22/17.
//  Copyright © 2017 Steven Shang. All rights reserved.
//

import UIKit

class LoginViewViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signinButton.isEnabled = false
        username.addTarget(self, action: #selector(LoginViewViewController.enableButton), for: .editingChanged)
        password.addTarget(self, action: #selector(LoginViewViewController.enableButton), for: .editingChanged)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var _username = ""
    var _password = ""
    
    func enableButton(sender: UITextField) {
        print("I am here")
        let u = username.text?.trimmingCharacters(in: CharacterSet.whitespaces)
        let p = password.text?.trimmingCharacters(in: CharacterSet.whitespaces)
        guard let u2 = u, let p2 = p else {
            return
        }
        if !u2.isEmpty && !p2.isEmpty {
            signinButton.isEnabled = true
            print("you are free")
        } else {
            signinButton.isEnabled = false
        }
    }
    
    @IBAction func signinButtonPressed(_ sender: Any) {
        
        _username = (username.text?.replacingOccurrences(of: " ", with: "_"))!
        _password = password.text!
        
        performSegue(withIdentifier: "showChatrooms", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showChatrooms" {
            
            print(_username)
            print(_password)
            
            let nav = segue.destination as! UINavigationController
            let nextScene = nav.topViewController as! ViewController
            let user = User(username: _username, password: _password, language: ["English","en"])
            nextScene.user = user
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

