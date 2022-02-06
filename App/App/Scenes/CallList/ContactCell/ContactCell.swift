//
//  ContactCell.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import UIKit

final class ContactCell: UITableViewCell {
    
    @IBOutlet weak private var lblName: UILabel!
    @IBOutlet weak private var lblPhone: UILabel!
    
    var name: String? {
        didSet {
            lblName.text = "Name: \(name.orEmpty)"
        }
    }
    
    var number: String? {
        didSet {
            lblPhone.text = "Phone: \(number.orEmpty)"
        }
    }
}
