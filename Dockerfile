FROM ubuntu:latest AS build

# Lazımi paketləri quraşdırın
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven

# İş qovluğunu təyin edin
WORKDIR /app

# Layihə fayllarını köçürün
COPY . .

# Maven ilə build edin
RUN mvn clean package

# --- Mərhələ 2: Run ---
FROM openjdk:17-jdk-slim

# Portu açın
EXPOSE 8080

# İcranı yerinə yetirin
COPY --from=build /app/target/demo-1.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]