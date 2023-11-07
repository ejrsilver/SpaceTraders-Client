//
//  ContentView.swift
//  SpaceTraders Client
//
//  Created by Ethan Silver on 2023-11-06.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @StateObject var auth = AuthResource()

  var body: some View {
    BaseHomeView().environmentObject(auth)
  }
}
