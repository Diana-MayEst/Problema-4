# El comando en la linea 3 hace referencia a la imagen ofical node.js en su ultima versión (lts)
# Apartir de este comando la imagen permite un entorno de desarrollo para ejecutar archivos node.js
FROM node:lts

# Este comando define el directorio de trabajo dentro del contenedor
# Dentro de este directorio se ejecutan los comandos y los archivos de la aplicación
WORKDIR /usr/src/app

# Este comando copia los archivos package.json y package-lock.json desde nuestra computadora en el directorio de trabajo
COPY package*.json ./

# El siguiente comando se usa para instalar las dependencias del package.json
RUN npm install

# Copia todo el codigo del proyecto (exepto los archivos ignorados)
COPY . .

# Este comando expone el puerto 3000 del contenedor que es donde esta corriendo la aplicación node.js 
EXPOSE 3000

# Se configura Mysql dentro del contenedor 
RUN apt-get update && apt-get install -y mysql-server

# Inicia MySQL en el contenedor 
RUN service mysql start

# Se crea un archivo SQL para configurar la base de datos
COPY ./init.sql /docker-entrypoint-initdb.d/

# Este comando indica que la aplicación node.js se ejucutara una vez arranque el contenedor 
CMD ["npm", "start"]
