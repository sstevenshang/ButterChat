//
//  ViewController.swift
//  ButterChat
//
//  Created by Steven Shang on 1/20/17.
//  Copyright © 2017 Steven Shang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var someButton: UIButton!
    @IBAction func someButtonPressed(_ sender: Any) {
        sendRequest()
    }
    
    func sendRequest() {
        let url = URL(string: "http://127.0.0.1:8000")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            
            guard let data = data else {
                print("No data")
                return
            }
            let response = String(data: data, encoding: .utf8) ?? ""
            print(response)
        }
        task.resume()
    }
}

