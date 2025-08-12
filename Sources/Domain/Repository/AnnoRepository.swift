//
//  AnnoRepository.swift
//  merchant
//
//  Created by adam on 2025/7/30.
//

import Foundation

protocol AnnoRepository {
    func getAnno() async throws -> [AnnoModel]
}
