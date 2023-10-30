# Terraform V1

El objetivo de estas tareas es empezar a familiarizarse con la creación de recursos de AWS utilizando Terraform. A medida que se vaya avanzando, se va a ir agregando mayor cantidad de recursos y alentando a realizarlo siguiendo las buenas practicas. 

A su vez, se busca ya trabajar con las mismas herramientas que trabaja el resto del equipo.

## **Brief**

---

Se necesitan crear los recursos de forma que sean fácilmente replicables entre distintos environments, y que se disponga de un historial, y un rollback en caso de ser necesario. Por eso vamos a utilizar Terraform. 

La necesidad por ahora, sera crear una instancia EC2 que este en cualquier VPC que ya exista en Sandbox, la misma que tenga un tag del tipo "Name: onboarding-terrav1" y otro "Owner: TUNOMBRE" de forma que sea fácilmente localizable el owner y para que se creo. 

La instancia tendrá que utilizar una key de ssh previamente creada desde la interfaz web, y tendrá que tener el puerto 22 abierto, la misma podrá estar en una red publica.

## **Tasks**

---

- Crear un EC2 que este en cualquier VPC que ya exista en Sandbox.
- La instancia debe tener dos tags "Name: onboarding-terrav1" y "Owner: TUNOMBRE".
- Deberá utilizar una SSH KEY, previamente creada desde la interfaz web.
- Deberá tener el puerto 22 abierto.
- Subirlo al repositorio de onboarding/onboarding-TUNOMBRE

## **Definition Of Done**

---

- Conectarnos a la instancia por SSH
- Verificar los tags
- Verificar el código en el repositorio
- La solución no tendrá que tener mas de 30 lineas de código (incluidos todos los .tf)