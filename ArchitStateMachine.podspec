Pod::Spec.new do |s|
  s.name             = 'ArchitStateMachine'
  s.version          = '0.1.0'
  s.summary          = 'State machine Swift framework inspired by GKStateMachine from Apple GameplayKit framework'

  s.homepage         = 'https://github.com/alexruperez/StateMachine'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors          = { 'Alex Rupérez' => 'contact@alexruperez.com' }
  s.source           = { :git => 'https://github.com/alexruperez/StateMachine.git', :tag => s.version.to_s }
  s.social_media_url = "https://twitter.com/alexruperez"

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'

  s.source_files     ="StateMachine/*.{h,swift}"
end
