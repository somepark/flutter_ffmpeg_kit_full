#!/bin/bash

set -e  # 出错立即退出

# Android AAR 下载
#chmod +x scripts/setup_android.sh

#TARGET_DIR="libs"
ANDROID_URL="https://github.com/somepark/flutter_ffmpeg_kit_full/releases/download/ffmpegkit_full_android/ffmpeg-kit-full-gpl-6.0-2.zip"
ZIP_FILE="libs.zip"

#mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

# 如果已经存在就跳过
if [ ! -f "ffmpeg-kit-full-gpl-6.0-2.aar" ]; then
  echo "Downloading FFmpeg dependencies..."
  curl -L "$ANDROID_URL" -o "$ZIP_FILE"
  unzip -o "$ZIP_FILE"
  rm -f "$ZIP_FILE"
else
  echo "FFmpeg dependencies already exist, skipping download."
fi