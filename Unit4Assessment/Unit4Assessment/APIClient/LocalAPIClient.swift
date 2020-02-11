//
//  LocalAPIClient.swift
//  Unit4Assessment
//
//  Created by casandra grullon on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

public enum ServiceError: Error {
  case resourcePathDoesNotExist
  case contentsNotFound
  case decodingError(Error)
}

class LocalDataAPI {
  public static func getCards() throws -> [Cards] {
    guard let path = Bundle.main.path(forResource: "FlashCards", ofType: "json") else {
      throw ServiceError.resourcePathDoesNotExist
    }
    guard let json = FileManager.default.contents(atPath: path) else {
      throw ServiceError.contentsNotFound
    }
    do {
      let stocks = try JSONDecoder().decode(FlashCards.self, from: json)
        return stocks.cards
    } catch {
      throw ServiceError.decodingError(error)
    }
  }
}
