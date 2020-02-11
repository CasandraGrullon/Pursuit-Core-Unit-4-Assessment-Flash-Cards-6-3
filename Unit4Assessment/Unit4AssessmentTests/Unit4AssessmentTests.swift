//
//  Unit4AssessmentTests.swift
//  Unit4AssessmentTests
//
//  Created by Alex Paul on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import XCTest
@testable import Unit4Assessment

class Unit4AssessmentTests: XCTestCase {

    func testAPIData() {
        let jsonData = """
  [{
"id": "1",
"quizTitle": "What is the difference between Synchronous & Asynchronous task",
"facts": [
"Synchronous: waits until the task have completed",
"Asynchronous: completes a task in the background and can notify you when complete"
    ]
  }]
""".data(using: .utf8)!
        
        struct SwiftCard: Codable {
            let id: String
            let quizTitle: String
            let facts: [String]
        }
        
        let expTitle = "What is the difference between Synchronous & Asynchronous task"
        
        do {
            let results = try JSONDecoder().decode([SwiftCard].self, from: jsonData)
            let title = results.first?.quizTitle ?? ""
            XCTAssertEqual(expTitle, title)
        } catch {
            XCTFail("could not decode data \(error)")
        }
        
    }

}
