//
//  GameViewController.swift
//  CrazyBowling
//
//  Created by Munoz Aldren J. on 4/18/19.
//  Copyright © 2019 BAK Games. All rights reserved.
//

import UIKit
import SceneKit

class GameViewController: UIViewController {


    var sceneView:SCNView!
    var scene:SCNScene!
    

    override func viewDidLoad() {
      setupScene()
    }
    
    func setupScene(){
        sceneView = self.view as! SCNView
        sceneView.allowsCameraControl = true
        scene = SCNScene(named: "art.scnassets/MainScene.scn")
        sceneView.scene = scene
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
