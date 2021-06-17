//
//  NoteCell.swift
//  Task34-TikoJanikashvili
//
//  Created by Tiko on 16.06.21.
//

import UIKit

class NoteCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var noteLabel: UILabel!

    func setCell(with item: Notes) {
        self.noteLabel.text = item.note
    }
}
