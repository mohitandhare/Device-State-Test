//
//  DeviceList+CoreDataProperties.swift
//  Device State Test
//
//  Created by Developer Skromanglobal on 18/07/22.
//
//

import Foundation
import CoreData


extension DeviceList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeviceList> {
        return NSFetchRequest<DeviceList>(entityName: "DeviceList")
    }

    @NSManaged public var deviceStateUid: String?
    @NSManaged public var deviceUid: String?
    @NSManaged public var unique_id: String?
    @NSManaged public var modelNo: String?
    @NSManaged public var dest_button: String?
    @NSManaged public var fan_dest: String?
    @NSManaged public var config_dim: String?
    @NSManaged public var config_buttons: String?
    @NSManaged public var child_lock_l: String?
    @NSManaged public var child_lock_f: String?
    @NSManaged public var child_lock_m: String?
    @NSManaged public var master: String?
    @NSManaged public var l_state: String?
    @NSManaged public var l_speed: String?
    @NSManaged public var f_state: String?
    @NSManaged public var f_speed: String?
    @NSManaged public var test_component : String?

}

extension DeviceList : Identifiable {

}
