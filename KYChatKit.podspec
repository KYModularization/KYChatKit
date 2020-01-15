#
# Be sure to run `pod lib lint KYChatKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KYChatKit'
  s.version          = '0.0.2'
  s.summary          = '腾讯im'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/liangyujuan/KYChatKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liangyujuan' => '18730231873@163.com' }
  s.source           = { :git => 'https://github.com/liangyujuan/KYChatKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'KYChatKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'KYChatKit' => ['KYChatKit/Assets/*.png']
  # }

#  s.public_header_files = ' ‘Pod/Classes/* * /* * /*.h'
  s.frameworks = 'UIKit', 'AVFoundation'
   s.dependency 'component_baseUI_iOS', '~> 0.0.1'
   s.dependency 'KYCommonKit', '~> 0.0.3'
   s.dependency 'JPush', '~> 3.1.0'
   s.pod_target_xcconfig = {
     'FRAMEWORK_SEARCH_PATHS' => '$(inherited)
     $(PODS_ROOT)/libjpush-ios-3.1.2',
     'OTHER_LDFLAGS'          => '$(inherited) -undefined
   dynamic_lookup'
   }
end
