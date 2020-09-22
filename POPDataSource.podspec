#
# Be sure to run `pod lib lint POPDataSource.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  
  s.platform = :ios
  
  s.ios.deployment_target = '12.0'
  
  s.name = "POPDataSource"
  
  s.summary = "Protocol oriented programming. Data source for uitableview."
  
  s.requires_arc = true
  
  s.version = "0.2.5"
  
  s.license = { :type => 'MIT', :file => 'LICENSE' }

  s.author = { "Dima Sai" => "dmitriy.sai2013@gmail.com" }
  
  s.homepage = 'https://github.com/dsay/POPDataSource'

  s.source = { :git => 'https://github.com/dsay/POPDataSources.git', :branch => s.version.to_s, :tag => s.version.to_s }
  s.framework = "UIKit"
  
  s.swift_version = "5.0"
  
  s.source_files = "POPDataSource/Classes/**/*.{swift}"
  
  #s.resources = "POPDataSource/**/*.{png,jpeg,jpg,storyboard,xib}"
  
end
#pod trunk push /Users/user/Desktop/prog/POPDataSource/vendor/POPDataSources/POPDataSource.podspec --swift-version=4.2
