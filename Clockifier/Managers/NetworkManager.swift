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
    private let baseURL = URL(string: "https://api.clockify.me/api/v1")!
    
    // MARK: - Instance
    static let shared = NetworkManager()
    
    private init() { }
    
    // MARK: - Methods
    func request(service: Service,
                 endpoint: String,
                 method: Method,
                 parameters: Parameters,
                 signed: Bool = true) async -> Result<Data, APIError> {
        let request = buildRequest(
            endpoint: endpoint,
            service: service,
            method: method,
            parameters: parameters,
            signed: signed
        )
        
        DevLogManager.shared.logMessage(
            type: .api,
            message: "new request @ \(endpoint)"
        )
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.networking(error: .invalidResponse))
            }
            guard httpResponse.statusCode == 200 else {
                return .failure(.networking(error: .wrongStatusCode(statusCode: httpResponse.statusCode, message: String(decoding: data, as: UTF8.self))))
            }
            
            return .success(data)
        } catch {
            return .failure(.generic(message: error.localizedDescription))
        }
    }
}

// MARK: - Internals
private extension NetworkManager {
    
    func buildRequest(endpoint: String,
                      service: Service,
                      method: Method,
                      parameters: Parameters,
                      encoding: Encoding,
                      signed: Bool) -> URLRequest {
        var endpointPath = service.baseURL.appendingPathComponent(endpoint)
        
        switch encoding {
        case .json:
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                let jsonString = String(data: jsonData, encoding: String.Encoding.ascii)!
            } catch {
                
            }
        case .url:
            parameters.forEach { key, value in
                endpointPath.append(name: key, value: value)
            }
        }
        
//        switch parameters {
//        case .url(let params):
//            params.forEach { key, value in
//                endpointPath.append(name: key, value: value)
//            }
//        default:
//            break
//        }
        
        var _request = URLRequest(url: endpointPath)
        
//        switch parameters {
//        case .json(let body):
//            _request.httpBody = body.data(using: .utf8, allowLossyConversion: false)
//        default:
//            break
//        }
        
        if signed {
            switch service {
            case .clockify:
                _request.setValue(AppSecureKeys.clockifyAppToken, forHTTPHeaderField: "X-Api-Key")
            case .harvest:
                _request.setValue(AppSecureKeys.harvestToken, forHTTPHeaderField: "")
            }
        }
        _request.setValue("application/json", forHTTPHeaderField: "Accept")
        _request.httpMethod = method.rawValue
        return _request
    }
}
