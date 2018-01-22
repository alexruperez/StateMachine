Pod::Spec.new do |s|
  s.name             = 'ArchitStateMachine'
  s.version          = '0.1.1'
  s.summary          = 'State machine creation framework written in Swift inspired by GKStateMachine from Apple GameplayKit'

  s.homepage         = 'https://github.com/alexruperez/StateMachine'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors          = { 'Alex Rupérez' => 'contact@alexruperez.com' }
  s.source           = { :git => 'https://github.com/alexruperez/StateMachine.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/alexruperez'
  s.module_name      = 'StateMachine'

  s.ios.deployment_target     = '8.0'
  s.tvos.deployment_target    = '9.0'
  s.osx.deployment_target     = '10.9'
  s.watchos.deployment_target = '2.0'

  s.source_files      = 'Core/*.{h,swift}'
  s.ios.source_files  = 'UIKit/*.{h,swift}'
  s.tvos.source_files = 'UIKit/*.{h,swift}'

  s.framework      = 'Foundation'
  s.ios.framework  = 'UIKit'
  s.tvos.framework = 'UIKit'
end
