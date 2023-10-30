# Terraform V4

El objetivo de estas tareas es empezar a familiarizarse con la creación de recursos de AWS utilizando Terraform. A medida que se vaya avanzando, se va a ir agregando mayor cantidad de recursos y alentando a realizarlo siguiendo las buenas practicas. 

A su vez, se busca ya trabajar con las mismas herramientas que trabaja el resto del equipo.

## **Brief**

---

Ahora ya estamos comenzando a trabajar usando buenas practicas de Terraform.

En este caso, buscamos replicar los recursos creados en `AWS V2`, pero ahora solamente usando Terraform.

Las instancias tendran que estar en una red privada y se tendra que acceder por session manager.

Como extra, ahora necesitamos que nuestra aplicación se conecte por medio de un parameter store, así que tendremos que crear este recurso con Terraform (leer la documentación que tenemos sobre este punto).

## **Tasks**

---

- Crear un ALB
- Crear 2 EC2.
- Crear un RDS. Tendrá que estar en una red privada y ser accedido por Session Manager.
- Crear un S3 Bucket.
- Crear un REDIS.
- Crear un CloudFront para el S3 Bucket.

## **Definition Of Done**

---

- Crear el parameter store para la DB, y probarlo desde el EC2
- Agregar un user data que instale Nginx y lo levante en el puerto 80
- Con una prueba de carga al sitio, las instancias que escalen automáticamente. Se puede usar el siguiente script:

```bash
#!/bin/bash
while true;
do wget -q -O- URL;
done
```

- Probar que al apagarse una instancia, se regenere automáticamente.
- Verificar que las instancias tengan acceso al Cache de DB. El comando para poder realizarlo es:

```bash
telnet URL port
```

- Verificar que el CDN apunte a las imágenes del bucket. El comando para poder realizarlo es:

```bash
wget -S URL
```

- Verificar que el bucket de S3 no este publico. El comando para poder realizarlo es:

```bash
aws s3api get-bucket-policy-status --bucket NOMBREDELBUCKET
```

- Verificar conectarse a la terminal de las instancias privadas con una consola Linux.