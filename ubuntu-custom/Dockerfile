FROM ubuntu:22.04

LABEL maintainer="docker-beginner@example.com"
LABEL description="커스텀 기본 기능이 추가된 우분투 이미지"

ENV DEBIAN_FRONTEND=noninteractive
ENV APP_HOME=/app
ENV APP_VERSION=1.0

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    nano \
    htop \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash appuser

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN echo '#!/bin/bash' > /app/welcome.sh && \
    echo 'echo "🐳 Welcome to Custom Ubuntu Container!"' >> /app/welcome.sh && \
    echo 'echo "APP_VERSION: $APP_VERSION"' >> /app/welcome.sh && \
    chmod +x /app/welcome.sh

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000 || exit 1

EXPOSE 8000

USER appuser

CMD ["/bin/bash"]
