//
//  NoteDetailsViewController.swift
//  Task34-TikoJanikashvili
//
//  Created by Tiko on 16.06.21.
//

import UIKit
import CoreData

protocol NoteDetailsViewControllerDelegate: AnyObject {
    func addData(with note: String)
    func editData(with note: String, at indexPath: IndexPath)
}

class NoteDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    // MARK: - Private Properties
    private var context: NSManagedObjectContext? {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return nil }
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Internal Properties
    weak var delegate: NoteDetailsViewControllerDelegate?
    var note: Notes?
    var indexPath: IndexPath?
    var selector: Selector = .add
    
    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.text = note?.note ?? ""
    }
    
    // MARK: - IBActions
    @IBAction func changeValue(_ sender: Any) {
        if self.selector == .add {
            guard let context = context else {return}
            guard let description = NSEntityDescription.entity(forEntityName: "Note", in: context) else { return }
            let note = NSManagedObject(entity: description, insertInto: context)
            note.setValue(self.textField.text, forKey: "noteName")
            self.delegate?.addData(with: self.textField.text ?? "")
            
            do {
                try context.save()
                print("saved")
                self.navigationController?.popViewController(animated: true)
            }
            catch {
                print(error)
            }
        } else if self.selector == .edit {
            if let indexPath = self.indexPath {
                self.delegate?.editData(with: self.textField.text ?? "", at: indexPath)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
