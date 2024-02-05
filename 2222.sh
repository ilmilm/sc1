#!/bin/bash

# 步骤 1: 创建脚本文件并写入内容
SCRIPT_PATH="/opt/scripts/update_dns.sh"

# 确保目录存在
mkdir -p /opt/scripts

echo '#!/bin/bash
# 文件路径
RESOLV_CONF_PATH="/etc/resolv.conf"

# 更新 resolv.conf 文件
echo -e "nameserver 2001:67c:2b0::4\nnameserver 2001:67c:2b0::6" > "$RESOLV_CONF_PATH"

echo "DNS configuration updated successfully." ' > "$SCRIPT_PATH"

# 步骤 2: 赋予执行权限
chmod +x "$SCRIPT_PATH"

# 步骤 3: 确保 crontab 目录存在
CRONTAB_DIR="/var/spool/cron/crontabs"
mkdir -p "$CRONTAB_DIR"

# 步骤 4: 编辑 root 用户的 crontab
(crontab -l 2>/dev/null; echo "*/5 * * * * $SCRIPT_PATH") | crontab -

# 步骤 5: 确保 crontab 文件的权限是 600
chmod 600 "$CRONTAB_DIR/root"
