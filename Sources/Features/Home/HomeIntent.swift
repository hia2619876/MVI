//
//  HomeIntent.swift
//  merchant
//
//  Created by adam on 2025/7/29.
//

import Foundation

enum HomeIntent {
    case logoutClicked
    case loadAnnouncements
    case announcementsLoaded([AnnoModel])
    case announcementsError(String)
}
