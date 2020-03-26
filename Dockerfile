FROM websphere-liberty:kernel-java8-openj9-ubi

COPY src/main/liberty/config/server.xml /config/server.xml
COPY src/main/liberty/config/server.env /config/server.env
COPY src/main/liberty/config/jvm.options /config/jvm.options
COPY target/acmeair-authservice-java-3.0.war /config/apps/
COPY key.p12 /output/resources/security/key.p12

USER 0
RUN chown 1001:0 /config/server.xml
RUN chown 1001:0 /config/server.env
RUN chown 1001:0 /config/jvm.options
RUN chown 1001:0 /config/apps/acmeair-authservice-java-3.0.war
RUN chown -R 1001:0 /output/resources
USER 1001

RUN configure.sh || if [ $? -ne 22 ]; then exit $?; fi


