//
//  CoreDataProductListRepositoryTest.swift
//  DataTests
//
//  Created by Nguyen Tien Dat on 2/6/22.
//

import Foundation
import XCTest
@testable import Data

class CoreDataProductListRepositoryTest: XCTestCase {
    
    private var repo: CoreDataProductListRepositoryImpl?
    
    override func setUp() {
        repo = CoreDataProductListRepositoryImpl()
    }
    
    override func tearDown() {
        repo?.dropMe()
    }
    
    func test_repo_can_be_inited() {
        XCTAssertNotNil(repo)
    }
    
    func test_repo_generate_mock_data() {
        if let items = try? repo?.getAll() {
            XCTAssertEqual(items.count, 3) // We create 3 mock items in contructor
        } else {
            XCTFail("Can't query")
        }
    }
    
    func test_repo_empty_after_dropMe() {
        repo?.dropMe()
        
        if let items = try? repo?.getAll() {
            XCTAssertEqual(items.count, 0)
        } else {
            XCTFail("Can't query")
        }
    }
}
