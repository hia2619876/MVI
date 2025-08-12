//
//  AnnoUseCase.swift
//  merchant
//
//  Created by adam on 2025/7/30.
//

import Foundation

struct AnnoUseCase {
    let repository: AnnoRepository

    func execute(username: String) async throws -> [AnnoModel] {
        try await repository.getAnno()
    }
}
