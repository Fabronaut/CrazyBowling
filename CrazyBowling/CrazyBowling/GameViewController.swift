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

    override func viewDidLoad() {
      setupScene()
    }
    
    func setupScene(){
        
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
