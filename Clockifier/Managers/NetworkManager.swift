//
//  NetworkManager.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Combine
import Foundation

protocol NetworkHandler: class {
    
    var manager: NetworkManager { get set }
}

class NetworkManager: ObservableObject {
    
    // MARK: - Types
    
    struct NetworkResponse<T> {
        let value: T
        let response: URLResponse
    }

    typealias NetworkPublisher<T> = AnyPublisher<NetworkResponse<T>, Error>
    
    enum Method: String {
        case get   = "GET"
        case put   = "PUT"
        case post  = "POST"
        case patch = "PATCH"
    }
    
    // MARK: - Properties
    
    private let baseURL = URL(string: "https://api.clockify.me/api/v1")!
    
    @Published var loading = false
    
    var lastUpdateOfTimeEntries: Date?
    
    // MARK: - Instance
    
    static let shared = NetworkManager()
    
    // MARK: - Class methods
    
    func request<T: Decodable>(_ endpoint: String, method: Method, body: String? = nil) -> NetworkPublisher<T> {
        loading = true
        
        let request: URLRequest = {
            let endpointPath = baseURL.appendingPathComponent(endpoint)
            var _request = URLRequest(url: endpointPath)
            _request.setValue(KeychainManager.shared.apiKey, forHTTPHeaderField: "X-Api-Key")
            _request.setValue("application/json", forHTTPHeaderField: "Accept")
            _request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            _request.httpBody   = body?.data(using: .utf8, allowLossyConversion: false)
            _request.httpMethod = method.rawValue
            return _request
        }()
        
        let decoder = JSONDecoder()
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result in
                self.loading = false
                DevLogManager.shared.logNetworkResponse(result)
                return NetworkResponse(value: try decoder.decode(T.self, from: result.data),
                                       response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension URL {
    
    init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else { preconditionFailure("Invalid static URL string: \(string)") }
        self = url
    }
}
