//
//  AvatarView.swift
//  VTuberKit
//
//  Created by Tatsuya Tanaka on 2019/02/11.
//  Copyright © 2019 Tatsuya Tanaka. All rights reserved.
//

import SceneKit
import VRMKit
import VRMSceneKit

open class AvatarView: SCNView {
    open var cameraNode = SCNNode()
    public lazy var avatar: VRMNode = { fatalError() }()

    open var isBlinkTrackingEnabled = true
    open var isMouthTrackingEnabled = true

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
    }

    public func loadModel(withURL url: URL) throws {
        let loader = try VRMSceneLoader(withURL: url)
        avatar = try loader.loadScene().vrmNode
        setUp(node: avatar)
    }

    public func loadModel(withData data: Data) throws {
        let loader = try VRMSceneLoader(withData: data)
        avatar = try loader.loadScene().vrmNode
        setUp(node: avatar)
    }

    public func loadModel(withVRM vrm: VRM) throws {
        let loader = VRMSceneLoader(vrm: vrm)
        avatar = try loader.loadScene().vrmNode
        setUp(node: avatar)
    }

    private func setUp(node: VRMNode) {
        let scene = SCNScene()
        scene.rootNode.childNodes.forEach { $0.removeFromParentNode() }
        scene.rootNode.addChildNode(node)
        self.scene = scene

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
            if self.isBlinkTrackingEnabled {
                self.avatar.setBlendShape(value: CGFloat(trackingData.leftEye), for: .preset(.blinkL))
                self.avatar.setBlendShape(value: CGFloat(trackingData.rightEye), for: .preset(.blinkR))
            } else {
                self.avatar.setBlendShape(value: 0, for: .preset(.blinkL))
                self.avatar.setBlendShape(value: 0, for: .preset(.blinkR))
            }
            if self.isMouthTrackingEnabled {
                self.avatar.setBlendShape(value: CGFloat(trackingData.mouth), for: .preset(.a))
            } else {
                self.avatar.setBlendShape(value: 0, for: .preset(.a))
            }

            let humanoid = self.avatar.humanoid
            humanoid.node(for: .neck)?.simdOrientation = trackingData.neckQuaternion.inverse
        }
    }

    public func didFinishFaceTracking(_ faceTracking: FaceTracking) {
        // TODO/FIXME:
    }
}
