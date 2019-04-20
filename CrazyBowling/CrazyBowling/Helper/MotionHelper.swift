//
//  MotionHelper.swift
//  CrazyBowling
//
//  Created by Munoz Aldren J. on 4/20/19.
//  Copyright © 2019 BAK Games. All rights reserved.
//

import Foundation
import CoreMotion

class MotionHelper{
    
    let motionManager = CMMotionManager()
    
    init() {
    }
    
    func getAccelerometerData(interval: TimeInterval = 0.1, motionDataResults: ((  _ x: Float,
        _ y: Float,   _ z: Float) -> ())? ){
        
        if motionManager.isAccelerometerAvailable {
            
            motionManager.accelerometerUpdateInterval = interval
            
            motionManager.startAccelerometerUpdates(to: OperationQueue()) { (data, error) in
                if motionDataResults != nil {
                    motionDataResults!(Float(data!.acceleration.x), Float(data!.acceleration.y),
                                       Float(data!.acceleration.z))
                }
            }
            
        }
    }
    
}
