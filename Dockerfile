FROM frolvlad/alpine-oraclejdk8:8.161.12-cleaned

ARG WIREMOCK_VERSION=1.0.0

ENV WIREMOCK_VERSION $WIREMOCK_VERSION
ENV DIR_WIREMOCK_BIN "/var/opt/bin"
ENV SERVICE mock
ENV THREADS 5
ENV NEXUS_SERVER "repository.sonatype.org"
ENV EXTENSIONS com.*.*.wiremock.transformer.CutOffDateTransformer,com.*.*.wiremock.transformer.StartDateTransformer

RUN apk add --no-cache --update openssl 'su-exec>=0.2' bash procps

# grab wiremock standalone jar
RUN mkdir -p ${DIR_WIREMOCK_BIN} && \
    wget https://${NEXUS_SERVER}/${WIREMOCK_VERSION}/wiremock-server-${WIREMOCK_VERSION}-jar-with-dependencies.jar \
    -O ${DIR_WIREMOCK_BIN}/wiremock-server.jar

EXPOSE 8080 

CMD exec java -Xmx1900m -jar ${DIR_WIREMOCK_BIN}/wiremock-server.jar --root-dir /repo/mappings/$SERVICE --no-request-journal --container-threads ${THREADS} --extensions ${EXTENSIONS}


