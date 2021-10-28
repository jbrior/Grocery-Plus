//
//  AddItemViewController.swift
//  Grocery Plus
//
//  Created by Jesse Brior on 10/27/21.
//

import UIKit

class AddItemViewController: UIViewController {
    
    //UI Outlets
    @IBOutlet var titleField: UITextField!
    @IBOutlet var itemNoteField: UITextField!
    @IBOutlet var pickerView: UIPickerView!
    
    // ref to CoreData Functions
    let cdf = CoreDataFunctions()
    
    var pickerViewValue = String()
    
    let categories : [String] = [
        "Beverages",
        "Bread & Bakery",
        "Breakfast & Cereal",
        "Canned Goods & Soups",
        "Condiments/Spices & Bake",
        "Cookies, Snacks & Candy",
        "Dairy, Eggs & Cheese",
        "Deli & Signature Cafe",
        "Flowers",
        "Frozen Foods",
        "Produce: Fruits & Vegetables",
        "Grains, Pasta & Sides",
        "International Cuisine",
        "Meat & Seafood",
        "Miscellaneous",
        "Paper Products",
        "Cleaning Supplies",
        "Health & Beauty",
        "Pet Care",
        "Pharmacy"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set textfields delegate
        titleField.delegate = self
        itemNoteField.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        
        styleTextFields()
    }
    
    // When the Save button is tapped
    @IBAction func addNewItem(_ sender: UIButton) {
        
        // check if fields are empty or not
        // *********validation still needs work*********
        guard let title = titleField.text, !title.isEmpty else {
            print("error: no title entered")
            return
        }
        guard let note = itemNoteField.text, !note.isEmpty else {
            print("no note entered")
            return
        }
        
        cdf.createItem(title: title, itemNote: note, category: pickerViewValue)
        
        // Alert user the new item has been added
        // And pop back to root controller
        let alert = UIAlertController(title: "Added new item successfully!",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// Dissmiss keyboard upon tapping the "return" key
extension AddItemViewController: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    private func styleTextFields() {
        // style UI elements programatically
        titleField.layer.borderColor = UIColor.link.cgColor
        titleField.layer.borderWidth = 2
        titleField.layer.cornerRadius = 10
        
        itemNoteField.layer.borderColor = UIColor.link.cgColor
        itemNoteField.layer.borderWidth = 2
        itemNoteField.layer.cornerRadius = 10
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerViewValue = categories[row]
    }
}
