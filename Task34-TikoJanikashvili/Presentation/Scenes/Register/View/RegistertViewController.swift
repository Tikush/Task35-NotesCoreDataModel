//
//  RegistertViewController.swift
//  Task34-TikoJanikashvili
//
//  Created by Tiko on 16.06.21.
//

import UIKit

class RegistertViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Properties
    var defaults = UserDefaults.standard
    
    // MARK: - Private Properties
    private var viewModel: RegisterViewModelProtocol!
    private var usersManager: UsersManagerProtocol!
    private var persistentManager: PersistentManagerProtocol!
    
    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
    }
    
    private func configuration() {
        self.persistentManager = PersistentManager()
        self.usersManager = UsersManager(persistentManager: self.persistentManager)
        self.viewModel = RegisterViewModel(with: self.usersManager)
    }
    
    // MARK:  - IBActions
    @IBAction func onRegister(_ sender: Any) {
        self.viewModel.register(username: self.usernameTextField.text ?? "", password: self.passwordTextField.text ?? "") { success in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                // alert
            }
        }
        
//        guard let password = self.passwordTextField.text, let username = self.usernameTextField.text else { return }
//        defaults.set(username, forKey: "username")
//        defaults.set(password, forKey: "password")
//        defaults.set(true, forKey: "is_logged_in")
//        let sb = UIStoryboard(name: VCIds.note, bundle: nil)
//        let vc = sb.instantiateViewController(identifier: VCIds.note)
//        let nc = UINavigationController(rootViewController: vc)
//        self.present(nc, animated: true, completion: nil)
//        self.passwordTextField.text = ""
//        self.usernameTextField.text = ""
    }
}
