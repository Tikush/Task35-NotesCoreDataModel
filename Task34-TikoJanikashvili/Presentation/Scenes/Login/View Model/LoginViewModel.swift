//
//  LoginViewModel.swift
//  Task34-TikoJanikashvili
//
//  Created by Tiko on 17.06.21.
//

import Foundation

protocol LoginViewModelProtocol: AnyObject {
    func login(username: String, password: String, completion: @escaping((Bool) -> Void))
    init(with usersManager: UsersManagerProtocol)
}

final class LoginViewModel: LoginViewModelProtocol {
    
    // MARK: - Private Properties
    private let usersManager: UsersManagerProtocol
    
    init(with usersManager: UsersManagerProtocol) {
        self.usersManager = usersManager
    }
    
    func login(username: String, password: String, completion: @escaping ((Bool) -> Void)) {
        usersManager.login(password: password, username: username, completion: completion)
    }
}
