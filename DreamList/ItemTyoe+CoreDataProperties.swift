//
//  ItemTyoe+CoreDataProperties.swift
//  DreamList
//
//  Created by Hardik Wason on 23/08/17.
//  Copyright © 2017 Hardik Wason. All rights reserved.
//

import Foundation
import CoreData

extension ItemTyoe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemTyoe> {
        return NSFetchRequest<ItemTyoe>(entityName: "ItemTyoe");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
