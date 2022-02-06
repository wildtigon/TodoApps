//
//  ProductItemDTOTest.swift
//  DataTests
//
//  Created by Nguyen Tien Dat on 2/6/22.
//

import Foundation
import XCTest
import Domain
@testable import Data

class ProductItemDTOTest: XCTestCase {
    func test_as_Domain() {
        let dtoObject = ProductItemDTO(id: 1, name: "Tigon", price: 1000, quantity: 1, type: 2)
        let domainObject = dtoObject.asDomain
        
        XCTAssertEqual(domainObject.id, 1)
        XCTAssertEqual(domainObject.name, "Tigon")
        XCTAssertEqual(domainObject.price, 1000)
        XCTAssertEqual(domainObject.quantity, 1)
        XCTAssertEqual(domainObject.type, 2)
    }
}
