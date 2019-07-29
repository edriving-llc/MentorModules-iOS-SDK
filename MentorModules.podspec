Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '12.0'
s.name = "MentorModules"
s.summary = "MentorModules by eDriving"
s.requires_arc = true
s.version = "0.1.0"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Jeffrey Wang" => "jeffrey.wang@edriving.com" }
s.homepage = "https://bitbucket.org/edrivingllc/modulessdk_ios/src/master/"
s.source = { :git => "https://bitbucket.org/edrivingllc/modulessdk_ios.git", :tag => "#{s.version}" }
s.dependency 'Alamofire'
s.dependency 'SwiftyJSON'
s.source_files = "MentorModules/**/*.{swift}"
s.swift_version = "5.0"

end
