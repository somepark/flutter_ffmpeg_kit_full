#!/bin/bash
execute_command() {
  # iOS 框架下载解压
  #IOS_URL="https://github.com/somepark/flutter_ffmpeg_kit_full/releases/download/ffmpegkit_full_ios/ffmpegkit_full_ios.zip"
  #mkdir -p Frameworks
  #curl -L $IOS_URL -o frameworks.zip
  chmod +x ../scripts/download_frameworks_ios.sh
  . ../scripts/download_frameworks_ios.sh
  #unzip -o frameworks.zip -d Frameworks
  #rm frameworks.zip

  # 移除所有框架中的bitcode
  xcrun bitcode_strip -r Frameworks/ffmpegkit.framework/ffmpegkit -o Frameworks/ffmpegkit.framework/ffmpegkit
  xcrun bitcode_strip -r Frameworks/libavcodec.framework/libavcodec -o Frameworks/libavcodec.framework/libavcodec
  xcrun bitcode_strip -r Frameworks/libavdevice.framework/libavdevice -o Frameworks/libavdevice.framework/libavdevice
  xcrun bitcode_strip -r Frameworks/libavfilter.framework/libavfilter -o Frameworks/libavfilter.framework/libavfilter
  xcrun bitcode_strip -r Frameworks/libavformat.framework/libavformat -o Frameworks/libavformat.framework/libavformat
  xcrun bitcode_strip -r Frameworks/libavutil.framework/libavutil -o Frameworks/libavutil.framework/libavutil
  xcrun bitcode_strip -r Frameworks/libswresample.framework/libswresample -o Frameworks/libswresample.framework/libswresample
  xcrun bitcode_strip -r Frameworks/libswscale.framework/libswscale -o Frameworks/libswscale.framework/libswscale

}


echo "判断 Frameworks 目录是否存在"

if [ -d "./Frameworks" ]; then
    # 计算目录中的文件和文件夹数量（不包括 . 和 ..）
    FILE_COUNT=$(find "./Frameworks" -maxdepth 1 -type d -name "*.framework" 2>/dev/null | wc -l | tr -d ' ')
    echo "Frameworks 目录中的文件/文件夹数量不足（当前 $FILE_COUNT ，至少需要 8），重新执行环境配置..."
    # 检查文件数量是否符合要求
    if [ "$FILE_COUNT" -lt 8 ]; then
      echo "Frameworks 目录中的文件/文件夹数量不足（当前 $FILE_COUNT ，至少需要 8），重新执行环境配置..."
      execute_command
    else
      echo "Frameworks 目录已存在且文件完整（$FILE_COUNT 个文件/文件夹），跳过环境配置"
    fi
else
  echo "Frameworks 目录不存在"
  execute_command
fi


