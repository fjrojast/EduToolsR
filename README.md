# EduToolsR
Librería que facilita el diagnóstico y evaluación escolar

Este repositorio está dirigido principalmente a docentes, con la intención de brindarles herramientas que suavicen su curva de aprendizaje e implementación de R a su portafolio de herramientas para el análisis de datos relacionados al contexto escolar. Proporciona herramientas útiles que abonan a la construcción de marcos descriptivos como parte del distintos paradigmas, entre ellos el paradigma socioformativo al cual se adhiere la Nueva Escuela Mexicana.

En él estaré integrando gradualmente diversas herramientas que favorecen el conocimiento del contexto escolar y comunitario de los estudiantes con los que se trabaja, así como la evaluación formativa como herramienta fundamental que pueden utilizar docentes y educadores en general.

Proporciona además herramientas que facilitan las tareas administrativas de los docentes, siendo hasta el momento la obtención de información a través de la Clave Unica de Registro de Población (CURP) de México, así como las cédulas en PDF que otorgan las autoridades mexicanas y que sirven como identificador para los estudiantes.

Surge a partir de las necesidades que he detectado como docente del curso Procesamiento de Información Estadística, dentro de la licenciatura en educación primaria y licenciatura en educación preescolar, las cuales han formado parte de los planes de estudio para educación Normal

## Herramientas para facilitar la investigación educativa

### Unir campos semejantes

Considerando que es perfectamente normal y esperable que la evaluación provenga de distintas fuentes y como consecuencia la información venga en campos o datos que tengan nombres ligeramente diferentes, la función 'edu_join_similar' permite unificar datos que se llaman distinto pero continenen misma información: 'nombre estudiante', 'nombre_estudiante', 'estudiante_nombre' pueden ser transformados rápidamente a 'nombre' mediante esta función.

## Herramientas para potenciar la evaluación formativa integral

### Transformación de Datos desde Plickers

El objetivo principal de esta función es facilitar la evaluación formativa que los docentes realizan al transformar la información en formato csv, exportada desde desde Plickers, -un servicio ampliamente utilizado para realizar evaluaciones y sondeos en el aula mediante códigos QR y el celular del docente-. La función `edu_read_plickers` incluida en este repositorio permite convertir los datos en formato CSV generados por Plickers a una estructura ordenada, siguiendo la filosofía tidy y facilitando así su análisis y visualización.

## Procesamiento de CURP

Dentro de este repositorio, encontrarás funciones especializadas para el procesamiento de la Clave Única de Registro de Población (CURP), ofreciendo diversas utilidades:

### 1. Obtención de Datos a partir de CURP

La función `edu_extract_curp` toma una clave CURP como entrada y devuelve información relevante como la edad, estado de nacimiento y fecha de nacimiento. Adicionalmente permite generar campos para facilitar la combinación de correspondencia.

### 2. Procesamiento Batch de Cédulas CURP en PDF (en proceso)

El repositorio también incluye una función para procesar en lote cédulas CURP en formato PDF. Al especificar la carpeta que contiene los archivos PDF, la función extraerá y organizará la información de cada cédula en una estructura ordenada, alineándose con la estructuración de datos tidy, facilitando su análisis posterior.

[Mi perfil en linkedin](https://www.linkedin.com/in/fernandorojasdelatorre/)

[![Project Status: WIP -- Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
