FROM ubuntu:22.04

# Prerequisites
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-11-jdk wget

# Set up new user
RUN useradd -ms /bin/bash developer
USER developer
WORKDIR /home/developer

# Prepare Android directories and system variables
RUN mkdir -p Android/sdk
ENV ANDROID_SDK_ROOT /home/developer/Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg

# Set up Android SDK
RUN wget -O commandlinetools.zip https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip
RUN unzip commandlinetools.zip && rm commandlinetools.zip
RUN mv cmdline-tools Android/sdk/
RUN mkdir Android/sdk/cmdline-tools/latest
RUN mv Android/sdk/cmdline-tools/bin Android/sdk/cmdline-tools/lib Android/sdk/cmdline-tools/NOTICE.txt Android/sdk/cmdline-tools/source.properties Android/sdk/cmdline-tools/latest/
RUN cd Android/sdk/cmdline-tools/latest/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/cmdline-tools/latest/bin && ./sdkmanager "build-tools;33.0.2" "patcher;v4" "platform-tools" "platforms;android-33" "sources;android-33"
ENV PATH "$PATH:/home/developer/Android/sdk/platform-tools"

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/developer/flutter/bin"

# Use flutter stable version
#RUN cd flutter && git checkout 3.10.0 && cd ..
RUN flutter channel stable


# Run basic check to download Dark SDK
RUN flutter doctor