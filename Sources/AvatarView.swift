//
//  AvatarView.swift
//  VTuberKit
//
//  Created by Tatsuya Tanaka on 2019/02/11.
//  Copyright © 2019 Tatsuya Tanaka. All rights reserved.
//

import SceneKit
import VRMSceneKit

open class AvatarView: SCNView {
    open var enviromentLightNode = SCNNode()
    open var avatarPointLightNode = SCNNode()
    public var avatar: VRMNode!

    let faceTracking = FaceTracking()

    public override init(frame: CGRect, options: [String : Any]? = nil) {
        super.init(frame: frame, options: options)
        commonInit()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        faceTracking.delegate = self
    }

    public func loadModel(withName name: String) throws {
        let loader = try VRMSceneLoader(named: name)
        avatar = try loader.loadScene().vrmNode
        setUp(node: avatar)

        avatar.humanoid.node(for: .leftShoulder)?.eulerAngles = SCNVector3(0, 0, 40 * CGFloat.pi / 180)
        avatar.humanoid.node(for: .rightShoulder)?.eulerAngles = SCNVector3(0, 0, -40 * CGFloat.pi / 180)
    }

    private func setUp(node: VRMNode) {
        let scene = SCNScene()
        scene.rootNode.childNodes.forEach { $0.removeFromParentNode() }
        scene.rootNode.addChildNode(node)
        self.scene = scene

        let cameraNode = SCNNode()
        cameraNode.name = "camera"
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)

        cameraNode.position = SCNVector3(0, 0.8, -1.6)
        cameraNode.rotation = SCNVector4(0, 1, 0, Float.pi)
    }

    public func startFaceTracking() {
        faceTracking.start()
    }

    public func stopFaceTracking() {
        faceTracking.stop()
    }
}

extension AvatarView: FaceTrackingDelegate {
    public func faceTracking(_ faceTracking: FaceTracking, didUpdate trackingData: TrackingData) {
        DispatchQueue.main.async {
            self.avatar.setBlendShape(value: CGFloat(trackingData.leftEye), for: .preset(.blinkL))
            self.avatar.setBlendShape(value: CGFloat(trackingData.rightEye), for: .preset(.blinkR))
            self.avatar.setBlendShape(value: CGFloat(trackingData.mouthCloseness), for: .preset(.a))

            let humanoid = self.avatar.humanoid
            humanoid.node(for: .neck)?.simdOrientation = trackingData.neckQuaternion.inverse
        }
    }

    public func didFinishFaceTracking(_ faceTracking: FaceTracking) {
        faceTracking.start() // TODO/FIXME:
    }


}
