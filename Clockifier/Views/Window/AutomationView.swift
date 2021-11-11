//
//  AutomationView.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 11/11/21.
//  Copyright © 2021 Filippo Zaffoni. All rights reserved.
//

import SwiftUI

struct ConnectionShape: Shape {
    @Binding var connectionPath: ConnectionPath
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: connectionPath.start)
        path.addLine(to: CGPoint(x: connectionPath.start.x + 120, y: connectionPath.start.y))
        path.addLine(to: CGPoint(x: connectionPath.end.x - 120, y: connectionPath.end.y))
        path.addLine(to: connectionPath.end)
        
        return path
    }
}

struct AutomationView: View {
    
    // MARK: - Properties
    @ObservedObject var model: AutomationViewModel
    @State var shouldShowDeleteDrawer = false
    
    var body: some View {
        ZStack {
            Color.cyan
            
            VStack {
                if shouldShowDeleteDrawer {
                    Color.red
                        .frame(height: 50)
                        .transition(.move(edge: .leading))
                }
                
                Spacer()
            }
            
            ForEach($model.connectionPaths) { connection in
                ConnectionShape(connectionPath: connection)
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            }
            
            ForEach($model.nodes) { node in
                NodeView(nodeId: node.id, model: model, shouldShowDeleteDrawer: $shouldShowDeleteDrawer)
            }
        }
        .onTapGesture { position in
            model.createNewNode(at: position)
        }
    }
}

struct NodeView: View {
    
    let nodeId: UUID
    
    @ObservedObject var model: AutomationViewModel
    
    @Binding var shouldShowDeleteDrawer: Bool
    
    @GestureState private var fingerLocation: CGPoint?
    @GestureState private var startLocation: CGPoint?
    
    @State private var isDragging = false
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                isDragging = true
                
                withAnimation {
                    shouldShowDeleteDrawer = true
                }
                
                var newLocation = startLocation ?? model.positionOf(nodeId)
                
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                model.setNewLocation(newLocation, for: nodeId)
            }
            .updating($startLocation) { value, startLocation, transaction in
                startLocation = startLocation ?? model.positionOf(nodeId)
            }
            .onEnded { _ in
                shouldShowDeleteDrawer = false
                isDragging = false
            }
    }
    
    var fingerDrag: some Gesture {
        DragGesture()
            .updating($fingerLocation) { value, fingerLocation, transaction in
                fingerLocation = value.location
            }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.blue)
        }
        .frame(width: model.sizeOf(nodeId).width, height: model.sizeOf(nodeId).height)
        .position(model.positionOf(nodeId))
        .gesture(
            simpleDrag.simultaneously(with: fingerDrag)
        )
    }
}
