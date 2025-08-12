//
//  NavigationRoute.swift
//  merchant
//
//  Created by adam on 2025/8/11.
//

import Foundation
import SwiftUI

enum NavigationRoute: Hashable {
    
    case login
    case home(account: String)
    case detail(itemId: Int)
    
    var title: String {
        switch self {
        case .login: return "登入頁"
        case .home: return "首頁"
        case .detail: return "詳細內容"
        }
    }
}

enum NavigationIntent {
    case push(to: NavigationRoute)
    case pop
    case popToRoot
    case popTo(route: NavigationRoute)
    case present(route: NavigationRoute)
    case dismiss
    case dismissAll
}

struct NavigationState {
    var pushPath: NavigationPath
    var currentPushRoute: NavigationRoute
    var pushHistory: [NavigationRoute]
    var presentedRoutes: [NavigationRoute]  // Stack of presented modals
    var currentModalRoute: NavigationRoute?
    
    var isModalPresented: Bool {
        !presentedRoutes.isEmpty
    }
    
    var topModalRoute: NavigationRoute? {
        presentedRoutes.last
    }
    
    init() {
        self.pushPath = NavigationPath()
        self.currentPushRoute = .login
        self.pushHistory = [.login]
        self.presentedRoutes = []
        self.currentModalRoute = nil
    }
    
}
