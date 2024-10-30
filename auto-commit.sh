#!/bin/bash

# 获取当前脚本所在目录，并输出
SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
echo "Current directory: $SHELL_FOLDER"

# 设置环境变量
# 检查配置文件是否存在
if [ -f "${SHELL_FOLDER}/config.txt" ]; then
    # 如果配置文件存在，读取配置
    while IFS='=' read -r key value; do
        echo "Loading config: $key=$value"
        export "$key"="$value"
    done < "${SHELL_FOLDER}/config.txt"
else
    # 配置文件不存在
    echo "Warning: config.txt not found, using default settings"
    # 可以在这里设置默认值
    export REPO_URL="https://你的用户名.github.io/项目名/"
fi

# 进入项目目录
cd $SHELL_FOLDER

# 检查是否安装了必要的命令
if ! command -v git &> /dev/null; then
    echo "Error: git is not installed"
    exit 1
fi

# 获取当前时间
commitTime=$(date +"%Y-%m-%d %H:%M:%S")

# 获取更改的文件数量
changed_files=$(git status --porcelain | wc -l)

# 添加所有更改
echo "Adding changes to git..."
git add .

# 提交更改
echo "Committing changes..."
commit_message="Update: ${commitTime}\n\n"
commit_message+="Changed files: ${changed_files}\n"
commit_message+="Modified files:\n"
commit_message+=$(git status --porcelain)

git commit -m "$commit_message"

# 推送到远程仓库
echo "Pushing to remote repository..."
git push origin main

# 完成提示
echo "✨ Deployment completed!"
echo " Date: $commitTime"
echo " Changed files: $changed_files"
echo " Directory: $SHELL_FOLDER"