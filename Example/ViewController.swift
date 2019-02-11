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
        view.addSubview(avatarView)

        do {
            try avatarView.loadModel(withName: "AliciaSolid.vrm")
        } catch {
            print(error)
        }

        let camera = avatarView.scene!.rootNode.childNode(withName: "camera", recursively: true)
        camera?.camera?.fieldOfView = 18
        camera?.position.y = 0.8
        camera?.eulerAngles.x += 20 * Float.pi / 180
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        avatarView.startFaceTracking()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        avatarView.stopFaceTracking()
    }
}

