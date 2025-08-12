//
//  GetAnnoRepositoryImpl.swift
//  merchant
//
//  Created by adam on 2025/7/30.
//

import Foundation
import Alamofire

class GetAnnoRepositoryImpl: AnnoRepository {
    
    // MARK: - Properties
    private let baseURL = "https://jsonplaceholder.typicode.com/posts"
    private let session: Session
    
    // MARK: - Init
    init(session: Session = AF) {
        self.session = session
    }
    
    // MARK: - Async/Await 版本
    func getAnno() async throws -> [AnnoModel] {
        let url = baseURL
        
        return try await withCheckedThrowingContinuation { continuation in
            session.request(url, method: .get)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: AnnoResponse.self) { response in
                    switch response.result {
                    case .success(let annoResponse):
                        continuation.resume(returning: annoResponse)
                    case .failure(let error):
                        continuation.resume(throwing: self.handleError(error))
                    }
                }
        }
    }
    
    private func handleError(_ error: AFError) -> AnnoAPIError {
        switch error {
        case .responseValidationFailed(let reason):
            switch reason {
            case .unacceptableStatusCode(let code):
                return AnnoAPIError.httpError(code)
            default:
                return AnnoAPIError.networkError(error.localizedDescription)
            }
        case .responseSerializationFailed:
            return AnnoAPIError.decodingError
        default:
            return AnnoAPIError.networkError(error.localizedDescription)
        }
    }
}

enum AnnoAPIError: LocalizedError {
    case networkError(String)
    case httpError(Int)
    case decodingError
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .networkError(let message):
            return "網路錯誤: \(message)"
        case .httpError(let code):
            return "HTTP 錯誤: \(code)"
        case .decodingError:
            return "資料解析錯誤"
        case .unknownError:
            return "未知錯誤"
        }
    }
}
