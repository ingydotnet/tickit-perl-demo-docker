FROM termui/tickit-perl-base:0.0.1
COPY build.sh demo /
RUN time sh /build.sh true
CMD [ "bash", "/demo" ]
