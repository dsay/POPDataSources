Pod::Spec.new do |s|

s.platform = :ios

s.ios.deployment_target = '10.0'

s.name = "POPDataSource"

s.summary = "Protocol oriented programming. Data source for uitableview."

s.requires_arc = true

s.version = "0.1.0"

s.license = { :type => "MIT", :file => "LICENSE" }

s.author = { "Dima Sai" => "dima.say2013@yandex.com" }

s.homepage = "https://github.com/dsay/POPDataSource"

s.source = { :git => "https://github.com/dsay/POPDataSources.git", :tag => "#{s.version}"}

s.framework = "UIKit"

s.source_files = "POPDataSource/**/*.{swift}"

s.resources = "POPDataSource/**/*.{png,jpeg,jpg,storyboard,xib}"

end
