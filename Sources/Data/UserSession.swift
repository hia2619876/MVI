//
//  UserSession.swift
//  merchant
//
//  Created by adam on 2025/8/1.
//

import Foundation
import ComposableArchitecture

// MARK: - UserSession Singleton State

final class UserSession : ObservableObject{
    static let shared = UserSession()
    private init() {}

    @Published var account: String = ""
    @Published var isLoggedIn: Bool = false
}

// MARK: - UserSessionClient Interface

struct UserSessionClient: Sendable {
    var account: @Sendable () -> String
    var isLoggedIn: @Sendable () -> Bool
    var login: @Sendable (_ account: String) -> Void
    var logout: @Sendable () -> Void
}

// MARK: - Live Implementation

extension UserSessionClient: DependencyKey {
    static let liveValue = UserSessionClient(
        account: { UserSession.shared.account },
        isLoggedIn: { UserSession.shared.isLoggedIn },
        login: { account in
            UserSession.shared.account = account
            UserSession.shared.isLoggedIn = true
            UserDefaults.standard.set(account, forKey: "account")
            UserDefaults.standard.set(true, forKey: "isLogin")
            UserDefaults.standard.synchronize()
            print("登入成功：\(account)")
        },
        logout: {
            UserSession.shared.account = ""
            UserSession.shared.isLoggedIn = false
            UserDefaults.standard.removeObject(forKey: "account")
            UserDefaults.standard.removeObject(forKey: "isLogin")
            UserDefaults.standard.synchronize()
            print("登出成功")
        }
    )
}

// MARK: - Dependency Injection Access

extension DependencyValues {
    var userSession: UserSessionClient {
        get { self[UserSessionClient.self] }
        set { self[UserSessionClient.self] = newValue }
    }
}
