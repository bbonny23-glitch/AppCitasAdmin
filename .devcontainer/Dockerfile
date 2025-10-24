FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y git curl unzip xz-utils zip ca-certificates locales sudo wget openjdk-11-jdk build-essential libglu1-mesa && locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Install Flutter SDK (stable)
RUN git clone https://github.com/flutter/flutter.git -b stable /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Install Android SDK command-line tools and packages
ENV ANDROID_SDK_ROOT=/opt/android-sdk
RUN mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools \
 && cd /tmp \
 && wget -q https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O cmdline-tools.zip \
 && unzip cmdline-tools.zip -d ${ANDROID_SDK_ROOT} \
 && mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools/latest \
 && mv ${ANDROID_SDK_ROOT}/cmdline-tools/* ${ANDROID_SDK_ROOT}/cmdline-tools/latest/ || true \
 && rm cmdline-tools.zip
ENV PATH="${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/platform-tools:${PATH}"
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Accept licenses and install platforms and build-tools
RUN yes | ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --licenses || true
RUN ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platform-tools" "platforms;android-33" "build-tools;33.0.2" "cmdline-tools;latest" || true

# Precache flutter artifacts for web and android
RUN /usr/local/flutter/bin/flutter --version || true
RUN /usr/local/flutter/bin/flutter precache --web --android || true

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/*