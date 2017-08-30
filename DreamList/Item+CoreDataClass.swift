//
//  Item+CoreDataClass.swift
//  DreamList
//
//  Created by Hardik Wason on 23/08/17.
//  Copyright © 2017 Hardik Wason. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }

}
