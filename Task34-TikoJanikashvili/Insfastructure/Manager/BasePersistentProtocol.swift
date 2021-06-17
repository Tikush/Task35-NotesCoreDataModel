//
//  BasePersistentProtocol.swift
//  Task34-TikoJanikashvili
//
//  Created by Tiko on 17.06.21.
//

import CoreData
import UIKit

protocol BasePersistentProtocol: AnyObject {
    var context: NSManagedObjectContext? { get }
}

extension BasePersistentProtocol {
    var context: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
}
