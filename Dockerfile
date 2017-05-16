FROM alpine
## Based on this example http://stackoverflow.com/a/40612088/865222
ENV SONAR_SCANNER_VERSION 3.0.3.778-linux

RUN apk add --no-cache wget && \
    wget --no-check-certificate https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip && \
    unzip sonar-scanner-cli-${SONAR_SCANNER_VERSION} && \
    rm sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip && \
    ln -s /sonar-scanner-${SONAR_SCANNER_VERSION}/bin/sonar-scanner /usr/bin/sonar-scanner && \
    apk del wget

COPY sonar-scanner-run.sh /usr/bin/
