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

    let CategoryTree = 2

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
    
    //Score Properties
    @IBOutlet weak var scoreLabel: UILabel!
    var score = 0
    
    //Timer
    @IBOutlet weak var timerLabel: UILabel!
    var seconds = 60
    var timer = Timer()
    var waitTimer = Timer()
    var isTimerRunning = true;
    var delaySeconds = 3
    
    // Timer
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(GameViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func runWaitTimer() {
        waitTimer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(GameViewController.updateWaitTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            //Send alert to indicate "time's up!"
            createAlert(title: "Congratulations!", message: "Score: \(score)")
            runWaitTimer()
        } else {
            seconds -= 1 //This will decrement(count down)the seconds.
            timerLabel.text = "\(seconds)" //This will update the label.
        }
    }
    
    @objc func updateWaitTimer() {
        if delaySeconds < 1 {
            timer.invalidate()
            exit(0)
        } else {
            delaySeconds -= 1 //This will decrement(count down)the seconds.
        }
    }
    
    @objc func updateScore(){
        score += 10 //This will increment score by 10.
        scoreLabel.text = "Score: \(score)"
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated:  true, completion: nil)
    }
    
    override func viewDidLoad() {
        setupScene()
        setupNodes()
        setupSounds()
        
        //scoreLabel.text = " Score: \(score)"
        scoreLabel.backgroundColor = UIColor(white:1, alpha:0)
        scoreLabel.textColor = UIColor.white
        
        //timerLabel.text = "Time: \(count)"
        timerLabel.backgroundColor = UIColor(white:1, alpha: 0)
        timerLabel.textColor = UIColor.white
        //timerLabel.text = "Time: \(seconds)"
        
    }
    
   

    func setupScene(){
        sceneView = self.view as! SCNView
        sceneView.delegate = self
        
        //sceneView.allowsCameraControl = true
        scene = SCNScene(named: "art.scnassets/MainScene.scn")
        sceneView.scene = scene
        
        scene.physicsWorld.contactDelegate = self
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        
        tapRecognizer.addTarget(self, action:#selector(GameViewController.sceneViewTapped(recognizer:)))
        sceneView.addGestureRecognizer(tapRecognizer)
        
        //updateTimer()
        runTimer()
    }
    
    // setup Nodes
    func setupNodes() {
        ballNode = scene.rootNode.childNode(withName: "bowlingball", recursively: true)!
        ballNode.physicsBody?.contactTestBitMask = CategoryTree
        followStickNode = scene.rootNode.childNode(withName: "followStick", recursively: true)!
    }
    
    //Setting up the Sounds
    func setupSounds() {
        let destroySound = SCNAudioSource(fileNamed: "coin.wav")!
        let jumpSound = SCNAudioSource(fileNamed: "jump.wav")!
        
        //Loading the Sounds
        destroySound.load()
        jumpSound.load()
        
        //Setting the Volume of the Sounds
        destroySound.volume = 1.5 // 30% Volume
        jumpSound.volume = 1.5 // 40% Volume
        
        //Adding the Sounds to a Dictionary
        sounds["destroy"] = destroySound
        sounds["jump"] = jumpSound
        
        let backgroundMusic = SCNAudioSource(fileNamed: "mariobattlefield.mp3")!
        backgroundMusic.volume = 0.01 // 10% Volume
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
        
        //acceleration
        motion.getAccelerometerData { (x, y, z) in
            self.motionForce = SCNVector3(x: x * 0.05, y:0, z: (y + 0.8) * -0.05)}
        
        ballNode.physicsBody?.velocity += motionForce
        }
    
    
}

extension GameViewController : SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        var contactNode:SCNNode!
        
        if contact.nodeA.name == "bowlingball" {
            contactNode = contact.nodeB
        }else{
            contactNode = contact.nodeA
        }
        
        if contactNode.physicsBody?.categoryBitMask == CategoryTree{
            contactNode.isHidden = true
            
            // Score
            DispatchQueue.main.async{
            self.updateScore()
            }

  
            let destroySound = sounds["destroy"]!
            ballNode.runAction(SCNAction.playAudio(destroySound, waitForCompletion: false))

            let waitAction = SCNAction.wait(duration: 15)
            let unhideAction = SCNAction.run { (node) in node.isHidden = false
                
            }
            
            let actionSequence = SCNAction .sequence([waitAction, unhideAction])
            contactNode.runAction(actionSequence)
        }
        
    }
}
