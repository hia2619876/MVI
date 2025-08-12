//
//  LoginReducer.swift
//  merchant
//
//  Created by adam on 2025/7/29.
//

import Foundation
import Dependencies
import SwiftUICore

class LoginReducer: ObservableObject {
    
    @Published private(set) var state = LoginState()
    @Dependency(\.userSession) var userSession
    
    init() {
        send(.loadState)// App 啟動時載入狀態
    }
    
    func send(_ intent: LoginIntent) {
        switch intent {
        case .accountChanged(let newAccount):
            state.account = newAccount
        case .loginBtnPress:
            if state.account == "123" {
                self.state.errorMessage = "123不行哦"
            }else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.userSession.login(self.state.account)
                }
            }
        case .alertDismissed:
            state.errorMessage = ""
        case .loadState:
            let savedAccount = UserDefaults.standard.string(forKey: "account") ?? ""
            let savedIsLogin = UserDefaults.standard.bool(forKey: "isLogin")
            if savedIsLogin == true {
                self.userSession.login(savedAccount)
            }
        }
        
    }
}
