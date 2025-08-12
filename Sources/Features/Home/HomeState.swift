//
//  HomeState.swift
//  merchant
//
//  Created by adam on 2025/7/29.
//

import Foundation

enum HomeState: Equatable {
    case idle
    case loading
    case success([AnnoModel])
    case error(String)
}
