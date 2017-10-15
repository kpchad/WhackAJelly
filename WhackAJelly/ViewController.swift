//
//  ViewController.swift
//  WhackAJelly
//
//  Created by Kyle Chadwick on 10/12/17.
//  Copyright © 2017 Kyle Chadwick. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController {
    
    @IBOutlet weak var SceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.SceneView.session.run(configuration)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.SceneView.addGestureRecognizer(tapGestureRecognizer)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func play(_ sender: Any) {
        self.addNode()
    }
    
    @IBAction func reset(_ sender: Any) {
    }
    
    func addNode() {
        let jellyFishScene = SCNScene(named: "art.scnassets/Jellyfish.scn")
        let jellyfishNode = jellyFishScene?.rootNode.childNode(withName: "Jelly", recursively: false)
        jellyfishNode?.position = SCNVector3(0,0,-1)
        
        self.SceneView.scene.rootNode.addChildNode(jellyfishNode!)
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let sceneViewTappedOn = sender.view as! SCNView
        let touchCoordinates = sender.location(in: sceneViewTappedOn)
        let hitTest = sceneViewTappedOn.hitTest(touchCoordinates)
        if hitTest.isEmpty {
            print("didn't touch anything")
        } else {
            let results = hitTest.first!
            let geometry = results.node.geometry
            print(geometry!)
        }
    }
}
