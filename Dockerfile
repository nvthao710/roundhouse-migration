FROM cakebuild/cake:sdk-8.0-alpine-v5.0.0

# Install Mono and required packages
RUN apk add --no-cache \
    mono \
    mono-dev \
    ca-certificates \
    tzdata \
    icu-libs \
    krb5-libs \
    libgcc \
    libintl \
    libstdc++ \
    zlib \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing

# Set Mono environment variables
ENV MONO_PATH=/usr/lib/mono
ENV PATH="${PATH}:/usr/bin/mono"

# Create symbolic link for mono
RUN ln -s /usr/bin/mono /usr/local/bin/mono

# Verify mono installation
RUN mono --version

ADD .  /src

# ENV TARGET="Default"
# ENV ENVIRONMENT="Sandbox"
# ENV DATABASENAME="RoundHouse"
# ENV USERID="sa"
# ENV PASSWORD="123456x@X"

RUN chmod +x build-roundhouse.sh

CMD ["./build-roundhouse.sh"]