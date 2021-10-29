//
//  EditItemViewController.swift
//  Grocery Plus
//
//  Created by Jesse Brior on 10/27/21.
//

import UIKit

class EditItemViewController: UIViewController {
    
    // UI Outlets
    @IBOutlet var titleField: UITextField!
    @IBOutlet var noteField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    // ref to CoreData Functions
    let cdf = CoreDataFunctions()
    
    // passed item from previous vc
    var selectedItem = GroceryItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set texfield delegates
        titleField.delegate = self
        noteField.delegate = self
        
        // set textfields text to display item that is being edited
        titleField.text = selectedItem.title
        noteField.text = selectedItem.item_notes
        
        // format date to be displayed as string in 'dateLabel'
        let date = selectedItem.date_added
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        let dateAdded = dateFormatter.string(from: date!)
        dateLabel.text = dateAdded
    }
    
    // Delete button tapped
    @IBAction func deleteButtontapped(_ sender: UIButton) {
        // Verify that user wants to delete selected item
        let alert = UIAlertController(title: "Are you sure you would like to delete this item?",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            // item deleted and popping back to root vc
            self.cdf.deleteItem(item: self.selectedItem)
            self.navigationController?.popToRootViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    // update button tapped
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        
        // check if fields are empty or not
        // *********STILL NEEDS VALIDATION*********
        guard let title = titleField.text, !title.isEmpty else {
            return
        }
        guard let note = noteField.text, !note.isEmpty else {
            return
        }
        
        cdf.updateItem(item: selectedItem, newTitle: title, newNote: note)
        
        // pop back to root vc
        navigationController?.popToRootViewController(animated: true)
    }
}

// Dissmiss keyboard upon tapping the "return" key
extension EditItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
