//
//  AutomationViewModel.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 11/11/21.
//  Copyright © 2021 Filippo Zaffoni. All rights reserved.
//

import Foundation

struct Node: Identifiable, Hashable {
    let id = UUID()
    let size = CGSize(width: 200, height: 100)
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct ConnectionPath: Identifiable, Hashable {
    var id = UUID()
    
    var start: CGPoint
    var end: CGPoint
    let startNodeId: UUID
    let endNodeId: UUID
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct NodeLocation: Hashable {
    let id: UUID
    let location: CGPoint
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

final class AutomationViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var nodes = [Node]()
    @Published var nodesLocations = Set<NodeLocation>()
    @Published var connectionPaths = [ConnectionPath]()
    
    // MARK: - Init
    
    // MARK: - Methods
    func createNewNode(at position: CGPoint) {
        let node = Node()
        nodes.append(node)
        nodesLocations.insert(NodeLocation(id: node.id, location: position))
        
        if nodes.count > 1 {
            let startNodeId = nodes[nodes.count - 2].id
            let endNodeId = nodes[nodes.count - 1].id
            let start = nodesLocations.first { $0.id == startNodeId }?.location
            let end = nodesLocations.first { $0.id == endNodeId }?.location
            
            if let start = start, let end = end {
                connectionPaths.append(ConnectionPath(start: start,
                                                      end: end,
                                                      startNodeId: startNodeId,
                                                      endNodeId: endNodeId))
            }
        }
    }
    
    func setNewLocation(_ location: CGPoint, for nodeId: UUID) {
        guard let oldLocation = nodesLocations.first(where: { $0.id == nodeId }) else { return }
        nodesLocations.remove(oldLocation)
        nodesLocations.insert(NodeLocation(id: nodeId, location: location))
        
        let connectionOnStartIndex = connectionPaths.firstIndex { $0.startNodeId == nodeId }
        let connectionOnEndIndex = connectionPaths.firstIndex { $0.endNodeId == nodeId }
        let connectionOnStart = connectionPaths.first { $0.startNodeId == nodeId }
        let connectionOnEnd = connectionPaths.first { $0.endNodeId == nodeId }
        
        if let connection = connectionOnStart, let index = connectionOnStartIndex {
            var updatedConnection = connection
            updatedConnection.start = location
            connectionPaths.remove(at: index)
            connectionPaths.insert(updatedConnection, at: index)
        }
        
        if let connection = connectionOnEnd, let index = connectionOnEndIndex {
            var updatedConnection = connection
            updatedConnection.end = location
            connectionPaths.remove(at: index)
            connectionPaths.insert(updatedConnection, at: index)
        }
    }
    
    func sizeOf(_ nodeId: UUID) -> CGSize {
        nodes.first { $0.id == nodeId }?.size ?? .zero
    }
    
    func positionOf(_ nodeId: UUID) -> CGPoint {
        nodesLocations.first { $0.id == nodeId }?.location ?? .zero
    }
}
