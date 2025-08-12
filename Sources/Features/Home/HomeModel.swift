//
//  HomeModel.swift
//  merchant
//
//  Created by adam on 2025/8/12.
//

import Foundation
import Dependencies

final class HomeModel: ObservableObject {
    
    @Published var state: HomeState = .idle
    @Published var account: String = ""
    @Published var errorMessage: String = ""
    @Published var announcements: [AnnoModel] = []
    @Published var isLoadingAnnouncements: Bool = false
    @Published var announcementError: String? = nil
    
    @Dependency(\.userSession) var userSession
    
    func send(intent: HomeIntent){
        self.state = HomeReducer().reduce(state: self.state, intent: intent)
        
        if case .logoutClicked = intent {
            self.userSession.logout()
        }
        if case .loadAnnouncements = intent {
            HomeEffect.getAnno { result in
                switch result {
                    case .success(let data):
                        self.announcements = data
                        self.send(intent: .announcementsLoaded(data))
                    case .failure(let error):
                        self.announcementError = error.localizedDescription
                        self.send(intent: .announcementsError(error.localizedDescription))
                }
            }
        }
    }
}
