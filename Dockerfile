FROM ubuntu:18.04

# Install some basic tools:
RUN apt-get update
RUN apt-get -y install unzip wget

# Install sonar-scanner command line for SonarQube analysis functionality:
RUN wget -O /opt/sonar-scanner-cli-4.3.0.2102-linux.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.3.0.2102-linux.zip

RUN unzip -d /opt/. /opt/sonar-scanner-cli-4.3.0.2102-linux.zip

# Install STM32CubeIDE:
COPY stm32cubeide /opt/stm32cubeide
