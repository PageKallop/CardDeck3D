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
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        //creates reference image
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "ClubCard", bundle: Bundle.main) {
           //identify image to track
            configuration.trackingImages = imageToTrack
            //identify number of crads 
            configuration.maximumNumberOfTrackedImages = 1
            
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
    

}
