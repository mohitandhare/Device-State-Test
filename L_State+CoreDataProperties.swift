//
//  L_State+CoreDataProperties.swift
//  Device State Test
//
//  Created by Developer Skromanglobal on 20/07/22.
//
//

import Foundation
import CoreData


extension L_State {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<L_State> {
        return NSFetchRequest<L_State>(entityName: "L_State")
    }

    @NSManaged public var l1: String?
    @NSManaged public var l2: String?
    @NSManaged public var l3: String?
    @NSManaged public var l4: String?
    @NSManaged public var l5: String?
    @NSManaged public var l6: String?
    @NSManaged public var l7: String?
    @NSManaged public var l8: String?
    @NSManaged public var l9: String?
    @NSManaged public var l10: String?

}

extension L_State : Identifiable {

}
