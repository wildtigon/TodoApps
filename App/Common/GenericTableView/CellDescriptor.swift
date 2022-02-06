//
//  CellDescriptor.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/6/22.
//

import UIKit

struct CellDescriptor {
    let cellClass: UITableViewCell.Type
    let cellHeight: CGFloat
    let configure: (UITableViewCell) -> ()
    
    init<Cell: UITableViewCell>(cellHeight: CGFloat, configure: @escaping (Cell) -> ()) {
        self.cellClass = Cell.self
        self.cellHeight = cellHeight
        self.configure = { cell in
            configure(cell as! Cell)
        }
    }
}
