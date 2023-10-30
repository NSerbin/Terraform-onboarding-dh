# Terraform V3

El objetivo de estas tareas es empezar a familiarizarse con la creación de recursos de AWS utilizando Terraform. A medida que se vaya avanzando, se va a ir agregando mayor cantidad de recursos y alentando a realizarlo siguiendo las buenas practicas. 

A su vez, se busca ya trabajar con las mismas herramientas que trabaja el resto del equipo.

## **Brief**

---

Se ha validado el código pasado, y aunque es funcional, hay muchas mejoras posibles si pensamos en un ambiente que sera productivo, y que tendrá que replicarse fácilmente. A la vez de seguir la nomenclatura de la empresa.

Por otra lado, la información del tfstate esta local, lo que no nos permite trabajar en equipo de forma dinámica (ya que si uno realiza un cambio en su maquina, no aplicaría instantáneamente en el git), por eso tendríamos que pasar a usar un bucket de S3 para guardar esa información, y para evitar problemas de lockeo cuando hacemos un apply/destroy, también usar una tabla de DynamoDB para que guarde el lock.

El código en este caso, tendrá que ser validado antes de escribirse en la rama main, y se tendrá que generar el MR necesario, de ahora en mas, la rama Master tendrá que estar bloqueada para asegurarnos de no causar problemas productivos.

## **Tasks**

---

- Usar variables para todos los valores posibles.
- Verificar identación. El comando para poder realizarlo verificar es:

```bash
terraform fmt
```

- Generar output con el ID de los EC2 y las IPS.
- Usar la nomenclatura de la empresa.

```bash
vertical: obn
squad: devops
project: TUNOMBRE
stage: sbx
```

- Las policies tendrán que estar en archivos separados, en un directorio "template" usando interpolación.
- El tfstate tendrá que estar en un bucket, y el lock en una tabla DynamoDB.
- Los cambios se subirán en una branch, y se tendrá que hacer el MR a master esperando approves.

## **Definition Of Done**

---

- Verificar que desde el EC2 se llegue al RDS.
- Verificar que desde el EC2 se llegue al Bucket.
- Verificar los tags en cada recurso.
- Verificar el código en el repositorio.
- Verificar que el código pase el approve en el MR.