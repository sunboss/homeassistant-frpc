# Set the base image
FROM alpine:3.16

# Install dependencies
RUN apk add --no-cache     curl     bash     ca-certificates

# Download and install FRPC
RUN curl -L -o /usr/local/bin/frpc https://github.com/fatedier/frp/releases/download/v0.48.0/frpc_0.48.0_linux_amd64.tar.gz &&     tar -xvzf /usr/local/bin/frpc -C /usr/local/bin/ &&     chmod +x /usr/local/bin/frpc

# Add entrypoint for FRPC
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]