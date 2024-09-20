# Usa o Debian 12 SLIM como base para a construção
FROM debian:12-slim

# Seta as variáveis de ambiente
ENV DEBIAN_FRONTEND=noninteractive

# Instala as dependências OpenJDK17-JDK, Firefox-ESR, e arquivos para o X11
RUN apt-get update && \
    apt-get install -y \
    locales \
    openjdk-17-jdk \
    firefox-esr \
    firefox-esr-l10n-pt-br \
    xdg-utils \
    libx11-6 \
    libxext6 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxtst6 \
    libxcomposite1 \
    libxdamage1 \
    libgtk-3-0 \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configura os locales para o padrão do Brail
RUN echo "pt_BR.UTF-8 UTF-8" > /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=pt_BR.UTF-8

# Define o locale padrão
ENV LANG=pt_BR.UTF-8 \
    LANGUAGE=pt_BR:pt \
    LC_ALL=pt_BR.UTF-8

# Cria a pasta para a aplicação
RUN mkdir -p /app

# Seta a pasta de trabalho
WORKDIR /app

# Comando para rodar o arquivo "jar"
CMD ["java", "-jar", "extensao-buscado-1.0.0-jar-with-dependencies.jar"]
