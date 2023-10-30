# Terraform V2

El objetivo de estas tareas es empezar a familiarizarse con la creación de recursos de AWS utilizando Terraform. A medida que se vaya avanzando, se va a ir agregando mayor cantidad de recursos y alentando a realizarlo siguiendo las buenas practicas. 

A su vez, se busca ya trabajar con las mismas herramientas que trabaja el resto del equipo.

## **Brief**

---

El entorno se valido y fue óptimo, ahora se necesitaran crear algunos recursos extras que ya hemos creado anteriormente en AWS. Para esto agregaremos la base de datos, una instancia mas (la instancia podrá estar en una red privada), y un bucket.

## **Tasks**

---

- Crear un EC2 que este en cualquier VPC que ya exista en Sandbox.
- Los recursos deben tener dos tags "Name: onboarding-terrav2" y "Owner: TUNOMBRE".
- Deberá utilizar una SSH KEY, previamente creada desde la interfaz web.
- Deberá tener el puerto 22 abierto.
- Crear un RDS y su Security Group.
- Crear un S3 Bucket y su Policy.
- Realizarlo en la menor cantidad de codigo posible.
- Subirlo al repositorio de onboarding/onboarding-TUNOMBRE
- No subir los directorios .terraform*, ni los terraform.state*.

## **Definition Of Done**

---

- Verificar que desde el EC2 se llegue al RDS.
- Verificar que desde el EC2 se llegue al Bucket.
- Verificar los tags en cada recurso.
- Verificar el código en el repositorio.