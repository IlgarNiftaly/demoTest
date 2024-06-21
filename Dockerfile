# 1. Maven image istifadə edərək, layihəni build etmək üçün
FROM maven:3.8.6-openjdk-11 AS build

# 2. İşçi qovluğu təyin edin
WORKDIR /app

# 3. Layihə fayllarını konteynerə köçürün
COPY pom.xml .
COPY src ./src

# 4. Maven istifadə edərək, layihəni build edin
RUN mvn clean package -DskipTests

# 5. Final image yaratmaq üçün OpenJDK istifadə edin
FROM openjdk:11-jre-slim

# 6. İşçi qovluğu təyin edin
WORKDIR /app

# 7. Yaradılmış JAR faylını build mərhələsindən final image-a köçürün
COPY --from=build /app/target/demoTest-1.0-SNAPSHOT.jar demoTest.jar

# 8. Konteyner start edilərkən JAR faylını işə salın
ENTRYPOINT ["java", "-jar", "demoTest.jar"]
