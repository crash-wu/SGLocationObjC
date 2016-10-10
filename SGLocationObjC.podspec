#
# Be sure to run `pod lib lint SGLocationObjC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SGLocationObjC'
  s.version          = '0.0.1'
  s.summary          = '基于ArcGis加载天地图瓦片的定位功能.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = '基于ArcGis加载天地图瓦片的定位功能'


  s.homepage         = 'https://github.com/crash-wu/SGLocationObjC'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '吴小星' => 'crash_wu@163.com' }
  s.source           = { :git => 'https://github.com/crash-wu/SGLocationObjC.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SGLocationObjC/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SGLocationObjC' => ['SGLocationObjC/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

    s.xcconfig = {

    "FRAMEWORK_SEARCH_PATHS" => "$(HOME)/Library/SDKs/ArcGIS/iOS" ,
    "OTHER_LDFLAGS"  => '-lObjC -framework ArcGIS -l c++',

    'ENABLE_BITCODE' => 'NO',
    'CLANG_ENABLE_MODULES' => 'YES'

    }

end
