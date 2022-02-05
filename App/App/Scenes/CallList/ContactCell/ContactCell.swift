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
    
    var titleName: String? {
        didSet {
            lblName.text = "Name: \(titleName.orEmpty)"
        }
    }
    
    var titlePhone: String? {
        didSet {
            lblPhone.text = "Phone: \(titlePhone.orEmpty)"
        }
    }
}
