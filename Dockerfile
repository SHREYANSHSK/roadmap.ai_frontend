# Stage 1: Build Flutter web app
FROM dart:stable AS flutter-build
WORKDIR /app

# Install dependencies for Flutter
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter SDK (version 3.32.5)
RUN git clone --branch 3.32.5 https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:$PATH"

# Verify Flutter installation
RUN flutter --version
RUN flutter doctor

# Copy project and build
COPY . /app
RUN flutter pub get
RUN flutter build web --release

# Stage 2: Serve with Nginx
FROM nginx:alpine
COPY --from=flutter-build /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]