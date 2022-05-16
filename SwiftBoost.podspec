Pod::Spec.new do |s|

  s.name = 'SwiftBoost'
  s.version = '4.0.0'
  s.summary = 'Collection of Swift-extensions to boost development process.'
  s.homepage = 'https://github.com/sparrowcode/SwiftBoost'
  s.source = { :git => 'https://github.com/sparrowcode/SwiftBoost.git', :tag => s.version }
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Sparrow Code" => "hello@sparrowcode.io" }
  
  s.swift_version = '5.1'
  s.ios.deployment_target = '13.0'
  s.tvos.deployment_target = '13.0'
  s.watchos.deployment_target = '6.0'

  s.source_files = 'Sources/SwiftBoost/**/*.swift'

end
