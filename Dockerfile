FROM maven:3.9.7-eclipse-temurin-17 AS build
RUN git clone https://github.com/vm-devops-may24/spring-petclinic.git && \
    cd spring-petclinic/ && \
    mvn clean package   

FROM amazoncorretto:17-alpine-jdk
RUN mkdir /spc && chown nobody /spc
USER nobody
COPY --from=build --chown=nobody:nobody /target/spring-petclinic-3.3.0-SNAPSHOT.jar /spc/spring-petclinic.jar
WORKDIR /spc
EXPOSE 8080
CMD [ "java","-jar","spring-petclinic.jar" ]
