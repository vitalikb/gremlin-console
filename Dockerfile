FROM tinkerpop/gremlin-console:3.4.9

#Gremlin Client
ADD 70-gremlin /etc/update-motd.d/70-gremlin
RUN wget --quiet -O /opt/gremlin-console/SFSRootCAG2.cer https://www.amazontrust.com/repository/SFSRootCAG2.pem \
&&  wget --quiet -O /opt/gremlin-console/lib/amazon-neptune-gremlin-java-sigv4-2.1.1.jar https://github.com/aws/amazon-neptune-gremlin-java-sigv4/releases/download/v2.1.1/amazon-neptune-gremlin-java-sigv4-2.1.1.jar
# && rm ../apache-tinkerpop-gremlin-console-3.4.8/lib/netty-all-4.1.22.Final.jar

# && mkdir -p certs/cacerts
# && cp $JAVA_HOME/lib/security/cacerts certs/cacerts \
# && keytool -import -alias neptune-tests-ca -keystore certs/cacerts -file /tmp/SFSRootCAG2.cer -noprompt -storepass changeit

ADD neptune-remote.yaml /opt/gremlin-console/conf/neptune-remote.yaml
