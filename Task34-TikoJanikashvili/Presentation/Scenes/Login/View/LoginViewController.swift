//
//  LoginViewController.swift
//  Task34-TikoJanikashvili
//
//  Created by Tiko on 16.06.21.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBoutlets
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    // MARK: - Private Properties
    var register = RegistertViewController()
    private var viewModel: LoginViewModelProtocol!
    private var usersManager: UsersManagerProtocol!
    private var persistentManager: PersistentManagerProtocol!
    
    // MARK: Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
    }
    
    private func configuration() {
        self.persistentManager = PersistentManager()
        self.usersManager = UsersManager(persistentManager: self.persistentManager)
        self.viewModel = LoginViewModel(with: self.usersManager)
    }

    @IBAction func login(_ sender: Any) {
        self.viewModel.login(username: self.usernameTextField.text ?? "", password: self.passwordTextField.text ?? "") { success in
            if success {
                let sb = UIStoryboard(name: VCIds.note, bundle: nil)
                let vc = sb.instantiateViewController(identifier: VCIds.note)
                let nc = UINavigationController(rootViewController: vc)
                self.present(nc, animated: true, completion: nil)
                self.passwordTextField.text = ""
                self.usernameTextField.text = ""
            } else {
                print("login failed")
            }
        }
        
//        let password = register.defaults.string(forKey: "password")
//        let username = register.defaults.string(forKey: "username")
//        if self.passwordTextField.text == password && self.passwordTextField.text == username {
//            let sb = UIStoryboard(name: VCIds.note, bundle: nil)
//            let vc = sb.instantiateViewController(identifier: VCIds.note)
//            let nc = UINavigationController(rootViewController: vc)
//            self.present(nc, animated: true, completion: nil)
//            self.passwordTextField.text = ""
//            self.usernameTextField.text = ""
//        }
    }

     @IBAction func register(_ sender: Any) {
        let sb = UIStoryboard(name: VCIds.register, bundle: nil)
        let vc = sb.instantiateViewController(identifier: VCIds.register)
        self.present(vc, animated: true, completion: nil)
     }
}
