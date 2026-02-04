platform :ios, '13.0'

target 'DemoApp' do
  use_frameworks!

  pod 'hosted-ios-plugin', :path => '../Plugin'
  pod 'SwiftyMenu', '~> 0.6.5'
  pod 'iOSDropDown'
  pod 'SwiftPublicIP', '~> 0.0.2'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      config.build_settings['CLANG_ENABLE_OBJC_ARC'] = 'YES'
    end
  end
end
