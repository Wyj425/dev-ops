## 1. 解压jdk

```java
tar -zxvf jdk-8u202-linux-x64.tar.gz
```

## 3.修改解压后文件的文件名

```java
mv jdk1.8.0_202 jdk-8u202
```

## 4.配置Java环境，编辑/etc/profile文件

```java
vim /etc/profile
```

## 5.打开以后将下面三句输入到文件里面并保存退出

```java
export JAVA_HOME=/software/jdk-8u202
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib:$CLASSPATH
export JAVA_PATH=${JAVA_HOME}/bin:${JRE_HOME}/bin
export PATH=$PATH:${JAVA_PATH}
```
## 6.生效profile

```java
source /etc/profile
```
 
## 7.查询Java版本，出现的版本是自己下载的版本，则安装成功。

```java
java -version
```

