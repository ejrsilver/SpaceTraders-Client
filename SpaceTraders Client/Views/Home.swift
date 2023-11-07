//
//  Home.swift
//  SpaceTraders Client
//
//  Created by Ethan Silver on 2023-11-06.
//

import Foundation
import SwiftUI

struct BaseHomeView: View {
  @EnvironmentObject var auth: AuthResource
  @State var showSignup: Bool = false
  @State var showSamples: Bool = false
  
  var body: some View {
    VStack {
      if auth.auth != nil {
        AuthorizedHomeView().environmentObject(auth)
      } else {
        Button("Sign up") {
          showSignup = true
        }
      }
    }.padding().popover(isPresented: $showSignup) {
      RegistrationView(show: $showSignup)
    }
      
  }
}

struct AuthorizedHomeView: View {
  @EnvironmentObject var auth: AuthResource
  @StateObject var user = DynamicResource<ResponseData<Agent>?>(from: nil, path: "/my/agent")
  @State private var isLoading: Bool = false

  func loadUser() async {
    guard let auth = auth.auth else { return }
    user.setup(auth: auth)
    isLoading = true
    do {
      try await user.retrieve()
    } catch {
      print("\(error)")
    }
    isLoading = false
  }
  
  var body: some View{
    NavigationStack {
      VStack {
        if let agent = user.model?.data {
          Text("Welcome, \(agent.symbol) of faction \(agent.startingFaction)!").font(.headline)
        } else if isLoading {
          ProgressView()
        }
      }.navigationTitle("Home")
        .task {
          await loadUser()
        }.refreshable {
          await loadUser()
        }
    }
  }
}

#Preview("Home") {
  BaseHomeView().environmentObject(AuthResource())
}
