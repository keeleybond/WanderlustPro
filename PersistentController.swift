//
//  PersistentController.swift
//  ClassProject Wanderlust Pro
//
//  Created by Keeley Bond on 11/16/23.
//

import Foundation
import CoreData

class PersistentController {
    
    static let shared = PersistentController()
    
    let container: NSPersistentContainer
    
    private init() {
        self.container = NSPersistentContainer(name: "WanderlustApp")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                print(#function, error, error.userInfo)
            }
        }
    }
}
