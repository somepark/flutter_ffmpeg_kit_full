#!/bin/bash

# 设置颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# 配置信息
IOS_URL="https://github.com/somepark/flutter_ffmpeg_kit_full/releases/download/ffmpegkit_full_ios/ffmpegkit_full_ios.zip"
ZIP_FILE="frameworks.zip"
TARGET_DIR="Frameworks"
# 预期的SHA-256哈希值（需要预先计算或从可信来源获取）
EXPECTED_HASH="PUT_YOUR_EXPECTED_SHA256_HASH_HERE"

# 创建目标目录
mkdir -p "$TARGET_DIR"

# 检查是否已存在部分下载的文件
if [ -f "$ZIP_FILE" ]; then
    echo -e "${YELLOW}检测到部分下载的文件，尝试继续下载...${NC}"

    # 获取远程文件大小
    REMOTE_SIZE=$(curl -sI "$IOS_URL" | grep -i "content-length" | awk '{print $2}' | tr -d '\r')

    # 获取本地文件大小
    LOCAL_SIZE=$(stat -c %s "$ZIP_FILE" 2>/dev/null || echo 0)

    if [ -n "$REMOTE_SIZE" ] && [ "$LOCAL_SIZE" -gt 0 ] && [ "$LOCAL_SIZE" -lt "$REMOTE_SIZE" ]; then
        echo -e "${YELLOW}继续从 ${LOCAL_SIZE} 字节处下载...${NC}"
        curl -L -C - "$IOS_URL" -o "$ZIP_FILE"
    else
        echo -e "${YELLOW}本地文件大小异常或已完整下载，重新下载...${NC}"
        rm -f "$ZIP_FILE"
        curl -L "$IOS_URL" -o "$ZIP_FILE"
    fi
else
    echo -e "${GREEN}开始下载文件...${NC}"
    curl -L "$IOS_URL" -o "$ZIP_FILE"
fi

# 检查下载是否成功
if [ $? -ne 0 ]; then
    echo -e "${RED}下载失败！${NC}"
    exit 1
fi

# 验证文件完整性（如果提供了预期哈希值）
if [ "$EXPECTED_HASH" != "PUT_YOUR_EXPECTED_SHA256_HASH_HERE" ]; then
    echo -e "${YELLOW}验证文件完整性...${NC}"
    ACTUAL_HASH=$(shasum -a 256 "$ZIP_FILE" | awk '{print $1}')

    if [ "$ACTUAL_HASH" == "$EXPECTED_HASH" ]; then
        echo -e "${GREEN}文件完整性验证通过！${NC}"
    else
        echo -e "${RED}文件完整性验证失败！可能下载不完整或文件已损坏。${NC}"
        echo -e "${RED}预期哈希: $EXPECTED_HASH${NC}"
        echo -e "${RED}实际哈希: $ACTUAL_HASH${NC}"
        exit 1
    fi
fi

# 解压文件
echo -e "${GREEN}开始解压文件...${NC}"
#unzip -o "$ZIP_FILE" -d "$TARGET_DIR"
unzip -o "$ZIP_FILE"

# 清理临时文件
echo -e "${GREEN}清理临时文件...${NC}"
rm -f "$ZIP_FILE"

echo -e "${GREEN}操作完成！${NC}"