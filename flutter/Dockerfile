FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    wget \
    jq

RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /flutter
ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:${PATH}"

WORKDIR /app

COPY . .

RUN flutter pub get

RUN cp config.json config.json.template
RUN chmod +x /flutter/bin/flutter

EXPOSE 8080

CMD ["sh", "-c", "jq --arg apiUrl \"$API_URL\" '.apiUrl = $apiUrl' config.json.template > config.json && flutter run --release -d web-server --web-port 8080 --web-hostname 0.0.0.0"]
