//
//  AppReducer.swift
//  merchant
//
//  Created by adam on 2025/8/11.
//

import Foundation

struct AppReducer {
    static func reduce(state: inout AppState, intent: AppIntent) {
        switch intent {
        case .navigation(let navIntent):
            NavigationReducer.reduce(state: &state.navigation, intent: navIntent)
            
        case .setLoading(let isLoading):
            state.isLoading = isLoading
        }
    }
}
