//
//  ViewItemViewController.swift
//  Grocery Plus
//
//  Created by Jesse Brior on 10/27/21.
//

import UIKit

class ViewItemViewController: UIViewController {
    
    //UI Outlets
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var noteLabel: UILabel!
    
    // passed item from previous vc
    var selectedItem = GroceryItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedItem.title?.capitalized
        
        // format date to be displayed as string in 'dateLabel'
        let date = selectedItem.date_added
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        let dateAdded = dateFormatter.string(from: date!)
        dateLabel.text = dateAdded
        
        noteLabel.text = selectedItem.item_notes
    }
    
    // push to next vc when cell is tapped
    // pass selected item to next vc
    @IBAction func pushToEditView(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EditItemViewController") as? EditItemViewController
        vc?.selectedItem = selectedItem
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
