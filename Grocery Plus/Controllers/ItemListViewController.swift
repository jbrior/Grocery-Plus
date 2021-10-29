//
//  ItemListViewController.swift
//  Grocery Plus
//
//  Created by Jesse Brior on 10/27/21.
//

import UIKit

class ItemListViewController: UIViewController {
    
    //UI Outlets
    @IBOutlet var tableView: UITableView!
    
    // handle for CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Array of grocerie items to populate table
    private var models = [GroceryItem]()
    
    private let emptyLabel: UILabel = {
        let lb = UILabel()
        lb.text = "No items added yet!"
        lb.font = .boldSystemFont(ofSize: 30)
        lb.textColor = .lightGray
        lb.numberOfLines = 0
        lb.textAlignment = .center
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // add subviews
        view.addSubview(emptyLabel)
    }
    
    override func viewWillLayoutSubviews() {
        emptyLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width - 60, height: 50)
        emptyLabel.center.x = view.center.x
        emptyLabel.center.y = view.center.y - 150
    }
    
    // call 'getAllItems() in 'willappear' so table updates if 'popped'
    override func viewWillAppear(_ animated: Bool) {
        
        getAllItems()
    }
    
    // Retrieve all grocery items from CoreData
    // set/update 'models' array and reload table to populate
    func getAllItems() {
        do {
            models = try context.fetch(GroceryItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            // handle error here
            print("Error with fetching data for tableview.")
        }
        
        // check if models array is empty and display 'emptyLabel' accordingly
        if models.count > 0 {
            emptyLabel.isHidden = true
        } else {
            emptyLabel.isHidden = false
        }
    }
}

//MARK: TableView Setup
//Add tableview protocals/functionality / setup table and cells

extension ItemListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = model.title?.capitalized
        return cell
    }
    
    // handle when user taps on cells
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // push to next vc when cell is tapped
        // pass selected item to next vc
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewItemViewController") as? ViewItemViewController
        vc?.selectedItem = models[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    // add swipe to delete functionality in the tableview
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // delete item in coredata and reload tableview via 'getAllItems' func
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataFunctions().deleteItem(item: models[indexPath.row])
            getAllItems()
        }
    }
}
