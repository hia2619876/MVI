//
//  AppStore.swift
//  merchant
//
//  Created by adam on 2025/8/11.
//

import Foundation
import SwiftUI
import Combine

class AppStore: ObservableObject {
    @Published private(set) var state = AppState()
    
    func dispatch(_ intent: AppIntent) {
        AppReducer.reduce(state: &state, intent: intent)
    }
    
    // Push Navigation 便利方法
    func push(to route: NavigationRoute) {
        dispatch(.navigation(.push(to: route)))
    }
    
    func pop() {
        dispatch(.navigation(.pop))
    }
    
    func popToRoot() {
        dispatch(.navigation(.popToRoot))
    }
    
    func popTo(route: NavigationRoute) {
        dispatch(.navigation(.popTo(route: route)))
    }
    
    // Modal Navigation 便利方法
    func present(_ route: NavigationRoute) {
        dispatch(.navigation(.present(route: route)))
    }
    
    func dismiss() {
        dispatch(.navigation(.dismiss))
    }
    
    func dismissAll() {
        dispatch(.navigation(.dismissAll))
    }
}
