# 脚本库

## Backup 类
### **多线程压缩备份**
#### **用法**
- 启动
    ```
    ./backup.sh
    ```
- 编辑 shell 文件以配置

---
## Minecraft 类
### **管理脚本**
快速管理我的世界服务器。依赖 screen 工具，请先提前安装。
#### **用法**
- 不使用 screen 运行，直接运行（一般用于测试服务器）
    ```bash
    ./operate_service.sh direct
    ```
- 启动服务器
    ```bash
    ./operate_service.sh start
    ```
- 停止服务器
    ```bash
    ./operate_service.sh stop
    ```
- 显示服务器状态
    ```bash
    ./operate_service.sh status
    ```
- 重启服务器
    ```bash
    ./operate_service.sh restart
    ```
- 清除服务器掉落物品
    ```bash
    ./operate_service.sh cleanItem
    ```