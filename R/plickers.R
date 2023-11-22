#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom dplyr mutate
#' @importFrom dplyr pull
#' @importFrom dplyr left_join
#' @importFrom dplyr case_match
#' @importFrom dplyr join_by
#' @importFrom lubridate interval
#' @importFrom lubridate now
#' @importFrom lubridate dyears
#' @importFrom lubridate dmonths
#' @importFrom tibble as_tibble
#' @importFrom readr read_file
#' @importFrom lubridate ymd
#' @importFrom lubridate dmy
#' @importFrom magrittr %>%
#' @importFrom magrittr %<>%
#' @importFrom forcats as_factor
#' @importFrom dplyr slice
#' @importFrom dplyr rename_with
#' @importFrom dplyr rename
#' @importFrom dplyr bind_cols
#' @importFrom dplyr mutate
#' @importFrom dplyr cur_column
#' @importFrom dplyr relocate
#' @importFrom dplyr rowwise
#' @importFrom tidyr pivot_longer
#' @importFrom tidyr separate_wider_regex
#' @importFrom janitor clean_names
#' @importFrom dplyr select
#' @importFrom dplyr across
#' @importFrom dplyr all_of
#' @importFrom readr read_csv
#' @importFrom purrr as_vector
#' @importFrom tidyr unnest
#' @importFrom dplyr c_across
#' @import stringr

## usethis namespace: end



# Datos ejemplo -----------------------------------------------------------

# ejemplo <- system.file("data", "edu_ejemplo_datos_plickers.csv", package = "EduToolsR")


#' @title Datos de ejemplo desde plickers
#' @description
#' Conjunto de datos de ejemplo
#' @format Datos brutos, como se obtienen desde plickers, en esencia en csv, pero con las primeras filas con metadatos que son procesados
#' @source Obtenido desde una cuenta plickers siguiendo las instrucciones siguientes: https://help.plickers.com/hc/en-us/articles/4404834375707-How-to-export-student-results-in-a-datafile
#'
#' @examplesIf interactive()
#' data(edu_ejemplo_datos_plickers)
#' head(edu_ejemplo_datos_plickers)

#' @export
edu_ejemplo_datos_plickers <- readr::read_file(system.file("data", "edu_ejemplo_datos_plickers.csv", package = "EduToolsR")) %>% as.vector()#%>% paste(collapse="\n")









#' @title  Convierte la información exportada desde Plickers a un formato tidy
#' @description
#' Extrae la información que se obtiene en el csv que plickers exporta, para convertirla a una tibble que sigue las convenciones tidy-data
#' se proporciona un ejemplo extraído directamente de plickers para que puedan hacerse pruebas incluso antes de interactuar y generar evaluaciones directamente en plickers.
#' utilizar data("edu_ejemplo_datos_plickers") para poner el contenido del archivo csv en .globalenv.
#' utilizar posteriormente read_plickers(origin=edu_ejemplo_datos_plickers)
#'
#' @usage read_plickers(origin, fecha="2023-01-01")
#' @section Importar datos:
#' Funciones para transformar datos provenientes de varios servicios de evaluación educativa
#'
#' @param origin Selecciona el archivo CSV que proviene de plickers
#' @param fecha fecha formato aaaa-mm-dd, dd-mm-aaaa
#' @returns Devuelve una lista en formato tidy que facilite el análisis
#' @examplesIf interactive()
#' # Ejemplos de uso de la función
#' edu_ejemplo_datos_plickers |> read_plickers()

#' @export
read_plickers <- function(origin, fecha = lubridate::now()) {

  plickers <- readr::read_csv(origin, col_names = F, show_col_types = F)

  metadatos <- plickers[1, 1] %>%
    tidyr::separate_wider_regex(1, c(curso = "[:graph:]+", "\\s+", fecha_inicio = "\\d+\\/\\d+\\/\\d+", "-", fecha_fin = "\\d+\\/\\d+\\/\\d+"), too_few = "align_start") %>%
    mutate(
      curso = curso %>% forcats::as_factor(),
      fecha_inicio = lubridate::dmy(fecha_inicio),
      fecha_fin = lubridate::dmy(fecha_fin)
    )
  names(plickers) <- plickers %>%
    slice(3) %>%
    as_vector() # list_simplify
  nombres <- plickers %>%
    slice(3) %>%
    clean_names()
  nombres_preguntas <- nombres %>%
    select(7:ncol(.)) %>%
    names()

  preguntas_set <- plickers[4, 7:ncol(plickers)]
  names(preguntas_set) <- stringr::str_c("set_", names(preguntas_set))
  preguntas_url <- plickers[5, 7:ncol(plickers)]
  correctas <- plickers[6, 7:ncol(plickers)] %>%
    clean_names() %>%
    mutate(across(everything(), ~ stringr::str_replace_all(., c("A" = "1", "B" = "2", "C" = "3", "D" = "4"))))

  correctas_paracomprobar <- correctas %>% rename_with(~ stringr::str_c(., "_comprobar"), everything())

  plickers %<>% slice(7:nrow(.)) %>% clean_names()
  plickers %<>%
    mutate(
      score = score %>% stringr::str_remove("%"),
      across(7:ncol(.), ~ stringr::str_replace_all(., c("A" = "1", "B" = "2", "C" = "3", "D" = "4"))),
      across(matches("name"), as_factor),
    ) %>%
    rename(
      correctas = correct,
      contestadas = answered,
      apellido = last_name,
      nombre = first_name,
      tarjeta = card_number,
      puntuacion = score
    )

  plickers <- metadatos %>% bind_cols(plickers, correctas_paracomprobar)


  plickers %<>%
    rowwise() %>%
    mutate(
      across(ends_with("_comprobar"), ~ . == get(stringr::str_remove(cur_column(), "_comprobar$"))),
    ) %>%
    mutate(
      across(where(is.logical), ~ as.numeric(.))
    ) %>%
    select(!all_of(nombres_preguntas)) %>%
    rename_with(~ stringr::str_remove(., "_comprobar"), everything()) %>%
    pivot_longer(cols = 10:ncol(.), names_to = "pregunta", values_to = "resultado") %>%
    bind_cols(fecha_evaluacion = fecha %>% lubridate::as_date()) %>%
    select(names(.) %>% sort()) %>%
    select(tarjeta, apellido, nombre, everything())

  plickers %>%
    print() %>%
    return()
}
