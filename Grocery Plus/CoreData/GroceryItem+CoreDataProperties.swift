//
//  GroceryItem+CoreDataProperties.swift
//  Grocery Plus
//
//  Created by Jesse Brior on 10/27/21.
//
//

import Foundation
import CoreData


extension GroceryItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryItem> {
        return NSFetchRequest<GroceryItem>(entityName: "GroceryItem")
    }

    @NSManaged public var date_added: Date?
    @NSManaged public var title: String?
    @NSManaged public var item_notes: String?
    @NSManaged public var category: String?

}

extension GroceryItem : Identifiable {

}
