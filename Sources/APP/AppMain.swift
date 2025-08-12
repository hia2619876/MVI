//
//  AppMain.swift
//  merchant
//
//  Created by adam on 2025/7/29.
//

import SwiftUI

@main
struct AppMain: App {
    var body: some Scene {
        
        @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        
        WindowGroup {
            RootView()
        }
    }
}
