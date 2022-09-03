//
//  FaceTracking.swift
//  VTuberKit
//
//  Created by Tatsuya Tanaka on 2019/02/11.
//  Copyright © 2019 Tatsuya Tanaka. All rights reserved.
//

import ARKit

public protocol FaceTrackingDelegate: AnyObject {
    func faceTracking(_ faceTracking: FaceTracking, didUpdate trackingData: TrackingData)
    func didFinishFaceTracking(_ faceTracking: FaceTracking)
}

public final class FaceTracking: NSObject {
    let session = ARSession()

    public weak var delegate: FaceTrackingDelegate?

    public var isSupported: Bool {
        return ARFaceTrackingConfiguration.isSupported
    }

    public func start() {
        guard isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = false
        if #available(iOS 13.0, *) {
            configuration.maximumNumberOfTrackedFaces = 1
        }

        session.delegate = self
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

    public func stop() {
        session.pause()
    }
}

extension FaceTracking: ARSessionDelegate {
    public func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        guard let faceAnchor = anchors.lazy.compactMap({ $0 as? ARFaceAnchor }).first,
              let frame = session.currentFrame else { return }

        // TODO/FIXME:

        var trackingData = TrackingData()

        if let eyeBlinkRightCloseness = faceAnchor.blendShapes[.eyeBlinkRight]?.doubleValue {
            let e = 0.045
            let eyeBlinkRightClosenessX8 = eyeBlinkRightCloseness * 2
            trackingData.rightEye = eyeBlinkRightClosenessX8 < e ? 0 : eyeBlinkRightClosenessX8 > 1 - e ? 1 : eyeBlinkRightClosenessX8
        }

        if let eyeBlinkLeftCloseness = faceAnchor.blendShapes[.eyeBlinkLeft]?.doubleValue {
            let e = 0.045
            let eyeBlinkLeftClosenessX8 = eyeBlinkLeftCloseness * 2
            trackingData.leftEye = eyeBlinkLeftClosenessX8 < e ? 0 : eyeBlinkLeftClosenessX8 > 1 - e ? 1 : eyeBlinkLeftClosenessX8
        }

        if let mouthCloseness = faceAnchor.blendShapes[.mouthClose]?.doubleValue {
            let e = 0.045
            let mouthClosenessX8 = mouthCloseness * 4
            trackingData.mouth = mouthClosenessX8 < e ? 0 : mouthClosenessX8 > 1 - e ? 1 : mouthClosenessX8
        }

        let cameraQuaternion = simd_quaternion(frame.camera.transform) * .init(angle: .pi / 2, axis: .init(0, 0, 1))
        let faceQuaternion = simd_quaternion(faceAnchor.transform)
        trackingData.neckQuaternion = faceQuaternion * cameraQuaternion.inverse

        delegate?.faceTracking(self, didUpdate: trackingData)
    }

    public func sessionWasInterrupted(_ session: ARSession) {
        stop()
        delegate?.didFinishFaceTracking(self)
    }

    public func sessionInterruptionEnded(_ session: ARSession) {
        stop()
        delegate?.didFinishFaceTracking(self)
    }
}
