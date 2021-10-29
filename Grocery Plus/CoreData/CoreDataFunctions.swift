//
//  CoreDataFunctions.swift
//  Grocery Plus
//
//  Created by Jesse Brior on 10/27/21.
//

import UIKit

class CoreDataFunctions {
    
    // handle for CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Add new item to CoreData
    func createItem(title: String, itemNote: String, category: String) {
        let newItem = GroceryItem(context: context)
        newItem.title = title
        newItem.item_notes = itemNote
        newItem.category = category
        newItem.date_added = Date()
        
        do {
            try context.save()
        }
        catch {
            // handle error
            print("Error creating new item in CoreData.")
        }
    }
    
    // delete item from CoreData
    func deleteItem(item: GroceryItem) {
        context.delete(item)
        
        do {
            try context.save()
        }
        catch {
            // handle error
            print("Error deleting item from CoreData.")
        }
    }
    
    // update item inside CoreData
    func updateItem(item: GroceryItem, newTitle: String, newNote: String) {
        item.title = newTitle
        item.item_notes = newNote
        
        do {
            try context.save()
        }
        catch {
            // handle error
            print("Error updating item in CoreData.")
        }
    }
}
