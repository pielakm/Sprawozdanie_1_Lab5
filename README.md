# Sprawozdanie_1_Lab5
Komendy 
Utworzenie obrazu: docker build -f Dockerfile --build-arg BASE_VERSION=3  -t web:spr2 . 
Utworzenie kontenera: docker run -d -p 8096:8080 --name sprawozdanie2 web:spr2
