//
//  RegisterViewModel.swift
//  Task34-TikoJanikashvili
//
//  Created by Tiko on 17.06.21.
//

import Foundation

protocol RegisterViewModelProtocol: AnyObject {
    func register(username: String, password: String, completion: @escaping((Bool) -> Void))
//    func register()
    init(with usersManager: UsersManagerProtocol)
}

final class RegisterViewModel: RegisterViewModelProtocol {
    
    // MARK: - Private Properties
    private let usersManager: UsersManagerProtocol
    
    init(with usersManager: UsersManagerProtocol) {
        self.usersManager = usersManager
    }
    
//    func register() {
//        usersManager.register(password: "ana", username: "ana") { success in
//            print("Register \(success)")
//        }
//    }
    
    func register(username: String, password: String, completion: @escaping((Bool) -> Void)) {
        self.usersManager.register(password: password, username: username, completion: completion)
    }
}
