# # 前置步骤

## 1.把整个文件夹拖入服务器根目录



# 一.安装JAVA

- ```
  cd /dev-ops/java
  ```

  进入java目录

- 根据需要选择 安装/切换java版本/卸载java

  - 安装

    ```
    chmod +x install-java.sh
    ./install-java.sh
    ```

    会自动读取目录下有哪些安装包，让用户选择安装哪个版本，安装完之后，

    输入

    ```java
    source /etc/profile.d/java.sh
    java -version
    ```
  
  - 切换java版本
  
    ```
    chmod +x switch-java.sh
    ./switch-java.sh
    ```
  
    会自动读取安装了哪些jdk版本，并让用户选择切换哪个版本。切换完成后
  
    ```
    source /etc/profile.d/java.sh
    java -version
    ```
  
  - 卸载java
  
    ```
    chmod +x remove-java.sh
    ./remove-java.sh
    ```
  
    会自动读取安装了哪些jdk版本，并让用户选择卸载哪个版本或者全部卸载。
  
    

# 二.安装MAVEN

- ```
  cd /dev-ops/maven
  ```

  进入maven目录

  ```
  chmod +x install-maven.sh
  ./install-maven.sh
  ```

  

# 三.安装Docker和Docker镜像

- 回到dev-ops目录下

- 首先安装Docker

  ```
  chmod +x run_install_docker_local.sh 
  ./run_install_docker_local.sh 
  ```

  安装完后会提示是否安装Docker图形化界面，如果安装的话安装完之后请立即访问9000接口去设置密码。

- 然后安装软件

  ```
  chmod +x run_install_software.sh
  ./run_install_software.sh
  ```

  选择需要的软件即可。