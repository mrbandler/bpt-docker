FROM debian:stable-slim as builder

# Update and install dependencies.
RUN apt update && apt install wget unzip xdg-user-dirs -y

# Create non root user and use it.
RUN adduser bpt
USER bpt
WORKDIR /home/bpt

# Download latest BPT build and unzip.
RUN wget https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/BuildPatchTool.zip
RUN unzip -d ./BuildPatchTool/ BuildPatchTool.zip
RUN rm -f ./BuildPatchTool.zip
RUN find ./BuildPatchTool/ \( -name '*Mac*' -o -name '*Win32' -o -name '*Win64*' \) -exec rm -rf {} +

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
