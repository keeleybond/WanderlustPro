//
//  CDUser+Helper.swift
//  ClassProject Wanderlust Pro
//
//  Created by Keeley Bond on 11/16/23.
//

import Foundation
import CoreData

extension CDUser {
    
    static func fetchAll() -> NSFetchRequest<CDUser> {
        let request = CDUser.fetchRequest()
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        request.sortDescriptors = [.init(keyPath: \CDUser.username, ascending: true)]
        return request
    }
}
