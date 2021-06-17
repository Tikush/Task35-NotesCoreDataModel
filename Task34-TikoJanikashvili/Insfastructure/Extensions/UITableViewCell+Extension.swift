//
//  UITableViewCell+Extension.swift
//  Task34-TikoJanikashvili
//
//  Created by Tiko on 16.06.21.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle.main)
    }
}

