FROM debian:stable as builder

# Update and install download and unzip dependencies.
RUN apt update && apt install wget unzip -y

# Download latest BPT build and unzip.
RUN wget https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/BuildPatchTool.zip
RUN unzip -d ./BuildPatchTool/ BuildPatchTool.zip
RUN rm -f ./BuildPatchTool.zip
RUN find ./BuildPatchTool/ \( -name '*Mac*' -o -name '*Win32' -o -name '*Win64*' \) -exec rm -rf {} +

# ---

FROM debian:stable-slim

# Define labels.
LABEL Maintainer="mrbandler <me@mrbandler.dev>"
LABEL Name="bpt"
LABEL Version="${VERSION}"
LABEL docker.cmd="docker run -it mrbandler/bpt:${VERSION} -mode=UploadBinary -help"

# Update and install dependencies.
RUN apt update && apt install sudo wget xdg-user-dirs -y

# Create new user as BPT expects a non-root user to execute the binary.
# NOTE: The user is allowed to execute sudo commands without password which is
#       necessary for CI/CD applications of the image.
RUN adduser bpt
RUN usermod -aG sudo bpt
RUN echo 'bpt ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
USER bpt

# Change working directory to the newly created user home.
WORKDIR /home/bpt

# Copy downloaded and unzipped BPT from builder.
COPY --from=builder --chown=bpt:bpt /BuildPatchTool ./BuildPatchTool

# Copy executable wrapper script.
RUN mkdir -p ./.local/bin
COPY --chown=bpt:bpt bpt.sh ./.local/bin/bpt
RUN chmod +x ./.local/bin/bpt

# Set all needed environment variables.
ENV PATH="$PATH:/home/bpt/.local/bin"

# Define entrypoint.
COPY --chown=bpt:bpt entrypoint.sh ./.local/bin/entrypoint.sh
RUN chmod +x ./.local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["bpt"]
