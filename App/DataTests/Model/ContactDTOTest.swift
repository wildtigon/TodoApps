//
//  ContactDTOTest.swift
//  DataTests
//
//  Created by Nguyen Tien Dat on 2/6/22.
//

import Foundation
import XCTest
import Domain
@testable import Data

class ContactDTOTest: XCTestCase {
    func test_as_Domain() {
        let dtoObject = ContactDTO(id: 1, name: "Tigon", number: "123")
        let domainObject = dtoObject.asDomain
        
        XCTAssertEqual(domainObject.id, 1)
        XCTAssertEqual(domainObject.name, "Tigon")
        XCTAssertEqual(domainObject.number, "123")
    }
}
