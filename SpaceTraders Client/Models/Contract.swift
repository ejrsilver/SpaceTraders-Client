//
//  Contract.swift
//  SpaceTraders Client
//
//  Created by Ethan Silver on 2023-11-06.
//

import Foundation

enum ContractType: String, Codable {
  case procurement = "PROCUERMENT"
  case transport = "TRANSPORT"
  case shuttle = "SHUTTLE"
}

struct ContractTermsPayment: Codable {
  var onAccepted: Int
  var onFulfilled: Int
}

struct DeliverableGoods: Codable {
  var tradeSymbol: String
  var destinationSymbol: String
  var unitsRequired: Int
  var unitsFulfilled: Int
}

struct ContractTerms: Codable {
  var deadline: String
  var payment: ContractTermsPayment
  var deliver: [DeliverableGoods?]
}

struct Contract: Codable {
  var id: String
  var factionSymbol: String
  var type: ContractType
  var terms: ContractTerms
  var accepted: Bool
  var fulfilled: Bool
  var expiration: String?
  var deadlineToAccept: String
}
