#' @keywords internal
"_PACKAGE"

#' @title Datos de ejmplo desde plickers
#' @description
#' Conjunto de datos de ejemplo
#' @format Datos brutos, como se obtienen desde plickers, en esencia en csv, pero con las primeras filas con metadatos que son procesados
#' @source Obtenido desde una cuenta plickers siguiendo las instrucciones siguientes: https://help.plickers.com/hc/en-us/articles/4404834375707-How-to-export-student-results-in-a-datafile
#'
#' @examplesIf interactive()
#' data(plickers_datos_ejemplo)
#' head(plickers_datos_ejemplo)
#' plickers_datos_ejemplo %>% read_plickers()
#' read_plickers(plickers_datos_ejemplo)
#'
#' @export
plickers_datos_ejemplo <- readr::read_file(system.file("data", "plickers_datos_ejemplo.csv", package = "EduToolsR")) %>% paste(collapse="\n")

