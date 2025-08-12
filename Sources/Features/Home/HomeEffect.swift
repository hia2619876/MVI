//
//  HomeEffect.swift
//  merchant
//
//  Created by adam on 2025/8/12.
//

import Foundation

final class HomeEffect {
    
    private static let annoUseCase: AnnoUseCase = AnnoUseCase(repository: GetAnnoRepositoryImpl())
    
    static func getAnno(completion: @escaping (Result<[AnnoModel], Error>) -> Void){
        Task {
            do {
                let announcements = try await annoUseCase.repository.getAnno()
                await MainActor.run {
                    completion(.success(announcements))
                    
                }
            } catch {
                await MainActor.run {
                    completion(.failure(error))
                }
            }
        }
    }
}
