//
//  RootReducer.swift
//  merchant
//
//  Created by adam on 2025/7/29.
//

import Foundation
import Dependencies
import SwiftUICore

class RootReducer: ObservableObject {
    
    @Published private(set) var state = RootState()
    @Dependency(\.userSession) var userSession
    
    init() {
        reduce(.loadState)// App 啟動時載入狀態
    }
    
    func reduce(_ intent: RootIntent) {
        switch intent {
        case .loadState:
            let savedAccount = UserDefaults.standard.string(forKey: "account") ?? ""
            let savedIsLogin = UserDefaults.standard.bool(forKey: "isLogin")
            if savedIsLogin == true {
                self.userSession.login(savedAccount)
            }
        }
    }
}
