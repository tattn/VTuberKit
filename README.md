<h1 align="center">VTuberKit</h1>

<h5 align="center">Avatar support library</h5>

<div align="center">
  <a href="https://app.bitrise.io/app/efaa4b22f111455d">
    <img src="https://github.com/tattn/VRMKit/actions/workflows/ci.yml/badge.svg" />
  </a>
  <a href="./LICENSE">
    <img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat-square" alt="license:MIT" />
  </a>
</div>

<br />

<img src="https://github.com/tattn/VTuberKit/raw/main/.github/demo.gif" width="400px" alt="demo" />

## Features

- [x] Show VRM avatar
- [x] Facial morphing (blend shape)
- [x] Bone animation (skin / joint)
- [x] Face tracking

VTuber is a trending avatar style in Japan :wink:

For "VRM", please refer to [this page](https://dwango.github.io/en/vrm/).

# Requirements

- Swift 5.7+
- iOS 15.0+

# Installation

## Swift Package Manager

You can install this package with Swift Package Manager.

## Carthage & CocoaPods (Deprecated)

If you want to use these package managers, please use https://github.com/tattn/VTuberKit/releases/tag/0.1.4

# Dependencies

VTuberKit is depended on [tattn/VRMKit](https://github.com/tattn/VRMKit). Please also see it.

# Usage

## Show avatar

```swift
import VTuberKit

@IBOutlet weak var avatarView: AvatarView!


try avatarView.loadModel(withName: "model.vrm")
```


## Face tracking

```swift
avatarView.startFaceTracking()
avatarView.stopFaceTracking()
```

### More details
- Facial morphing and bone animation
  - [tattn/VRMKit](https://github.com/tattn/VRMKit)
- [Example](https://github.com/tattn/VTuberKit/blob/main/Example/ViewController.swift)


# ToDo
- [ ] Improve face tracking
- [ ] Face tracking for All iOS devices without TrueDepth API
- [ ] Add pose presets
- [ ] Add many utility functions

# Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## Support this project

Donating to help me continue working on this project.

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://paypal.me/tattn/)

# License

VTuberKit is released under the MIT license. See LICENSE for details.

# Author
Tatsuya Tanaka

<a href="https://twitter.com/tanakasan2525" target="_blank"><img alt="Twitter" src="https://img.shields.io/twitter/follow/tanakasan2525.svg?style=social&label=Follow"></a>
<a href="https://github.com/tattn" target="_blank"><img alt="GitHub" src="https://img.shields.io/github/followers/tattn.svg?style=social"></a>

