Pod::Spec.new do |s|
  s.name             = 'VTuberKit'
  s.version          = '0.1.3'
  s.summary          = 'Avatar support library like a AvatarKit'

  s.description      = <<-DESC
Avatar support library like a AvatarKit

Show 3D models and track face
                       DESC

  s.homepage         = 'https://github.com/tattn/VTuberKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'git' => 'tanakasan2525@gmail.com' }
  s.source           = { :git => 'https://github.com/tattn/VTuberKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/tanakasan2525'

  s.ios.deployment_target = '11.0'

  s.source_files = 'Sources/**/*.{swift,h}'
  
  s.public_header_files = 'Sources/**/*.h'
  s.frameworks = 'Foundation'
  s.frameworks = 'SceneKit'

  s.dependency 'VRMKit', "~> 0.2.4"
  s.dependency 'VRMSceneKit', "~> 0.2.4"
end
