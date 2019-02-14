//
//  ViewController.swift
//  Example
//
//  Created by Tatsuya Tanaka on 2019/02/11.
//  Copyright © 2019 Tatsuya Tanaka. All rights reserved.
//

import UIKit
import SceneKit
import VTuberKit

class ViewController: UIViewController {
    @IBOutlet private weak var avatarView: AvatarView!

    override func viewDidLoad() {
        super.viewDidLoad()

        avatarView.autoenablesDefaultLighting = true
        avatarView.allowsCameraControl = true
        avatarView.showsStatistics = true
        avatarView.backgroundColor = UIColor.black

        do {
            try avatarView.loadModel(withName: "AliciaSolid.vrm")
        } catch {
            print(error)
        }

        setUpScene()
    }

    private func setUpScene() {
        let avatar = avatarView.avatar
        avatar.humanoid.node(for: .leftShoulder)?.eulerAngles = SCNVector3(0, 0, 20.0 * .pi / 180)
        avatar.humanoid.node(for: .rightShoulder)?.eulerAngles = SCNVector3(0, 0, -20.0 * .pi / 180)

        let camera = avatarView.cameraNode
        camera.camera?.fieldOfView = 18
        camera.position.y = 0.8
        camera.eulerAngles.x += 20 * Float.pi / 180
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        avatarView.startFaceTracking()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        avatarView.stopFaceTracking()
    }

    @IBAction private func didFaceChanged(_ sender: UISegmentedControl) {
        let avatar = avatarView.avatar
        avatar.setBlendShape(value: 0, for: .preset(.joy))
        avatar.setBlendShape(value: 0, for: .preset(.fun))
        avatar.setBlendShape(value: 0, for: .preset(.sorrow))
        avatar.setBlendShape(value: 0, for: .preset(.angry))
        avatar.setBlendShape(value: 0, for: .custom("><"))

        let index = sender.selectedSegmentIndex
        avatarView.isBlinkTrackingEnabled = index == 0
        avatarView.isMouthTrackingEnabled = index != 1 && index != 4

        switch index {
        case 1:
            avatar.setBlendShape(value: 1.0, for: .preset(.joy))
        case 2:
            avatar.setBlendShape(value: 1.0, for: .preset(.fun))
        case 3:
            avatar.setBlendShape(value: 1.0, for: .preset(.sorrow))
        case 4:
            avatar.setBlendShape(value: 1.0, for: .preset(.angry))
        case 5:
            avatar.setBlendShape(value: 1.0, for: .custom("><"))
        default: ()
        }
    }
}

