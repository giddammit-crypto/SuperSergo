#!/usr/bin/env bash
set -e

# Определение JAVA_HOME для совместимости с AGP 8.2 (требуется Java 17)
if [ -d "/usr/lib/jvm/java-17-openjdk-amd64" ]; then
    export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
    export PATH="$JAVA_HOME/bin:$PATH"
fi

TARGET="${1:-debug}"

case "$TARGET" in
    debug)
        echo "==> Сборка Debug APK..."
        ./gradlew assembleDebug
        echo "==> Готово: app/build/outputs/apk/debug/app-debug.apk"
        ;;
    release)
        echo "==> Сборка Release APK..."
        ./gradlew assembleRelease
        echo "==> Готово: app/build/outputs/apk/release/app-release-unsigned.apk"
        ;;
    bundle)
        echo "==> Сборка Release AAB (App Bundle)..."
        ./gradlew bundleRelease
        echo "==> Готово: app/build/outputs/bundle/release/app-release.aab"
        ;;
    all)
        echo "==> Сборка всех таргетов (Debug APK, Release APK, Release AAB)..."
        ./gradlew assembleDebug assembleRelease bundleRelease
        echo "==> Все артефакты собраны в app/build/outputs/"
        ;;
    clean)
        echo "==> Очистка сборки..."
        ./gradlew clean
        ;;
    *)
        echo "Использование: $0 [debug|release|bundle|all|clean]"
        exit 1
        ;;
esac
