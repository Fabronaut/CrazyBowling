//
//  VectorOperations.swift
//  CrazyBowling
//
//  Created by Munoz Aldren J. on 4/20/19.
//  Copyright © 2019 BAK Games. All rights reserved.
//

import Foundation
import SceneKit

// This is for Adding two Vectors

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3(x:left.x + right.x, y: left.y + right.y, z: left.z + right.z)
}

func +=(left: inout SCNVector3, right: SCNVector3){
    left = left + right
}
