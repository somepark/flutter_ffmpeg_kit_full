#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_ffmpeg_kit_full_gpl.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_ffmpeg_kit_full'
  s.version          = '0.0.1'
  s.summary          = 'FFmpeg Kit for Flutter'
  s.description      = 'A Flutter plugin for running FFmpeg and FFprobe commands.'
  s.homepage         = 'https://github.com/arthenica/ffmpeg-kit'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'ARTHENICA' => 'open-source@arthenica.com' }

  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  s.default_subspec = 'full-gpl-lts'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  s.subspec 'min' do |ss|
    ss.source_files         = 'Classes/**/*'
    ss.public_header_files  = 'Classes/**/*.h'
    ss.dependency 'ffmpeg-kit-ios-min', "6.0"
    ss.ios.deployment_target = '12.1'
  end

  s.subspec 'min-lts' do |ss|
    ss.source_files         = 'Classes/**/*'
    ss.public_header_files  = 'Classes/**/*.h'
    ss.dependency 'ffmpeg-kit-ios-min', "6.0.LTS"
    ss.ios.deployment_target = '10'
  end

  s.subspec 'min-gpl' do |ss|
    ss.source_files         = 'Classes/**/*'
    ss.public_header_files  = 'Classes/**/*.h'
    ss.dependency 'ffmpeg-kit-ios-min-gpl', "6.0"
    ss.ios.deployment_target = '12.1'
  end

  s.subspec 'min-gpl-lts' do |ss|
    ss.source_files         = 'Classes/**/*'
    ss.public_header_files  = 'Classes/**/*.h'
    ss.dependency 'ffmpeg-kit-ios-min-gpl', "6.0.LTS"
    ss.ios.deployment_target = '10'
  end

  s.subspec 'https' do |ss|
    ss.source_files         = 'Classes/**/*'
    ss.public_header_files  = 'Classes/**/*.h'
    ss.dependency 'ffmpeg-kit-ios-https', "6.0"
    ss.ios.deployment_target = '12.1'
  end

  s.subspec 'https-lts' do |ss|
    ss.source_files         = 'Classes/**/*'
    ss.public_header_files  = 'Classes/**/*.h'
    ss.dependency 'ffmpeg-kit-ios-https', "6.0.LTS"
    ss.ios.deployment_target = '10'
  end

  s.subspec 'https-gpl' do |ss|
    ss.source_files         = 'Classes/**/*'
    ss.public_header_files  = 'Classes/**/*.h'
    ss.dependency 'ffmpeg-kit-ios-https-gpl', "6.0"
    ss.ios.deployment_target = '12.1'
  end

  s.subspec 'https-gpl-lts' do |ss|
    ss.source_files         = 'Classes/**/*'
    ss.public_header_files  = 'Classes/**/*.h'
    ss.dependency 'ffmpeg-kit-ios-https-gpl', "6.0.LTS"
    ss.ios.deployment_target = '10'
  end

  s.subspec 'audio' do |ss|
    ss.source_files         = 'Classes/**/*'
    ss.public_header_files  = 'Classes/**/*.h'
    ss.dependency 'ffmpeg-kit-ios-audio', "6.0"
    ss.ios.deployment_target = '12.1'
  end

  s.subspec 'audio-lts' do |ss|
    ss.source_files         = 'Classes/**/*'
    ss.public_header_files  = 'Classes/**/*.h'
    ss.dependency 'ffmpeg-kit-ios-audio', "6.0.LTS"
    ss.ios.deployment_target = '10'
  end

  s.subspec 'video' do |ss|
    ss.source_files         = 'Classes/**/*'
    ss.public_header_files  = 'Classes/**/*.h'
    ss.dependency 'ffmpeg-kit-ios-video', "6.0"
    ss.ios.deployment_target = '12.1'
  end

  s.subspec 'video-lts' do |ss|
    ss.source_files         = 'Classes/**/*'
    ss.public_header_files  = 'Classes/**/*.h'
    ss.dependency 'ffmpeg-kit-ios-video', "6.0.LTS"
    ss.ios.deployment_target = '10'
  end

  s.subspec 'full' do |ss|
    ss.source_files         = 'Classes/**/*'
    ss.public_header_files  = 'Classes/**/*.h'
    ss.dependency 'ffmpeg-kit-ios-full', "6.0"
    ss.ios.deployment_target = '12.1'
  end

  s.subspec 'full-lts' do |ss|
    ss.source_files         = 'Classes/**/*'
    ss.public_header_files  = 'Classes/**/*.h'
    ss.dependency 'ffmpeg-kit-ios-full', "6.0.LTS"
    ss.ios.deployment_target = '10'
  end

  s.subspec 'full-gpl' do |ss|
    ss.source_files         = 'Classes/**/*'
    ss.public_header_files  = 'Classes/**/*.h'
    ss.dependency 'ffmpeg-kit-ios-full-gpl', "6.0"
    ss.ios.deployment_target = '12.1'
  end

#   s.subspec 'full-gpl-lts' do |ss|
#     ss.source_files         = 'Classes/**/*'
#     ss.public_header_files  = 'Classes/**/*.h'
#     #ss.dependency 'ffmpeg-kit-ios-full-gpl', "6.0.LTS"
#     ss.ios.deployment_target = '12.1'

  s.subspec 'full-gpl-lts' do |ss|
    ss.source_files         = 'Classes/**/*'
    ss.public_header_files  = 'Classes/**/*.h'
    # 移除原依赖声明
    # ss.dependency 'ffmpeg-kit-ios-full-gpl', "5.1.LTS"

    # 添加本地框架配置
    ss.ios.vendored_frameworks = 'Frameworks/ffmpegkit.framework',
                                 'Frameworks/libavcodec.framework',
                                 'Frameworks/libavdevice.framework',
                                 'Frameworks/libavfilter.framework',
                                 'Frameworks/libavformat.framework',
                                 'Frameworks/libavutil.framework',
                                 'Frameworks/libswresample.framework',
                                 'Frameworks/libswscale.framework'

    ss.ios.frameworks = 'AudioToolbox', 'CoreMedia'
    ss.libraries = 'z', 'bz2', 'c++', 'iconv'
    ss.ios.deployment_target = '10'

    # 添加预安装钩子
    s.prepare_command = <<-CMD
    chmod +x ../scripts/setup_ios.sh
    ../scripts/setup_ios.sh
    CMD

  end



  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'flutter_ffmpeg_kit_full_gpl_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
