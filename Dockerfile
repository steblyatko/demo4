FROM tomcat:8-jdk8-adoptopenjdk-openj9

ADD ./postgresql-42.2.0.jre6.jar /usr/local/tomcat/lib

WORKDIR /usr/local/tomcat/webapps
