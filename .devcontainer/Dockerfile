FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y git curl unzip xz-utils zip ca-certificates locales sudo \
  && locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
# Install Flutter SDK (stable)
RUN git clone https://github.com/flutter/flutter.git -b stable /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
# Precache web artifacts to speed up first run
RUN /usr/local/flutter/bin/flutter --version || true
RUN /usr/local/flutter/bin/flutter precache --web || true