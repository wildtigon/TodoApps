//
//  Contact+CellDescriptor.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/6/22.
//

import Foundation
import Domain

extension CellDescriptor {
    static var contactCell: ((Contact) -> CellDescriptor) = { contact in
        CellDescriptor(cellHeight: 80) { (cell: ContactCell) in
            cell.name = contact.name
            cell.number = contact.number
        }
    }
}

