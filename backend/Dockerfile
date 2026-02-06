# Usa uma imagem do maven para build
FROM maven:3.9.9-eclipse-temurin-21 AS build

# Define o diretorio de trabalho no container
WORKDIR /app

# Copia primeiro os arquivos que mudam pouco para aproveitar cache
COPY pom.xml ./
RUN mvn -q -DskipTests dependency:go-offline

# Agora copia o resto do projeto
COPY . ./

# Gera o jar (ignorando os testes)
RUN mvn -DskipTests package

# Usa uma imagem JDK
FROM eclipse-temurin:21-jre

# Define o diretorio de trabalho no contêiner
WORKDIR /app

# Copia o arquivo JAR da aplicacao da imagem de compilacao para a imagem final
COPY --from=build /app/target/*.jar app.jar

# Expoe a porta 8080
EXPOSE 8080

# Comando que inicia a aplicacao quando iniciar o container
ENTRYPOINT ["java", "-jar", "app.jar"]
