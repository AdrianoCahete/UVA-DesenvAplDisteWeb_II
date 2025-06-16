FROM tomcat:10-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*

COPY ./src/main/webapp /usr/local/tomcat/webapps/ROOT
COPY ./src/main/java /usr/local/tomcat/src/main/java

RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/classes
RUN javac -cp "/usr/local/tomcat/lib/servlet-api.jar" -d /usr/local/tomcat/webapps/ROOT/WEB-INF/classes /usr/local/tomcat/src/main/java/br/edu/uva/servlets/Calculo.java

EXPOSE 8080
