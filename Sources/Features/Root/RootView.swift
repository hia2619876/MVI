//
//  RootView.swift
//  merchant
//
//  Created by adam on 2025/7/29.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var reducer = RootReducer()
    @State private var path: [String] = []
    @ObservedObject var userSession = UserSession.shared
    @StateObject private var store = AppStore()

    var body: some View {
        NavigationStack(path: .constant(store.state.navigation.pushPath)) {
            LoginView()
                .navigationDestination(for: NavigationRoute.self) { route in
                    // 這裡定義每個 Route 對應的 View
                    routeView(for: route)
                }
        }
        .environmentObject(store)
        .sheet(isPresented: .constant(store.state.navigation.isModalPresented)) {
            if let modalRoute = store.state.navigation.topModalRoute {
                NavigationView {
                    routeView(for: modalRoute)
                }
                .environmentObject(store)
            }
        }
    }
    
    @ViewBuilder
    private func routeView(for route: NavigationRoute) -> some View {
        switch route {
        case .login:
            LoginView()
        case .home(let account):
            HomeView(account: account)
        case .detail(let itemID):
            LoginView()
        }
    }
}
