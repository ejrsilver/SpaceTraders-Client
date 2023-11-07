//
//  Agent.swift
//  SpaceTraders Client
//
//  Created by Ethan Silver on 2023-11-06.
//

import Foundation

struct AgentCredentials: Codable {
  var symbol: String
  var faction: String
}

struct Agent: Codable {
  var accountId: String?
  var symbol: String
  var headquarters: String
  var credits: Int64
  var startingFaction: String
  var shipCount: Int?
}

struct RegistrationResponse: Codable {
  var agent: Agent
  var contract: Contract
  var faction: Faction
}

