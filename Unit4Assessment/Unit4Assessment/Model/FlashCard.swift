//
//  FlashCard.swift
//  Unit4Assessment
//
//  Created by casandra grullon on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

struct FlashCards: Codable {
    let cards: [Cards]
}
struct Cards: Codable {
    let id: String
    let cardTitle: String
    let facts: [String]
}
