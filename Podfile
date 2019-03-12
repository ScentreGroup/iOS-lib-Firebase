platform :ios, '8.0'

plugin 'cocoapods-rome', { :pre_compile => Proc.new { |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end

    installer.pods_project.save
},

    dsym: true,
    configuration: 'Release'
}

target 'Frameworks' do
  pod 'Firebase' , '~> 5.18'
  pod 'Firebase/RemoteConfig'
end



