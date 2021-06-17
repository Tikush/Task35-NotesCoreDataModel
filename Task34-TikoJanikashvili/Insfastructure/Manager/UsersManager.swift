//
//  UsersManager.swift
//  Task34-TikoJanikashvili
//
//  Created by Tiko on 17.06.21.
//

import Foundation

protocol UsersManagerProtocol: BasePersistentProtocol {
    func login(password: String, username: String, completion: @escaping((Bool) -> Void))
    func register(password: String, username: String, completion: @escaping ((Bool) -> Void))
    init(persistentManager: PersistentManagerProtocol)
}

final class UsersManager: UsersManagerProtocol {
    
    // MARK: - Private Properties
    private let persistentManager: PersistentManagerProtocol!
    
    init(persistentManager: PersistentManagerProtocol) {
        self.persistentManager = persistentManager
    }
    
    func login(password: String, username: String, completion: @escaping ((Bool) -> Void)) {
        guard let context = context else { return }
        
        let user = User(context: context)
        let predicate = NSPredicate(format: "%K = %@", "password", password)
        self.persistentManager.read(with: user, using: predicate, completion: completion)
    }
    
    func register(password: String, username: String, completion: @escaping ((Bool) -> Void)) {
        guard let context = context else { return }
        let user = User(context: context)
        user.username = username
        user.password = password
        self.persistentManager.create(with: user, completion: completion)
    }
}
