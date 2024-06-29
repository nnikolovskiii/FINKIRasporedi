# Step 1: Use an official image as a parent image
FROM ubuntu:20.04

# Step 2: Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Step 3: Install required dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    openjdk-8-jdk \
    wget

# Step 4: Install Flutter
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /flutter
ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Step 5: Install Android SDK
RUN mkdir -p /android-sdk/cmdline-tools && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-8092744_latest.zip -O /cmdline-tools.zip && \
    unzip /cmdline-tools.zip -d /android-sdk/cmdline-tools && \
    rm /cmdline-tools.zip

# Step 6: Move cmdline-tools to the correct location
RUN mkdir -p /android-sdk/cmdline-tools/latest && \
    mv /android-sdk/cmdline-tools/cmdline-tools/* /android-sdk/cmdline-tools/latest

# Step 7: Accept licenses and install required SDK packages
RUN yes | /android-sdk/cmdline-tools/latest/bin/sdkmanager --sdk_root=/android-sdk --licenses && \
    yes | /android-sdk/cmdline-tools/latest/bin/sdkmanager --sdk_root=/android-sdk "platform-tools" "platforms;android-30" "build-tools;30.0.3"

# Step 8: Set environment variables for Android SDK
ENV ANDROID_SDK_ROOT="/android-sdk"
ENV PATH="${PATH}:${ANDROID_SDK_ROOT}/platform-tools:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/build-tools/30.0.3"

# Step 9: Set working directory
WORKDIR /app

# Step 10: Copy the Flutter app into the Docker image
COPY . .

# Step 11: Get Flutter dependencies
RUN flutter pub get

# Step 12: Build argument and environment variable for API URL
ARG API_URL
ENV API_URL=${API_URL}

# Step 13: Replace config.json with build-time API_URL
RUN sed -i "s|default_value|${API_URL}|g" config.json

# Step 14: Expose port 8080
EXPOSE 8080

# Step 15: Entry point
CMD ["flutter", "run", "--release", "-d", "web-server", "--web-port", "8080", "--web-hostname", "0.0.0.0"]
