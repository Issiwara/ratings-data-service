FROM maven:3.8.5-ibm-semeru-17-focal as build
COPY . /home/app
WORKDIR /home/app
RUN mvn clean package


FROM openjdk:19-jdk-alpine3.15 as production
EXPOSE 3003:3003
COPY --from=build /home/app/target/ratings-data-service.jar /opt/service/ratings-data-service.jar
WORKDIR /opt/service
ENTRYPOINT ["java","-jar","ratings-data-service.jar"]
