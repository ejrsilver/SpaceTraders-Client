//
//  Faction.swift
//  SpaceTraders Client
//
//  Created by Ethan Silver on 2023-11-06.
//

import Foundation

struct Faction: Codable {
  var symbol: String
  var name: String
  var description: String
  var headquarters: String
  var traits: [FactionTrait]
  var isRecruiting: Bool
}

struct FactionTrait: Codable {
  var symbol: String
  var name: String
  var description: String
}
