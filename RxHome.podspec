Pod::Spec.new do |s|
  s.name             = "RxHome"
  s.version          = "0.0.1"
  s.summary          = "HomeKit library for RxSwift"

  s.description      = <<-DESC
  RxHome adds lightweight Rx support for HomeKit.
                       DESC

  s.homepage         = "https://github.com/mataspetrikas/RxHome"
  s.license          = 'MIT'
  s.author           = { "Matas Petrikas" => "matas.petrikas@gmail.com"}
  s.source           = { :git => "https://github.com/mataspetrikas/RxHomet.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/matas'

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '2.0' 

  s.requires_arc = true

  s.source_files = 'Source/*.swift'
  s.frameworks   = 'HomeKit'
  s.dependency 'RxSwift', '~> 4.0'
end
