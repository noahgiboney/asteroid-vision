//
//  SceneView.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 3/22/24.
//

import SceneKit
import SwiftUI

struct SceneView: UIViewRepresentable {
    var model: SceneModel
    var rotationX: Float
    var rotationY: Float
    var rotationZ: Float
    var allowsCameraControl: Bool
    
    typealias UIViewType = SCNView
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func makeUIView(context: Context) -> UIViewType {
	let view = SCNView()
	view.backgroundColor = UIColor.clear
	view.allowsCameraControl = allowsCameraControl
	view.autoenablesDefaultLighting = true
	
        if let scene = SCNScene(named: model.resource) {
	    view.scene = scene
	    
	    let asteroidNode = scene.rootNode.childNodes.first { $0.name == "asteroidNodeName" } ?? scene.rootNode
	    
	    let rotation = CABasicAnimation(keyPath: "rotation")
	    rotation.toValue = NSValue(scnVector4: SCNVector4(x: rotationX, y: rotationY, z: rotationZ, w: Float.pi * 2))
	    rotation.duration = 10
	    rotation.repeatCount = Float.infinity
	    
	    asteroidNode.addAnimation(rotation, forKey: "rotation")
	}
	
	return view
    }
}

#Preview {
    SceneView(model: .earth, rotationX: 0, rotationY: 0, rotationZ: 0, allowsCameraControl: true)
	.preferredColorScheme(.dark)
}

