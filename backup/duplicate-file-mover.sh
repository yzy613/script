#!/bin/bash

# 定义一个关联数组来存储哈希值
declare -A filehashes

# 从 pwd 命令获取当前工作目录
directory=$(pwd)

# 提示确认工作路径和重复文件路径
echo "工作路径: $directory"
echo "重复文件将被移动到: $directory/duplicate"

# 提示用户确认是否继续
read -p "是否继续去重操作？(yes/no): " user_choice

# 根据用户输入决定是否继续
if [[ $user_choice != "yes" ]] && [[ $user_choice != "y" ]]; then
    echo "操作已取消"
    exit 1
fi

# 创建存放重复文件的子目录
mkdir -p "$directory/duplicate"

# 文件计数
count=0
# 遍历目录中的所有文件，正确处理空格和特殊字符
# 排除 duplicate 目录
find "$directory" -type f -not -path "$directory/duplicate/*" -print0 | while IFS= read -r -d '' file; do
    # 计算文件的 SHA1 哈希值
    sha1=$(sha1sum "$file" | awk '{ print $1 }')

    # 显示进度
    ((count++))
    printf "\r$count"

    # 检查哈希值是否已存在
    if [[ -n "${filehashes[$sha1]}" ]]; then
        printf "\rDuplicate file found: $file (Original: ${filehashes[$sha1]})\n"
        # 将重复文件移动到指定子目录
        mv "$file" "$directory/duplicate/"
    else
        # 将哈希值和文件名添加到数组中
        filehashes[$sha1]="$file"
    fi
done

printf "\n"
