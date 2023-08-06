//
//  NetworkManager.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import Moya
import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private var provider = MoyaProvider<NetworkEndPointCases>(plugins: [NetworkLoggerPlugin()])
    
    func request<T: Decodable>(target: NetworkEndPointCases, completion: @escaping (Result<T, Error>) -> Void) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let responseResult = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(responseResult))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
