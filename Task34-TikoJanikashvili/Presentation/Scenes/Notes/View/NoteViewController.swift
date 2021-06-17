//
//  ViewController.swift
//  Task34-TikoJanikashvili
//
//  Created by Tiko on 16.06.21.
//

import UIKit

class NoteViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private Properties
    private var datasource: NoteDataSource!
    
    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
        self.setupLayout()
        self.configureDataSource()
    }
    
    private func setupLayout() {
        self.tableView.registerNib(class: NoteCell.self)
    }
    
    private func configureDataSource() {
        self.datasource = NoteDataSource(with: self.tableView, navigationController: self.navigationController, viewController: self)
        self.datasource.fetch()
    }
    
    @IBAction func add(_ sender: Any) {
        let sb = UIStoryboard(name: VCIds.noteDetails, bundle: nil)
        if let vc = sb.instantiateViewController(identifier: VCIds.noteDetails) as? NoteDetailsViewController {
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension NoteViewController: NoteDetailsViewControllerDelegate {
    func editData(with note: String, at indexPath: IndexPath) {
        self.datasource.editCell(at: indexPath, newNote: note)
    }
    
    func addData(with note: String) {
        self.datasource.addCell(note: note)
    }
}
 

