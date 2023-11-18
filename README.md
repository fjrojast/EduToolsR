# EduToolsR
Este repositorio proporciona herramientas útiles para la evaluación formativa de que pueden utilizar docentes y educadores en general, así como el procesamiento eficiente de datos relacionados con CURP, como parte de las tareas administrativas de centros escolares y cualquir otra instancia que requieran optimizar su gestión.

## Evaluación Formativa de Docentes

### Transformación de Datos desde Plickers

El objetivo principal de este proyecto es facilitar la evaluación formativa que los docentes realizan al transformar la información en formato csv, exportada desde desde Plickers, -un servicio ampliamente utilizado para realizar evaluaciones y sondeos en el aula mediante códigos QR y el celular del docente-. La función `read_plickers` incluida en este repositorio permite convertir los datos en formato CSV generados por Plickers a una estructura ordenada, siguiendo la filosofía tidy y facilitando así su análisis y visualización.

## Procesamiento de CURP

Dentro de este repositorio, encontrarás funciones especializadas para el procesamiento de la Clave Única de Registro de Población (CURP), ofreciendo diversas utilidades:

### 1. Obtención de Datos a partir de CURP

La función `obtener_datos_curp` toma una clave CURP como entrada y devuelve información relevante como la edad, estado de nacimiento y fecha de nacimiento.

### 2. Procesamiento Batch de Cédulas CURP en PDF

El repositorio también incluye una función para procesar en lote cédulas CURP en formato PDF. Al especificar la carpeta que contiene los archivos PDF, la función extraerá y organizará la información de cada cédula en una estructura ordenada, alineándose con la estructuración de datos tidy, facilitando su análisis posterior.

## Requisitos y Uso

Asegúrate de tener instalados los paquetes necesarios mencionados en el archivo `requirements.txt`. Puedes utilizar las funciones proporcionadas ejecutando los scripts correspondientes o integrándolas directamente en tu propio código.





