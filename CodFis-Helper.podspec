#
# Be sure to run `pod lib lint CodFis-Helper.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CodFis-Helper"
  s.version          = "0.1.2"
  s.summary          = "CodFis-Helper help you to validate Tax Code"
  s.homepage         = "https://github.com/giuseppenucifora/CodFis-Helper"
  s.license          = 'MIT'
  s.author           = { "Giuseppe Nucifora" => "me@giuseppenucifora.com" }
  s.source           = { :git => "https://github.com/giuseppenucifora/CodFis-Helper.git", :tag => s.version.to_s }


  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'CodFis-Helper/*.{h,m}'
  s.resource_bundles = {
    'CodFis-Helper' => ['Pod/Assets/*.png']
  }
end
