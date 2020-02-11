//
//  FlashCard.swift
//  Unit4Assessment
//
//  Created by casandra grullon on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

//struct FlashCards: Codable & Equatable {
//    let cards: [Cards]
//}
struct Cards: Codable & Equatable {
    let quizTitle: String
    let facts: [String]
}
