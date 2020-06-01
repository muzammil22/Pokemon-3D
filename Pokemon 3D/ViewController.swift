//
//  ViewController.swift
//  Pokemon 3D
//
//  Created by Muzammil Muneer on 27/05/2020.
//  Copyright © 2020 Muzammil Muneer. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "Cards", bundle: Bundle.main){
            configuration.trackingImages = trackedImages
            
            configuration.maximumNumberOfTrackedImages = 2
            
            print("Images Found")
        }

        // Run the view's session
        sceneView.session.run(configuration)

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        DispatchQueue.main.async {
            if let imageAnchor = anchor as? ARImageAnchor {
                

                let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width - 0.005, height: imageAnchor.referenceImage.physicalSize.height)
                
                plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
                
                let planeNode = SCNNode(geometry: plane)
                
                planeNode.eulerAngles.x = -.pi/2
                
                node.addChildNode(planeNode)
                
//                if let kingScene = SCNScene(named: "art.scnassets/king.scn") {
//                    if let kingNode = kingScene.rootNode.childNodes.first {
//                        planeNode.addChildNode(kingNode)
//                    }
//                }
                if imageAnchor.referenceImage.name == "king" {
                    if let kingScene = SCNScene(named: "art.scnassets/king.scn") {
                        
                        if let kingNode = kingScene.rootNode.childNodes.first {
                            
                            //                        pokeNode.eulerAngles.x = .pi / 2
                            
                            planeNode.addChildNode(kingNode)
                        }
                    }
                }
                if imageAnchor.referenceImage.name == "one" {
                    if let oneScene = SCNScene(named: "art.scnassets/eevee.scn") {
                        
                        if let oneNode = oneScene.rootNode.childNodes.first {
                            
                            oneNode.eulerAngles.x = .pi / 2
                            
                            planeNode.addChildNode(oneNode)
                        }
                    }
                }
                
                
            }
            
        }
        return node
        
    }
    
}
