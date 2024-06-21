FROM openjdk:17-jdk-slim

WORKDIR /app
COPY . /app

RUN apt-get update && apt-get install -y maven
RUN mvn clean package

RUN apt-get update && apt-get install -y wget
RUN wget https://downloads.apache.org/tomcat/tomcat-10/v10.0.10/bin/apache-tomcat-10.0.10.tar.gz
RUN tar xzvf apache-tomcat-10.0.10.tar.gz -C /usr/local
RUN mv /usr/local/apache-tomcat-10.0.10 /usr/local/tomcat
RUN rm apache-tomcat-10.0.10.tar.gz

COPY target/your-app.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
