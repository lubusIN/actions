FROM debian:stable-slim

LABEL version="1.0.0"
LABEL repository="http://github.com/lubusIN/actions/wordpress"
LABEL homepage="http://github.com/lusbuIN/actions/wordpress"
LABEL maintainer="lubusIN <info@lubus.in>"
LABEL "com.github.actions.name"="WordPress"
LABEL "com.github.actions.description"="Publish to wordpress.org repository"
LABEL "com.github.actions.icon"="cloud"
LABEL "com.github.actions.color"="blue"

RUN apt-get update
RUN apt-get install -y subversion
RUN apt-get install -y unzip
RUN	apt-get clean -y
RUN rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
