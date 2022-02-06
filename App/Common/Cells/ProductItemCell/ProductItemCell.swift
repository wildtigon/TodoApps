//
//  ProductItemCell.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import UIKit

final class ProductItemCell: UITableViewCell {
    
    @IBOutlet weak private var lblName: UILabel!
    @IBOutlet weak private var lblPrice: UILabel!
    @IBOutlet weak private var lblQuantity: UILabel!
    
    var name: String? {
        didSet {
            lblName.text = "Name: \(name.orEmpty)"
        }
    }
    
    var price: Double = 0 {
        didSet {
            lblPrice.text = "Price: \(price)"
        }
    }
    
    var quantity: Int = 0 {
        didSet {
            lblQuantity.text = "Quantity: \(quantity)"
        }
    }
}
