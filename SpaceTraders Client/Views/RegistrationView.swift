//
//  RegistrationView.swift
//  SpaceTraders Client
//
//  Created by Ethan Silver on 2023-11-06.
//

import Foundation
import SwiftUI

struct RegistrationView: View {
  @Binding var show: Bool

  @EnvironmentObject var auth: AuthResource
  @State private var symbol: String = ""
  @State private var faction: String = "COSMIC"
  @State var resp: String?
  @State private var isLoading = false

  private func onLogin() async {
    isLoading = true
    do {
      try await auth.register(symbol: symbol, faction: faction)
      resp = "Login Successul!"
      show = false
    } catch ResourceError.Failure(let message) {
      resp = "\(message)"
    } catch {
      print("\(error)")
    }
    isLoading = false
  }
  
  var body: some View {
    ZStack {
      if isLoading {
        ProgressView()
      } else if let success = resp, auth.model != nil {
        Text(success)
      } else {
        VStack {
          Spacer()
          Text("Login")
          TextField("Symbol (Unique Call Sign)", text: $symbol)
          TextField("Faction", text: $faction)
          Button("Create User") {
            Task {
              await onLogin()
            }
          }.buttonStyle(.borderedProminent)
          Spacer()
          if let error = self.resp {
            Text(error);
          }
        }.padding(.all, 30.0)
      }
    }
  }
}

#Preview("Success") {
  @State var isCreateLoading = false
  @State var isLoading = false
  
  return RegistrationView(
    show: $isCreateLoading, resp: "Success!"
  ).environmentObject(AuthResource())
}

#Preview("Default") {
  @State var isCreateLoading = false
  @State var isLoading = false
  
  return RegistrationView(
    show: $isCreateLoading
  ).environmentObject(AuthResource())
}

#Preview("Not Authenticated") {
  @State var isCreateLoading = false
  @State var isLoading = false
  
  return RegistrationView(
    show: $isCreateLoading, resp: "Invalid parameter(s): device_id"
  ).environmentObject(AuthResource())
}
