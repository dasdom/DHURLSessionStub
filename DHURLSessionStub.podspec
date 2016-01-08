#
# Be sure to run `pod lib lint DHURLSessionStub.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DHURLSessionStub"
  s.version          = "0.1.0"
  s.summary          = "A stub for block based data tasks of NSURLSession."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                      This pod helps you to write easy unit test stubs for NSURLSession data tasks. At the moment it only supports the block bases API of NSURLSesssion because this is what I use in 95% of the cases. This is useful for example when you want to implement the API client of your app befor the server side is finished or if you want to test the networking of your app without internet connection.
                       DESC

  s.homepage         = "https://github.com/<GITHUB_USERNAME>/DHURLSessionStub"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Dominik Hauser" => "dominik.hauser@dasdom.de" }
  s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/DHURLSessionStub.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dasdom'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'DHURLSessionStub' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
