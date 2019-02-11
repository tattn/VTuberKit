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

    override func viewDidLoad() {
        super.viewDidLoad()

        let avatarView = AvatarView(frame: view.bounds)
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
    }
}

