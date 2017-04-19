# POPDataSource

Installation

CocoaPods

CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:

$ gem install cocoapods
CocoaPods 1.1.0+ is required to build.
To integrate Alamofire into your Xcode project using CocoaPods, specify it in your Podfile:

source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
      pod 'POPDataSource', :git => 'https://github.com/dsay/POPDataSources.git', :tag => '0.1.2'
end
Then, run the following command:

$ pod install
