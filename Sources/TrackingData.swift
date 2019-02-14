//
//  TrackingData.swift
//  VTuberKit
//
//  Created by Tatsuya Tanaka on 2019/02/11.
//  Copyright © 2019 Tatsuya Tanaka. All rights reserved.
//

import Foundation
import simd

public struct TrackingData {
    public var leftEye: Double
    public var rightEye: Double
    public var mouth: Double
    public var neckQuaternion: simd_quatf
    public var modelPosition: simd_float3
}

extension TrackingData {
    init() {
        self.init(leftEye: 0, rightEye: 0, mouth: 0, neckQuaternion: simd_quatf(), modelPosition: simd_float3())
    }
}
