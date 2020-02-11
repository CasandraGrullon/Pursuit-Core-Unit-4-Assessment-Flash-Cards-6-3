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
{
"cardListType": "q and a",
"apiVersion": "1.2.3",
"cards": [
    {
        "id": "1",
        "cardTitle": "What is the difference between a synchronous & an asynchronous task?",
        "facts": [
            "Synchronous: waits until the task have completed.",
            "Asynchronous: completes a task in the background and can notify you when complete."
        ]
    }
}
""".data(using: .utf8)!
        
        struct Model: Codable {
            let cards: [SwiftCard]
        }
        struct SwiftCard: Codable {
            let id: String
            let cardTitle: String
            let facts: [String]
        }
        
        let expTitle = "What is the difference between a synchronous & an asynchronous task?"
        
        do {
            let results = try JSONDecoder().decode(Model.self, from: jsonData)
            let cards = results.cards
            let title = cards.first?.cardTitle ?? ""
            XCTAssertEqual(expTitle, title)
        } catch {
            XCTFail("could not decode data \(error)")
        }
        
    }

}
