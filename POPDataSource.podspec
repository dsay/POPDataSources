#
# Be sure to run `pod lib lint POPDataSource.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  
  s.platform = :ios
  
  s.ios.deployment_target = '11.0'
  
  s.name = "POPDataSource"
  
  s.summary = "Protocol oriented programming. Data source for uitableview."
  
  s.requires_arc = true
  
  s.version = "0.3.11"
  
  s.license = { :type => 'MIT', :file => 'LICENSE' }

  s.author = { "Dima Sai" => "dmitriy.sai2013@gmail.com" }
  
  s.homepage = 'https://github.com/dsay/POPDataSource'

  s.source = { :git => 'https://github.com/dsay/POPDataSources.git', :tag => s.version.to_s }
  
  s.framework = "UIKit"
  
  s.swift_version = ['5.1', '5.2']
  
  s.source_files = "Sources/**/*.{swift}"
  
end
