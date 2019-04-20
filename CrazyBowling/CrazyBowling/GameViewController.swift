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
    
    //Creating the Properties
    var ballNode:SCNNode!
    var followStickNode:SCNNode!
    
    //Motion Control Properties
    var motion = MotionHelper()
    var motionForce = SCNVector3(0, 0, 0)
    
    //Sounds Properties
    var sounds:[String:SCNAudioSource] = [:]

    override func viewDidLoad() {
        setupScene()
        setupNodes()
        setupSounds()
    }
    
    func setupScene(){
        sceneView = self.view as! SCNView
        sceneView.delegate = self
        
        //sceneView.allowsCameraControl = true
        scene = SCNScene(named: "art.scnassets/MainScene.scn")
        sceneView.scene = scene
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        
        tapRecognizer.addTarget(self, action:#selector(GameViewController.sceneViewTapped(recognizer:)))
        sceneView.addGestureRecognizer(tapRecognizer)
    }
    
    // setup Nodes
    func setupNodes() {
        ballNode = scene.rootNode.childNode(withName: "bowlingball", recursively: true)!
        followStickNode = scene.rootNode.childNode(withName: "followStick", recursively: true)!
    }
    
    //Setting up the Sounds
    func setupSounds() {
        let collectionSound = SCNAudioSource(fileNamed: "coin.wav")!
        let jumpSound = SCNAudioSource(fileNamed: "jump.wav")!
        
        //Loading the Sounds
        collectionSound.load()
        jumpSound.load()
        
        //Setting the Volume of the Sounds
        collectionSound.volume = 0.3 // 30% Volume
        jumpSound.volume = 1.0 // 40% Volume
        
        //Adding the Sounds to a Dictionary
        sounds["collection"] = collectionSound
        sounds["jump"] = jumpSound
        
        let backgroundMusic = SCNAudioSource(fileNamed: "mariobattlefield.mp3")!
        backgroundMusic.volume = 0.1 // 10% Volume
        backgroundMusic.loops = true; // Loop the Background when it finishes
        backgroundMusic.load() // Load the background music
        
        // Play the Music
        let musicPlayer = SCNAudioPlayer(source: backgroundMusic)
        ballNode.addAudioPlayer(musicPlayer)
        
    }
    
    // Jump Function
    @objc func sceneViewTapped (recognizer:UITapGestureRecognizer){
        let location = recognizer.location(in: sceneView)
        
        let hitResults = sceneView.hitTest(location, options: nil)
        
        if hitResults.count > 0 {
            let result = hitResults.first
            if let node = result?.node {
                if node.name == "bowlingball" {
                    let jumpSound = sounds["jump"]!
                    
                    //Apply the sound Effect and Physics
                    ballNode.runAction(SCNAction.playAudio(jumpSound, waitForCompletion: false))
                    ballNode.physicsBody?.applyForce(SCNVector3(x: 0, y:3, z: -1), asImpulse: true)
                }
            }
        }
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

extension GameViewController : SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval){
        let ball = ballNode.presentation
        let ballPosition = ball.position
        
        let targetPosition = SCNVector3(x: ballPosition.x, y: ballPosition.y + 5, z: ballPosition.z + 5)
        var cameraPosition = followStickNode.position
        
        let camDamping:Float = 0.3
        let xComponent = cameraPosition.x * (1 - camDamping) + targetPosition.x * camDamping
        let yComponent = cameraPosition.y * (1 - camDamping) + targetPosition.y * camDamping
        let zComponent = cameraPosition.z * (1 - camDamping) + targetPosition.z * camDamping
        
        cameraPosition = SCNVector3(x: xComponent, y: yComponent, z: zComponent)
        followStickNode.position = cameraPosition
    }
}
