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

class ARViewController: UIViewController {
    
    var trigger: Trigger!
    
    @IBOutlet var sceneView: ARSKView!
    var triggerNode: SKNode?
    
    // MARK: Presentation
    
    static func present(over source: UIViewController, for trigger: Trigger) {
        let arController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AR") as! ARViewController
        arController.trigger = trigger
        source.present(arController, animated: true, completion: nil)
    }
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        triggerDidBecomeVisible()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: Managing overlay content view controller
    
    var overlayContentViewController: UIViewController? {
        didSet {
            oldValue?.view.removeFromSuperview()
            
            overlayContentViewController?.loadView()
            guard let newOverlayView = overlayContentViewController?.view else {
                return
            }
            
            newOverlayView.backgroundColor = .clear
            
            view.addSubview(newOverlayView)
            newOverlayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            newOverlayView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
            newOverlayView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
            newOverlayView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            
            overlayContentViewController?.viewDidLoad()
        }
    }
    
    // MARK: User Interaction and event responses
    
    func triggerDidBecomeVisible() {
        overlayContentViewController = TriggerNameViewController.create(for: trigger)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.overlayContentViewController = TriggerInfoViewController.create(for: self.trigger, didTapNextBlock: {
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    
    
}

// MARK: - ARSCNViewDelegate

extension ARViewController: ARSKViewDelegate {
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        guard anchor is ARPlaneAnchor,
            self.triggerNode == nil else
        {
            return nil
        }
        
        let triggerTexture = SKTexture(image: trigger.image)
        let triggerSize = CGSize(width: 150, height: 150)
        let triggerNode = SKSpriteNode(texture: triggerTexture, size: triggerSize)
        self.triggerNode = triggerNode
        
        return triggerNode
    }
    
}

