//
//  NetworkManager.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any?]

protocol NetworkHandler: AnyObject {
    var manager: NetworkManager { get }
}

extension NetworkHandler {
    var manager: NetworkManager { .shared }
}

final class NetworkManager {
    
    // MARK: - Types
    enum Service {
        case clockify, harvest
        
        var baseURL: URL {
            switch self {
            case .clockify: return URL(staticString: Constants.API.clockifyBaseUrl)
            case .harvest: return URL(staticString: Constants.API.harvestBaseUrl)
            }
        }
    }
    
    struct NetworkResponse<T> {
        let value: T
        let response: URLResponse
    }
    
    enum Method: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case patch = "PATCH"
    }
    
    enum Encoding {
        case json, url
    }
    
    // MARK: - Properties
    private let decoder: JSONDecoder
    
    // MARK: - Instance
    static let shared = NetworkManager()
    
    private init() {
        self.decoder = JSONDecoder()
    }
    
    // MARK: - Methods
    func request(service: Service,
                 endpoint: String,
                 method: Method,
                 parameters: Parameters? = nil,
                 encoding: Encoding = .url,
                 signed: Bool = true) async throws {
        let request = buildRequest(
            endpoint: endpoint,
            service: service,
            method: method,
            parameters: parameters,
            encoding: encoding,
            signed: signed
        )
        
        DevLogManager.shared.logMessage(
            type: .api,
            message: "new request @ \(endpoint)"
        )
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.networking(error: .invalidResponse)
            }
            guard httpResponse.statusCode == 200 else {
                let message = String(decoding: data, as: UTF8.self)
                throw APIError.networking(error: .wrongStatusCode(statusCode: httpResponse.statusCode,
                                                                  message: message))
            }
        } catch {
            throw APIError.generic(message: error.localizedDescription)
        }
    }
    
    func request<T: Codable>(service: Service,
                             endpoint: String,
                             method: Method,
                             parameters: Parameters? = nil,
                             encoding: Encoding = .url,
                             signed: Bool = true) async throws -> T {
        let request = buildRequest(
            endpoint: endpoint,
            service: service,
            method: method,
            parameters: parameters,
            encoding: encoding,
            signed: signed
        )
        
        DevLogManager.shared.logMessage(
            type: .api,
            message: "new request @ \(endpoint)"
        )
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.networking(error: .invalidResponse)
            }
            guard httpResponse.statusCode == 200 else {
                let message = String(decoding: data, as: UTF8.self)
                throw APIError.networking(error: .wrongStatusCode(statusCode: httpResponse.statusCode,
                                                                  message: message))
            }
            
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.generic(message: error.localizedDescription)
        }
    }
}

// MARK: - Internals
private extension NetworkManager {
    
    func buildRequest(endpoint: String,
                      service: Service,
                      method: Method,
                      parameters: Parameters?,
                      encoding: Encoding,
                      signed: Bool) -> URLRequest {
        var endpointPath = service.baseURL.appendingPathComponent(endpoint)
        var body: String?
        
        if let parameters = parameters {
            switch encoding {
            case .json:
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                    body = String(data: jsonData, encoding: String.Encoding.ascii)
                } catch {
                    #warning("TODO: handle error")
                }
            case .url:
                parameters.forEach { key, value in
                    endpointPath.append(name: key, value: value)
                }
            }
        }
        
        var _request = URLRequest(url: endpointPath)
        if let body = body {
            _request.httpBody = body.data(using: .utf8, allowLossyConversion: false)
        }
        
        if signed {
            switch service {
            case .clockify:
                _request.setValue(AppSecureKeys.clockifyAppToken, forHTTPHeaderField: "X-Api-Key")
            case .harvest:
                #warning("TODO: handle harvest signing")
                _request.setValue(AppSecureKeys.harvestToken, forHTTPHeaderField: "")
            }
        }
        _request.setValue("application/json", forHTTPHeaderField: "Accept")
        _request.httpMethod = method.rawValue
        return _request
    }
}
