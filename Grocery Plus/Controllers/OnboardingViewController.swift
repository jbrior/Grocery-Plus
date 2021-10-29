//
//  OnboardingViewController.swift
//  Grocery Plus
//
//  Created by Jesse Brior on 10/28/21.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    
    let nameKey = "userName"
    
    let ref = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let _ = ref.object(forKey: nameKey) else {
            print("User not set!")
            return
        }
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "toHome", sender: self)
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // *********STILL NEEDS VALIDATION*********
        ref.set(textField.text, forKey: nameKey)
        performSegue(withIdentifier: "toHome", sender: self)
    }
}
