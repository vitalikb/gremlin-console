FROM tinkerpop/gremlin-console:3.4.8

#Gremlin Client
ADD 70-gremlin /etc/update-motd.d/70-gremlin
ADD dependency/* /opt/gremlin-console/lib/
ADD amazon-neptune-gremlin-java-sigv4-2.1.1.jar /opt/gremlin-console/lib/amazon-neptune-gremlin-java-sigv4-2.1.1.jar
# wget --quiet -O /opt/gremlin-console/lib/amazon-neptune-gremlin-java-sigv4-2.1.1.jar https://github.com/aws/amazon-neptune-gremlin-java-sigv4/releases/download/v2.1.1/amazon-neptune-gremlin-java-sigv4-2.1.1.jar \
RUN wget --quiet -O /opt/gremlin-console/SFSRootCAG2.cer https://www.amazontrust.com/repository/SFSRootCAG2.pem \
&& mkdir -p /home/gremlin/certs \
&& cp $JAVA_HOME/lib/security/cacerts /home/gremlin/certs/cacerts
ADD neptune-remote.yaml /opt/gremlin-console/neptune-remote.yaml

USER root
RUN keytool -import -alias neptune-tests-ca -keystore /home/gremlin/certs/cacerts -file /opt/gremlin-console/SFSRootCAG2.cer -noprompt -storepass changeit
RUN chmod ug+w /opt/gremlin-console/neptune-remote.yaml && chown gremlin:gremlin /opt/gremlin-console/neptune-remote.yaml
USER gremlin
