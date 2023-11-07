//
//  Ship.swift
//  SpaceTraders Client
//
//  Created by Ethan Silver on 2023-11-06.
//

import Foundation

struct ShipRegistration: Codable {
  var name: String
  var factionSymbol: String
  var role: String
}

struct ShipDestination: Codable {
  var symbol: String
  var type: String
  var systemSymbol: String
  var x: Int
  var y: Int
}

struct ShipRoute: Codable {
  var destination: ShipDestination
  var departure: ShipDestination?
  var origin: ShipDestination
  var departureTime: String
  var arrival: String
}

enum ShipStatus: String, Codable {
  case transit = "IN_TRANSIT"
  case orbit = "IN_ORBIT"
  case docked = "DOCKED"
}

enum FlightMode: String, Codable {
  case drift = "DRIFT"
  case stealth = "STEALTH"
  case cruise = "CRUISE"
  case burn = "BURN"
}

struct ShipNavigation: Codable {
  var systemSymbol: String
  var waypointSymbol: String
  var route: ShipRoute
  var status: ShipStatus
  var flightMode: FlightMode
}

struct Ship: Codable {
  var symbol: String
  var nav: ShipNavigation
}
