FROM ubuntu
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y openjdk-8-jdk git curl tomcat9 maven
RUN curl https://dlcdn.apache.org/jena/binaries/apache-jena-fuseki-4.4.0.tar.gz --output fuseki.tar.gz
RUN tar -xvzf fuseki.tar.gz
RUN git clone https://github.com/dvcama/LodView.git
RUN cd LodView && mvn compile war:war
RUN mkdir /usr/share/tomcat9/webapps && mkdir /usr/share/tomcat9/webapps/ROOT
RUN cp -r LodView/target/lodview/. /usr/share/tomcat9/webapps/ROOT
COPY all.ttl all.ttl
COPY docker/conf.ttl /usr/share/tomcat9/webapps/ROOT/WEB-INF/conf.ttl
COPY docker/run.sh run.sh
RUN mkdir /usr/share/tomcat9/logs && cp -R /usr/share/tomcat9/etc /usr/share/tomcat9/conf
EXPOSE 8080 3030
CMD sh run.sh