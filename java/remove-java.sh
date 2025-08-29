#!/bin/sh
# ========= 卸载 JDK =========
# 用法：
#   sudo sh remove-java.sh           # 交互选择卸载版本
#   sudo sh remove-java.sh all       # 卸载所有版本

JDK_DST="/usr/local/java"
JAVA_PROFILE="/etc/profile.d/java.sh"

log()  { printf "%s %s\n" "[INFO]" "$*"; }
err()  { printf "%s %s\n" "[ERR ]" "$*" >&2; exit 1; }

need_root() {
  if [ "$(id -u)" -ne 0 ]; then
    err "请用 root 运行（需要删除 $JDK_DST 下的目录和 $JAVA_PROFILE）"
  fi
}

list_versions() {
  ls -1d "$JDK_DST"/jdk*/ 2>/dev/null | sed "s|$JDK_DST/||;s|/||" || true
}

remove_version() {
  ver="$1"
  dir="$JDK_DST/$ver"

  if [ ! -d "$dir" ]; then
    err "未找到要卸载的 JDK：$ver"
  fi

  log "正在卸载 $ver ..."
  rm -rf "$dir"

  # 如果 current 指向这个版本，删除软链
  if [ -L "$JDK_DST/current" ]; then
    target=$(readlink "$JDK_DST/current")
    if [ "$target" = "$dir" ]; then
      log "移除 current 软链（原来指向 $ver）"
      rm -f "$JDK_DST/current"
    fi
  fi
}

cleanup_profile() {
  versions=$(list_versions)
  if [ -z "$versions" ]; then
    log "没有剩余 JDK，清理环境变量 $JAVA_PROFILE ..."
    rm -f "$JAVA_PROFILE"
  fi
}

main() {
  need_root

  if [ $# -ge 1 ] && [ "$1" = "all" ]; then
    versions=$(list_versions)
    [ -z "$versions" ] && err "未找到任何已安装的 JDK"
    log "卸载所有 JDK：$versions"
    for v in $versions; do
      remove_version "$v"
    done
    cleanup_profile
    log "已全部卸载完成"
    return
  fi

  versions=$(list_versions)
  [ -z "$versions" ] && err "未找到任何已安装的 JDK"

  log "检测到以下已安装 JDK："
  i=0
  for v in $versions; do
    i=$((i+1))
    echo "  [$i] $v"
    eval "opt_$i=\"$v\""
  done
  echo "  [a] 全部卸载"

  printf "请输入要卸载的序号或 a: "
  read -r choice

  if [ "$choice" = "a" ]; then
    for v in $versions; do
      remove_version "$v"
    done
    cleanup_profile
    log "已全部卸载完成"
  else
    eval "sel=\${opt_$choice:-}"
    [ -z "$sel" ] && err "无效选择"
    remove_version "$sel"
    cleanup_profile
    log "已卸载完成：$sel"
  fi
}

main "$@"
