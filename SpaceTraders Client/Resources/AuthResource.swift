//
//  Auth.swift
//  papeasy
//
//  Created by Ethan Silver on 2023-11-02.
//

import Foundation

class AuthResource: StaticResource<AgentCredentials, ResponseData<Auth?>?> {
  init() {
    super.init(from: nil, path: "/register")
    self.auth = AuthResource.getTokenFromKeychain()
  }
  
  init(test: Bool) {
    super.init(from: nil, path: "/register")
  }
  
  func register(symbol: String, faction: String) async throws -> Void {
    try await self.send(forItem: AgentCredentials(symbol: symbol, faction: faction))
  
    guard AuthResource.saveTokenToKeychain(self.model!.data!.token) else {
      throw AuthError.TokenSaveFailure
    }
  }

  func logout() {
    if AuthResource.deleteTokenFromKeychain() {
      self.model = nil
    }
  }
  
  static func deleteTokenFromKeychain() -> Bool {
      let query = [
          kSecClass as String: kSecClassGenericPassword as String,
          kSecAttrAccount as String: KeychainKey,
      ] as CFDictionary

      let status = SecItemDelete(query)
      return status == errSecSuccess
  }

  static func saveTokenToKeychain(_ token: String) -> Bool {
      let query = [
          kSecClass as String: kSecClassGenericPassword as String,
          kSecAttrAccount as String: KeychainKey,
          kSecValueData as String: token.data(using: .utf8)!
      ] as CFDictionary

      SecItemDelete(query)
      let status = SecItemAdd(query, nil)
      return status == errSecSuccess
  }
  
  static func getTokenFromKeychain() -> Auth? {
      let query = [
          kSecClass as String: kSecClassGenericPassword as String,
          kSecAttrAccount as String: KeychainKey,
          kSecReturnData as String: kCFBooleanTrue!,
          kSecMatchLimit as String: kSecMatchLimitOne
      ] as CFDictionary

      var item: CFTypeRef?
      let status = SecItemCopyMatching(query, &item)
      
    if status == errSecSuccess, let data = item as? Data {
      guard let token = String(data: data, encoding: .utf8) else {
        return nil
      }
      return Auth(token: token)
    }
    else {
      return nil
    }
  }
}

