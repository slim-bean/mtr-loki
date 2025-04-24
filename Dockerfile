# syntax=docker/dockerfile:1.4
FROM --platform=$BUILDPLATFORM alpine:latest AS build

# Install mtr and other required packages
RUN apk add --no-cache mtr

# Create a working directory
WORKDIR /app

# Copy the necessary files
COPY start.sh /app/

# Make the script executable
RUN chmod +x /app/start.sh

# Final stage
FROM --platform=$TARGETPLATFORM alpine:latest

# Install mtr
RUN apk add --no-cache mtr

# Copy files from build stage
COPY --from=build /app/start.sh /app/

WORKDIR /app

# Environment variable for MTR target
ENV MTR_TARGET=8.8.8.8

# Set the entrypoint
ENTRYPOINT ["/app/start.sh"] 