//
//  AppNavigationReducer.swift
//  merchant
//
//  Created by adam on 2025/8/11.
//

import Foundation
import SwiftUI

struct NavigationReducer {
    static func reduce(state: inout NavigationState, intent: NavigationIntent) {
        switch intent {
        case .push(let route):
            state.pushPath.append(route)
            state.currentPushRoute = route
            state.pushHistory.append(route)
            
        case .pop:
            if !state.pushPath.isEmpty {
                state.pushPath.removeLast()
                if state.pushHistory.count > 1 {
                    state.pushHistory.removeLast()
                    state.currentPushRoute = state.pushHistory.last ?? .login
                }
            }
            
        case .popToRoot:
            state.pushPath = NavigationPath()
            state.currentPushRoute = .login
            state.pushHistory = [.login]
            
        case .popTo(let targetRoute):
            popToSpecificRoute(state: &state, targetRoute: targetRoute)
            
        // Modal Navigation
        case .present(let route):
            state.presentedRoutes.append(route)
            state.currentModalRoute = route
            
        case .dismiss:
            if !state.presentedRoutes.isEmpty {
                state.presentedRoutes.removeLast()
                state.currentModalRoute = state.presentedRoutes.last
            }
            
        case .dismissAll:
            state.presentedRoutes.removeAll()
            state.currentModalRoute = nil
        }
    }
    
    private static func popToSpecificRoute(state: inout NavigationState, targetRoute: NavigationRoute) {
        if let targetIndex = state.pushHistory.firstIndex(of: targetRoute) {
            state.pushHistory = Array(state.pushHistory[...targetIndex])
            state.currentPushRoute = targetRoute
            
            state.pushPath = NavigationPath()
            for route in state.pushHistory.dropFirst() {
                state.pushPath.append(route)
            }
        }
    }
}
