//
//  HomeReducer.swift
//  merchant
//
//  Created by adam on 2025/7/29.
//

import Foundation
import Dependencies

class HomeReducer: ObservableObject {
    @Dependency(\.userSession) var userSession
    
    func reduce(state: HomeState, intent: HomeIntent) -> HomeState {
        switch intent {
        case .logoutClicked:
            return .loading
        case .loadAnnouncements:
            return .loading
            
        case .announcementsLoaded(let announcements):
            return .success(announcements)
            
        case .announcementsError(let error):
            return .error(error)
        }
    }
}
