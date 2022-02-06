//
//  ProductItem+CellDescriptor.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/6/22.
//

import Foundation
import Domain

extension CellDescriptor {
    static var productCell: ((ProductItem) -> CellDescriptor) = { productItem in
        CellDescriptor(cellHeight: 120) { (cell: ProductItemCell) in
            cell.name = productItem.name
            cell.price = productItem.price
            cell.quantity = productItem.quantity
        }
    }
}
