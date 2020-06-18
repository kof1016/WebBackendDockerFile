FROM openjdk:8-jdk
ARG USER_HOME_DIR="/root"

RUN apt-get update && apt-get install -y vim

RUN mkdir -p /usr/share/maven/ref

COPY /maven/ /usr/share/maven

RUN ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
#ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
ENV MAVEN_CONFIG "$USER_HOME_DIR/maven_repo"

ENV JDBC_IP = "127.0.0.1" \
    ENV USER_NAME= "ddd"
ENV PASSWORD="Xixiwoaini520"

#VOLUME ["/usr/src/mymaven", "/root/.m2"]
#VOLUME ["/usr/src/mymaven"]
#VOLUME ["/usr/src/mymaven", "/maven_repo"]
VOLUME ["/usr/src/mymaven", "/root/maven_repo"]
CMD sed -e 's#password:.*#''password: '"$PASSWORD"'#g'\
    '-e''s#username:.*#''username: '"$USER_NAME"'#g'\
    '-e''s#userJdbc:.*#''userJdbc: '"$USER_NAME"'#g'\
    '-e''s#passwordJdbc:.*#''passwordJdbc: '"$PASSWORD"'#g'\
    '-e''s#url:.*#''url: jdbc:sqlserver:\/\/'"$JDBC_IP"';DatabaseName=RYJavaManagerDB''#g'\
    '-e''s#urlJdbc:.*#''url: jdbc:sqlserver:\/\/'"$JDBC_IP"';DatabaseName=RYAccountsDB''#g'\
    '-e''s#IMG_URL:.*#''IMG_URL: http:\/\/'"$JDBC_IP"'\/images\/lord3\/''#g'\
    -i /usr/src/mymaven/src/main/resources/application.yml

