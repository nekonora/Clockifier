//
//  DevLogManager.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Foundation

enum LogMessage {
    case api
    case storage
}

enum LogLevel {
    case info, debug
}

class DevLogManager {
    
    // MARK: - Instance
    
    static let shared = DevLogManager()
    
    // MARK: - Properties
    
    var logLevel: LogLevel = .info
    
    // MARK: - Class methods
    
    func logMessage(type: LogMessage, message: String) {
        print(composeMessage(type: type, message: message))
    }
    
    func logNetworkResponse(_ result: URLSession.DataTaskPublisher.Output) {
        guard let httpResponse = result.response as? HTTPURLResponse else { return }
                
        let messageURL  = "\n| URL:  - \(result.response.url?.absoluteString ?? "")"
        let messageCode = "\n| Code: - \(httpResponse.statusCode)"
        let messageBody = "\n| Body: - \n\(NSString(data: result.data, encoding: 1) ?? "")"
        
        let message: String = {
            var _message = messageURL + messageCode
            if logLevel == .debug { _message += messageBody }
            return _message
        }()
        
        logMessage(type: .api, message: "Network response:\n\(message)\n")
    }
    
    private func composeMessage(type: LogMessage, message: String) -> String {
        let prefix: String = {
            switch type {
            case .api: return "\n[DEVLOG][API] - "
            }
        }()
        
        return prefix + message
    }
}
