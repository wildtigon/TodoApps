//
//  ContactDTO.swift
//  Data
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Foundation
import Domain

public struct ContactDTO: Codable {
    let id: Int
    let name: String
    let number: String
    
    var asDomain: Contact {
        Contact(id: id, name: name, number: number)
    }
}
