# Proyecto: Tres Contenedores Interconectados - Gestor de Contactos
**Curso:** Sistemas Operativos I - Universidad Mariano Gálvez de Guatemala

## 1. Arquitectura y Diagrama de Red

El proyecto implementa una arquitectura de 3 capas utilizando Docker y Docker Compose, conectadas mediante redes tipo bridge segmentadas y persistencia en volumen.

                       +-----------------------+
                       |   Usuario / Host      |
                       | http://localhost:8080 |
                       +-----------+-----------+
                                   | Puerto 8080:80
                    ===============|=============== Red: frontend (bridge)
                                   v
                       +-----------------------+
                       |     proyecto_web      |
                       |    (nginx:alpine)     |
                       +-----------+-----------+
                                   |
                    ===============|=============== Red: backend (bridge)
                                   | Llamada por nombre: http://api:3000
                                   v
                       +-----------------------+
                       |     proyecto_api      |
                       |   (node:18-alpine)    |
                       +-----------+-----------+
                                   | Llamada por nombre: db:5432
                                   v
                       +-----------------------+
                       |     proyecto_db       |
                       | (postgres:15-alpine)  |
                       +-----------+-----------+
                                   |
                                   v
                          [ Volumen: pgdata ]
                     (/var/lib/postgresql/data)

## 2. Descripción de los Servicios
1. Web (proyecto_web): Servidor Nginx que muestra el formulario HTML/JS y redirige las peticiones hacia http://api:3000/contactos.
2. API (proyecto_api): Backend en Node.js y Express en el puerto 3000 conectado a PostgreSQL mediante el host db.
3. Base de Datos (proyecto_db): PostgreSQL 15 que inicializa la tabla contactos con init.sql y persiste datos en el volumen pgdata.

## 3. Pasos para desplegar el proyecto
1. Entrar al directorio: cd proyecto_so1
2. Levantar los contenedores: sudo docker compose up -d --build
3. Abrir en el navegador: http://localhost:8080

## 4. Comandos de verificación
- Ver contenedores activos: sudo docker ps
- Ver redes: sudo docker network ls
- Ver logs: sudo docker compose logs
- Probar conectividad interna: sudo docker exec -it proyecto_web wget -qO- http://api:3000/contactos
