Pod::Spec.new do |s|

s.platform = :ios

s.ios.deployment_target = '10.0'

s.name = "POPDataSource"

s.summary = "Protocol oriented programming. Data source for uitableview."

s.requires_arc = true

s.version = "0.1.4"

s.license      = { :type => 'Apache License, Version 2.0', :text => <<-LICENSE
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
LICENSE
}
s.author = { "Dima Sai" => "dima.say2013@yandex.com" }

s.homepage = "https://github.com/dsay/POPDataSource"

s.source = { :git => "https://github.com/dsay/POPDataSources.git", :tag => "#{s.version}"}

s.framework = "UIKit"

s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }

s.source_files = "POPDataSource/**/*.{swift}"

#s.resources = "POPDataSource/**/*.{png,jpeg,jpg,storyboard,xib}"

end
