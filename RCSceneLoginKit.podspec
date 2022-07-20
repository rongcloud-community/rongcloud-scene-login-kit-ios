#
# Be sure to run `pod lib lint RCSceneLoginKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RCSceneLoginKit'
  s.version          = '0.1.2'
  s.summary          = '融云场景化 App RCE 登录组件【OC】'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://www.rongcloud.cn/devcenter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '彭蕾' => 'penglei1@rongcloud.cn' }
  s.source           = { :git => 'git@github.com:rongcloud-community/rongcloud-scene-login-kit-ios.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'RCSceneLoginKit/Classes/*.h'

  s.subspec 'Common' do |ss|
    ss.source_files = 'RCSceneLoginKit/Classes/Common/**/*'
  end

  s.subspec 'Network' do |ss|
    ss.dependency 'RCSceneLoginKit/Common'
    
    ss.source_files = 'RCSceneLoginKit/Classes/Network/**/*'
  end
  
  s.subspec 'CountryCode' do |ss|
    ss.dependency 'RCSceneLoginKit/Network'
    ss.dependency 'RCSceneLoginKit/Common'
    
    ss.source_files = 'RCSceneLoginKit/Classes/CountryCode/**/*'
  end
  
  s.subspec 'Login' do |ss|
    ss.dependency 'RCSceneLoginKit/Network'
    ss.dependency 'RCSceneLoginKit/Common'
    ss.dependency 'RCSceneLoginKit/CountryCode'
    
    ss.source_files = 'RCSceneLoginKit/Classes/Login/**/*'
  end
  
   s.resource_bundles = {
     'RCSceneLoginKit' => ['RCSceneLoginKit/Assets/**/*']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Masonry'
  s.dependency 'YYModel'
  s.dependency 'SVProgressHUD'
  s.dependency 'RCSceneBaseKit'
  s.dependency 'RCSceneNetworkKit'
  s.dependency 'RCSceneWebKit'
  
  s.prefix_header_file = 'RCSceneLoginKit/Classes/Common/RCSLoginPrefixHeader.pch'
  
end
