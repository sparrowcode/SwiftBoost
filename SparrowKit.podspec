Pod::Spec.new do |s|

  s.name = 'SparrowKit'
  s.version = '3.2.4'
  s.summary = 'Collection of native Swift extensions to boost your development. Support tvOS and watchOS.'
  s.homepage = 'https://github.com/ivanvorobei/SparrowKit'
  s.source = { :git => 'https://github.com/ivanvorobei/SparrowKit.git', :tag => s.version }
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Ivan Vorobei" => "hello@ivanvorobei.by" }
  
  s.swift_version = '5.1'
  s.ios.deployment_target = '12.0'
  s.tvos.deployment_target = '12.0'
  s.watchos.deployment_target = '6.0'

  s.source_files = 'Sources/SparrowKit/**/*.swift'

end
