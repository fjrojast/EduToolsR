# EduToolsR

<<<<<<< HEAD
=======

>>>>>>> dev
Este repositorio proporciona herramientas útiles que abonan a la construcción de marcos descriptivos como parte del paradigma socioformativo de formación, en donde se integran gradualmente diversas herramientas que favorecen el conocimiento del contexto escolar y comunitario de los estudiantes con los que se trabaja, así como la evaluación formativa como herramienta fundamental que pueden utilizar docentes y educadores en general.

Proporciona además herramientas que facilitan las tareas administrativas de los docentes, siendo hasta el momento la obtención de información a través de la Clave Unica de Registro de Población (CURP) de México, así como las cédulas en PDF que otorgan las autoridades mexicanas y que sirven como identificador para los estudiantes.



## Herramientas para facilitar la investigación educativa

### Unir campos semejantes

Considerando que es perfectamente normal y esperable que la evaluación provenga de distintas fuentes y como consecuencia la información venga en campos o datos que tengan nombres ligeramente diferentes, la función 'edu_join_similar' permite unificar datos que se llaman distinto pero continenen misma información: 'nombre estudiante', 'nombre_estudiante', 'estudiante_nombre' pueden ser transformados rápidamente a 'nombre' mediante esta función.

## Herramientas para potenciar la evaluación formativa integral

### Transformación de Datos desde Plickers

El objetivo principal de esta función es facilitar la evaluación formativa que los docentes realizan al transformar la información en formato csv, exportada desde desde Plickers, -un servicio ampliamente utilizado para realizar evaluaciones y sondeos en el aula mediante códigos QR y el celular del docente-. La función `edu_read_plickers` incluida en este repositorio permite convertir los datos en formato CSV generados por Plickers a una estructura ordenada, siguiendo la filosofía tidy y facilitando así su análisis y visualización.
<<<<<<< HEAD


## Procesamiento de CURP 

=======

## Procesamiento de CURP 
>>>>>>> dev

Dentro de este repositorio, encontrarás funciones especializadas para el procesamiento de la Clave Única de Registro de Población (CURP), ofreciendo diversas utilidades:

### 1. Obtención de Datos a partir de CURP

La función `edu_extract_curp` toma una clave CURP como entrada y devuelve información relevante como la edad, estado de nacimiento y fecha de nacimiento. Adicionalmente permite generar campos para facilitar la combinación de correspondencia.

### 2. Procesamiento Batch de Cédulas CURP en PDF (en proceso)

El repositorio también incluye una función para procesar en lote cédulas CURP en formato PDF. Al especificar la carpeta que contiene los archivos PDF, la función extraerá y organizará la información de cada cédula en una estructura ordenada, alineándose con la estructuración de datos tidy, facilitando su análisis posterior.


[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
