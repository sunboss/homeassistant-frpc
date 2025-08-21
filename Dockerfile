# Set the base image
FROM alpine:3.16

# Declare the architecture as an argument
ARG ARCH=amd64

# Install dependencies
RUN apk add --no-cache \
    curl \
    bash \
    ca-certificates

# Download and install FRPC for the specific architecture
RUN curl -L -o /tmp/frpc.tar.gz \
    https://github.com/fatedier/frp/releases/download/v0.48.0/frpc_0.48.0_linux_${ARCH}.tar.gz && \
    tar -xvzf /tmp/frpc.tar.gz -C /tmp && \
    mv /tmp/frpc_*/frpc /usr/local/bin/ && \
    chmod +x /usr/local/bin/frpc && \
    rm -rf /tmp/frpc.tar.gz /tmp/frpc_*

# Add entrypoint for FRPC
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
