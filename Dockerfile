FROM maven:3.9.7-eclipse-temurin-17 AS build
RUN git clone https://github.com/vm-devops-may24/spring-petclinic.git && \
    cd spring-petclinic/ && \
    mvn clean package

FROM amazoncorretto:17
USER nobody
WORKDIR /spc
COPY --from=build spring-petclinic/target/spring-petclinic-3.3.0-SNAPSHOT.jar /spc/spring-petclinic.jar
CMD [ "java","-jar","spring-petclinic.jar" ]