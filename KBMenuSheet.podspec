#
#  Be sure to run `pod spec lint KBFormSheetController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "KBMenuSheet"
  s.version      = "0.0.15"
  s.summary      = "KBMenuSheet."
  s.author       = {"xiaoxiong" => "821859554@qq.com"}
  s.description  = <<-DESC
                    This is KBMenuSheet.
                   DESC

  s.homepage     = "ssh://xxx/xxx/iOS/KBMenuSheetView.git"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "ssh://xxx/xxx/iOS/KBMenuSheetView.git", :tag => s.version.to_s }

  s.source_files  = "KBMenuSheet/KBMenuSheet/**/*.{h,m}"
  #s.frameworks = "CoreGraphics", "UIKit"
  s.requires_arc = true
  s.dependency "FMDB"
  #s.resource = "KBMenuSheet/Assets.xcassets"
  s.resources = ["KBMenuSheet/Assets.xcassets", "KBMenuSheet/address.db"]


  s.xcconfig = {
    'FRAMEWORK_SEARCH_PATHS' => '$(PODS_ROOT)/UmengSocial/Umeng_SDK_Social_iOS_ARM64_5.0/UMSocial_Sdk_Extra_Frameworks/TencentOpenAPI/ $(PODS_ROOT)/UmengSocial/Umeng_SDK_Social_iOS_ARM64_5.0/UMSocial_Sdk_Extra_Frameworks/Facebook/ $(PODS_ROOT)/UmengSocial/Umeng_SDK_Social_iOS_ARM64_5.0/UMSocial_Sdk_Extra_Frameworks/Twitter/',

    'HEADER_SEARCH_PATHS' => '${PODS_ROOT}/Headers/Public/UMengSocial',
    'LIBRARY_SEARCH_PATHS' => '$(PODS_ROOT)/UmengSocial/Umeng_SDK_Social_iOS_ARM64_5.0/UMSocial_Sdk_5.0 $(PODS_ROOT)/UmengSocial/Umeng_SDK_Social_iOS_ARM64_5.0/UMSocial_Sdk_Extra_Frameworks/TencentOpenAPI $(PODS_ROOT)/UmengSocial/Umeng_SDK_Social_iOS_ARM64_5.0/UMSocial_Sdk_Extra_Frameworks/Wechat $(PODS_ROOT)/UmengSocial/Umeng_SDK_Social_iOS_ARM64_5.0/UMSocial_Sdk_Extra_Frameworks/SinaSSO'
  }

end
