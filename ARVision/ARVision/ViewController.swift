//
//  ViewController.swift
//  ARVision
//
//  Created by Likhon Gomes on 9/8/18.
//  Copyright © 2018 PennAppsXVIII. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ElBeeper = beeper()
        ElBeeper.playSound()
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        //DEBUGGER NODE THING!!!!!
        sceneView.debugOptions =
            SCNDebugOptions(rawValue: ARSCNDebugOptions.showWorldOrigin.rawValue |
                ARSCNDebugOptions.showFeaturePoints.rawValue);
        // Create a new scene
        //let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        //sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    // The pixel buffer being held for analysis; used to serialize Vision requests.
    private var currentBuffer: CVPixelBuffer?

    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // Present an error message to the user
        // Do not enqueue other buffers for processing while another Vision task is still running.
        // The camera stream has only a finite amount of buffers available; holding too many buffers for analysis would starve the camera.
        guard currentBuffer == nil, case .normal = frame.camera.trackingState else {
            return
        }
        
       
        
        // Retain the image buffer for Vision processing.
        self.currentBuffer = frame.capturedImage
        //This is where we would need to get the image to openCV!!
        let image = CIImage(cvPixelBuffer: self.currentBuffer!)
        let actual = UIImage(ciImage: image)
        let OCV = OpenCVWrapper.makeCVfromImage(actual)
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
