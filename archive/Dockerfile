FROM debian:stable-slim

LABEL "maintainer"="Ajit Bohra <ajit@lubus.in>"
LABEL "repository"="https://github.com/ajitbohra/github-actions-playground"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="Archive"
LABEL "com.github.actions.description"="Create zip archive"
LABEL "com.github.actions.icon"="archive"
LABEL "com.github.actions.color"="purple"

RUN apt-get update && apt-get install -y zip
RUN	apt-get clean -y
RUN rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
