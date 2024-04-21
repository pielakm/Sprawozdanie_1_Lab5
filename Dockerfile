# 1 - działa 
# Etap pierwszy: Budowanie aplikacji
FROM node:alpine AS builder

RUN apk add --update curl && \
rm -rf /var/cache/apk/*

# Argument dla wersji bazowej
ARG BASE_VERSION
# Zmienna środowiskowa dla wersji aplikacji
ENV APP_VERSION=test.${BASE_VERSION:-v3}

# Ustawienie katalogu roboczego
WORKDIR /usr/app

# Kopiowanie plików aplikacji
COPY ./package.json ./

# Instalacja zależności
RUN npm install

# Kopiowanie kodu aplikacji do wewnątrz obrazu
COPY ./index.js ./

# Etap drugi: Tworzenie finalnego obrazu
FROM alpine:latest

# Instalacja Node.js
RUN apk --no-cache add nodejs

# Ustawienie katalogu roboczego
WORKDIR /usr/app

# Kopiowanie plików aplikacji z pierwszego etapu
COPY --from=builder /usr/app .

# Informacja o porcie wewnętrznym kontenera,  na którym "nasłuchuje" aplikacja
EXPOSE 8080
# Ustawienie HEALTHCHECK dla aplikacji
HEALTHCHECK --interval=10s --timeout=1s \
  CMD curl -f http://localhost: || exit 1

# Domyślne polecenie przy starcie kontenera 
CMD ["node", "index.js"]


# 2 - wyświetla się tylko strona startowa nginx (nie wiem dlaczego mi to nie działa), bądź włączał mi się plik index.js w formie tekstu, czystego kodu

# # Etap pierwszy: Budowanie aplikacji
# FROM node:alpine AS builder

# RUN apk add --update curl && \
# rm -rf /var/cache/apk/*

# # Argument dla wersji bazowej
# ARG BASE_VERSION
# # Zmienna środowiskowa dla wersji aplikacji
# ENV APP_VERSION=test.${BASE_VERSION:-v3}
# # # Instalacja Node.js
# RUN apk --no-cache add nodejs

# # Instalowanie Nginx
# RUN apk add  --update nginx && \
# rm -rf /var/cache/apk/*
 
# # Ustawienie katalogu roboczego
# WORKDIR /usr/app

# # Kopiowanie plików aplikacji
# COPY ./package.json ./

# # Instalacja zależności
# RUN npm install 
# # Kopiowanie kodu aplikacji do wewnątrz obrazu
# COPY ./index.js ./

# # Etap drugi: Tworzenie finalnego obrazu
# FROM nginx:latest

# # Kopiowanie plików aplikacji z pierwszego etapu
# COPY --from=builder /usr/app/index.js /usr/share/nginx/html

# # Konfiguracja Nginx do przekazywania żądań do aplikacji Node.js
# COPY nginx.conf /etc/nginx/nginx.conf

# EXPOSE 8080
# # Ustawienie HEALTHCHECK dla aplikacji
# HEALTHCHECK --interval=10s --timeout=1s \
#   CMD curl -f http://localhost:8080/ || exit 1

# # Domyślne polecenie przy starcie kontenera 
# CMD ["nginx", "-g", "daemon off;"]
