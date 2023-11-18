#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom dplyr mutate
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
#' @import stringr

## usethis namespace: end


#' @title  Convierte la información exportada desde Plickers a un formato tidy
#' @description
#' Extrae la información que se obtiene en el csv que plickers exporta, para convertirla a una tibble que sigue las convenciones tidy-data
#' se proporciona un ejemplo extraído directamente de plickers para que puedan hacerse pruebas incluso antes de interactuar y generar evaluaciones directamente en plickers.
#' utilizar data("plickers_datos_ejemplo") para poner el contenido del archivo csv en .globalenv.
#' utilizar posteriormente read_plickers(origin=plickers_datos_ejemplo)
#'
#' @usage read_plickers(origin, fecha="2023-01-01")
#' @param origin Selecciona el archivo CSV que proviene de plickers
#' @param fecha fecha formato aaaa-mm-dd, dd-mm-aaaa
#' @returns Devuelve una lista en formato tidy que facilite el análisis
#' @examplesIf interactive()
#' # Ejemplos de uso de la función
#' read_plickers(origin="c:\archivoexportadoporplickers.csv")
#' read_plickers(origin="c:\archivoexportadoporplickers.csv",fecha="2023-01-01")
#' plickers_datos_ejemplo %>% read_plickers()
#' read_plickers(plickers_datos_ejemplo)
#'
#' @export
read_plickers <- function(origin,fecha=lubridate::now()) {
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
    as_vector()#list_simplify
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
    )%>%
    mutate(
      across(where(is.logical), ~ as.numeric(.))
    ) %>%
    select(!all_of(nombres_preguntas)) %>%
    rename_with(~ stringr::str_remove(., "_comprobar"), everything()) %>%
    pivot_longer(cols = 10:ncol(.), names_to = "pregunta", values_to = "resultado") %>%
    bind_cols(fecha_evaluacion = fecha %>% lubridate::as_date()) %>%
    select(names(.) %>% sort()) %>%
    select(tarjeta,apellido,nombre,everything())

  plickers %>% print %>% return()

}






