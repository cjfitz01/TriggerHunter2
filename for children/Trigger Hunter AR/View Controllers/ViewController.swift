//
//  ViewController.swift
//  Trigger Hunter AR
//
//  Created by Cal Stephens on 10/5/17.
//  Copyright © 2017 Mobile & Ubiquitous Computing 2017. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet var sceneView: ARSKView!
    
    var triggerNode: SKNode?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

// MARK: - ARSCNViewDelegate

extension ViewController: ARSKViewDelegate {
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        guard anchor is ARPlaneAnchor,
            self.triggerNode == nil else
        {
            return nil
        }
        
        let dustMite = SKTexture(image: #imageLiteral(resourceName: "Dust Mite"))
        let triggerSize = CGSize(width: 150, height: 150)
        let triggerNode = SKSpriteNode.init(texture: dustMite, size: triggerSize)
        self.triggerNode = triggerNode
        
        return triggerNode
    }
    
}

