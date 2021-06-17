//
//  NoteDataSource.swift
//  Task34-TikoJanikashvili
//
//  Created by Tiko on 16.06.21.
//

import UIKit
import CoreData

class NoteDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Private Properties
    private var tableView: UITableView!
    private var navigationController: UINavigationController?
    private var viewController: NoteViewController?
    private var notesList: [Notes] = []
    private var indexPath: IndexPath?
    private var selector: Selector = .add
    
    // MARK: - Core Data
    private var context: NSManagedObjectContext? {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return nil }
        return appDelegate.persistentContainer.viewContext
    }
    
    init(with tableView: UITableView, navigationController: UINavigationController?, viewController: NoteViewController?) {
        super.init()
        self.tableView = tableView
        self.navigationController = navigationController
        self.viewController = viewController
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func fetch() {
        guard let context = self.context else { return }
        do {
            let notes = try context.fetch(Note.fetchRequest()) as [Note]
            self.notesList = notes.map { Notes(note: $0.noteName)}
        }
        catch {
            print(error)
        }
    }
    
    func addCell(note: String) {
        self.notesList.append(Notes(note: note))
        self.tableView.reloadData()
    }
    
    func editCell(at indexPath: IndexPath, newNote: String) {
        self.notesList[indexPath.row] = Notes(note: newNote)
        self.tableView.reloadRows(at: [indexPath], with: .fade)
        
        guard let context = self.context else { return }
        do {
            guard let notes = try context.fetch(Note.fetchRequest()) as? [Note] else { return }
            context.delete(notes[indexPath.row])
            do {
                try context.save()
            } catch {
                print("error : \(error)")
            }
        }
        catch {
            print(error)
        }
    }
    
    func deleteRow(at indexPath: IndexPath) {
        self.notesList.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        
        guard let context = self.context else { return }
        do {
            guard let notes = try context.fetch(Note.fetchRequest()) as? [Note] else { return }
            context.delete(notes[indexPath.row])
            do {
                try context.save()
            } catch {
                print("error : \(error)")
            }
        }
        catch {
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.notesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(NoteCell.self, for: indexPath)
        cell.setCell(with: self.notesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPath = indexPath
        self.selector = .edit
        let sb = UIStoryboard(name: VCIds.noteDetails, bundle: nil)
        if let vc = sb.instantiateViewController(identifier: VCIds.noteDetails) as? NoteDetailsViewController {
            vc.delegate = self.viewController
            vc.indexPath = indexPath
            vc.selector = self.selector
            vc.note = self.notesList[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return [
            UITableViewRowAction(style: .normal, title: "Delete", handler: { action, indexPath in
                self.deleteRow(at: indexPath)
            })
        ]
    }
}
