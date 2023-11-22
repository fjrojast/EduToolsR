#' @keywords internal
"_PACKAGE"


## usethis namespace: start
#' @importFrom magrittr %>%

#' @import stringr

## usethis namespace: end



# Datos ejemplo -----------------------------------------------------------


#' @title Datos de ejemplo de estudiantes
#' @description
#' Conjunto de datos de ejemplo
#' @format csv
#' @examplesIf interactive()
#' data(listado_estudiantes)
#' head(listado_estudaintes)
#' @export
edu_ejemplo_listado_estudiantes <- readr::read_csv(system.file("data", "edu_ejemplo_listado_estudiantes.csv", package = "EduToolsR"),show_col_types = F)


#' @keywords internal
"_PACKAGE"
#' @title Fusionar columnas con datos afines entre si
#' @section Datos en formato tidy:
#' Funciones para reorganizar los datos.
#' @family pruebas
#' @description
#'
#' Función  que ofrece facilidades para unir datos comunes que provienen de distintas fuentes de datos
#' para que resulten tibbles con columnas unificadas.
#'
#' Cuando se reunen datos por ejemplo de distintas hojas de excel, archivos csv, o algún otro,
#' puede suceder que en un origen la columna de nombre venga #' como 'nombre_alumno', en otra como 'alumno'
#' y en otra como 'alumnos'. Esta función ofrece facilidades para unificar bajo un mismo nombre.
#'
#'
#' @param tibble_procesar especifica la tibble en donde se encuentran las columnas que se desea unir
#' @param nombre especifica el nombre con el que se desee dejar las columnas que serán unidas
#' @param matches_ especifica los nombres de las columnas que desean ser unidas, separadas por un signo |
#'
#' @examplesIf interactive()
#'
#' # Esta es la tibble original
#'
#' edu_ejemplo_listado_estudiantes
#'
#' # Esta es la tibble a la cual se renombraron las columnas nombre_completo, nombre y nombres como una sola: alumno
#'

#' edu_join_similar(e_ejemplo_estudiantes,"alumno","nombre_completo|nombre|nombres")
#'
#' edu_ejemplo_listado_estudiantes |> edu_join_similar("alumno","nombre_completo|nombre|nombres")
#'
#' @export

edu_join_similar <- function(tibble_procesar,nombre,matches_){

  tibble_procesar %>%  #select() %>%
    rowwise() %>%
    mutate(  {{nombre}}  := paste(na.omit(dplyr::c_across(matches(matches_))), collapse = " ")) %>%
    select(-matches(matches_)) %>%
    tidyr::unnest(nombre)
}


