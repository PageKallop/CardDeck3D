//
//  ViewController.swift
//  CardDeck3D
//
//  Created by Page Kallop on 1/7/21.
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
        //lights 3d scene
        sceneView.autoenablesDefaultLighting = true
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        //creates reference image
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "DeckCards", bundle: Bundle.main) {
           //identify image to track
            configuration.trackingImages = imageToTrack
            //identify number of crads 
            configuration.maximumNumberOfTrackedImages = 2
            
            print("Image Added")
        }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    //creates node to anchor to
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            
            let planNode = SCNNode(geometry: plane)
            
            planNode.eulerAngles.x = -.pi / 2 
            
            node.addChildNode(planNode)
            
            if imageAnchor.referenceImage.name == "ClubCard" {
            //add 3D model to scene
            if let pokeScene = SCNScene(named: "art.scnassets/pm0768_00_fi copy.scn") {
                
                if  let pokeNode = pokeScene.rootNode.childNodes.first {
                    
                    pokeNode.eulerAngles.x = .pi / 2
                    
                    planNode.addChildNode(pokeNode)
                }
            }
        }
            
            if imageAnchor.referenceImage.name == "Joker" {
            //add 3D model to scene
            if let pokeScene = SCNScene(named: "art.scnassets/Oddish copy.scn") {
                
                if  let pokeNode = pokeScene.rootNode.childNodes.first {
                    
                    pokeNode.eulerAngles.x = .pi / 2
                    
                    planNode.addChildNode(pokeNode)
                }
            }
        }
        
    }
        return node
    }
    

}
