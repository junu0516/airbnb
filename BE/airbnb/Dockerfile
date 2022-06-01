FROM openjdk:11-jdk
COPY ./BE/airbnb/build/libs/*.jar airbnb.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=$profile", "/airbnb.jar"]
