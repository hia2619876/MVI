//
//  AnnoModel.swift
//  merchant
//
//  Created by adam on 2025/7/30.
//

import Foundation

struct AnnoModel: Equatable, Codable, Identifiable {
    var id: Int
    var userId: Int
    var title: String
    var body: String
}

typealias AnnoResponse = [AnnoModel]
