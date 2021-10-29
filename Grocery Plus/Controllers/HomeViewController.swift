//
//  ViewController.swift
//  Grocery Plus
//
//  Created by Jesse Brior on 10/27/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    let user = (UserDefaults.standard.object(forKey: "userName") as! String).capitalized

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hello, \(user)!"
        navigationItem.backButtonTitle = "back"
    }
}

