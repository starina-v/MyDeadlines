# ignore all warnings from all pods
inhibit_all_warnings!
use_frameworks!

platform :ios, '13.0'

def app_set
    pod 'Swinject'
    pod 'SwinjectAutoregistration'
end

target 'MyDeadlines' do
    app_set
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
end
