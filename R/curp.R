#' @title Extraer información a partir de la cédula CURP de México
#' @section Datos en formato tidy:
#' Funciones para reorganizar los datos.
#' @family curp
#' @description
#'
#'
#' Función que cumple 2 objetivos distintos:
#' 1. Extraer información complementaria a partir de la codificación de la clave CURP, de manera que dicha información pueda ser procesada para análisis exploratorio:
#' - Género de la persona a la que se refiere la CURP, en formato corto: H/M o formato largo: Hombre/Mujer
#' - Edad de la persona a la que se refiere la CURP, en formato numérico expresado en años o meses
#' - El estado en el que nació, en representación corta o larga: JC/Jalisco, NE/Nacido en el extranjero
#'
#' 2. Crear campos que pueden ser utilizados para el refinamiento de la combinación de correspondencia. Es común que cuando hay documentos que por ser dirigido a un género indistinto, se escribe por ejemplo Estimado(a), del(la) y así para otras contracciones, artículos o preposiciones.

#'
#' @param curp Especifica la curp desde la cual se van a obtener los datos
#' @param dato_a_obtener Especificar el dato a obtener, dentro de  las siguientes: fecha_nacimiento, genero, genero_largo, edad_anios, edad_meses, combinacion_el_la, combinacion_l_la, combinacion_al_ala, combinacion_del_dela, combinacion_o_a, combinacion_o_a2
#' @param matches_ fecha_calculo_edad. Es un dato opcional y aplica para cuando se requiere cálculos de edades. Si no se especifica, automáticamente realiza el cálculo con relación a la fecha actual de la computadora. Sin embargo hay casos en los que se necesita saber la edad que tenía la persona a la que corresponde la curp, por ejemplo el día primero de septiembre de 2023. En ese caso, se especifica "2023-09-01"
#'
#' @examplesIf interactive()
#'
#' "XAXA791211HNEJJ08" %>% edu_extract_curp("genero") # devuelve "H"
#'
#' "XAXA791211HNEJJ08" %>% edu_extract_curp("genero_largo") # devuelve "Hombre"
#'
#' "XAXA791211HNEJJ08" %>% edu_extract_curp("edad_anios") # devuelve la edad en años, calculados a la fecha de la computadora
#'
#' "XAXA791211HNEJJ08" %>% edu_extract_curp("edad_anios","2021-09-01") # devuelve la edad en años, calculados al 1° de septiembre del 2021
#'
#' "XAXA791211HNEJJ08" %>% edu_extract_curp("edad_meses","2021-09-01") # devuelve la edad en meses,  calculados al 1° de septiembre del 2021
#' "XAXA791211HNEJJ08" %>% edu_extract_curp("edad_meses") # devuelve la edad en meses
#'
#' "XAXA791211HNEJJ08" %>% edu_extract_curp("estado_nacimiento") # devuelve "NE"
#'
#' "XAXA791211HNEJJ08" %>% edu_extract_curp("estado_nacimiento_largo") # devuelve "Nacido en el extranjero"
#'
#' "XAXA791211HNEJJ08" %>% edu_extract_curp("combinacion_el_la") # devuelve "el", aplicable para combinar correspondencia en estos contextos: El niño, la niña
#'
#' "XAXA791211HNEJJ08" %>% edu_extract_curp("combinacion_l_la") # devuelve "l", aplicable para combinar correspondencia en estos contextos: del niño, de la niña
#'
#' "XAXA791211HNEJJ08" %>% edu_extract_curp("combinacion_al_ala") # devuelve "al", aplicable para combinar correspondencia en estos contextos: al niño, a la niña
#'
#' "XAXA791211HNEJJ08" %>% edu_extract_curp("combinacion_del_dela") # devuelve "del", aplicable en estos contextos: del niño, de la niña
#'
#' "XAXA791211HNEJJ08" %>% edu_extract_curp("combinacion_o_a") # devuelve una cadena vacía, aplicable en estos contextos: hablando de un niño, hablando de una niña
#'
#' "XAXA791211MNEJJ08" %>% edu_extract_curp("combinacion_o_a") # devuelve "a", aplicable en estos contextos: hablando de un niño, hablando de una niña
#'
#' "XAXA791211HNEJJ08" %>% edu_extract_curp("combinacion_o_a2") # devuelve "o", aplicable en estos contextos:
#'
#' #También puede ser utilizado dentro de mutate:
#'
#' tibble(curp=c("XAXA791211HNEJJ08","XAXA880304MJCKK33")) %>%    #definimos una tibble de una sola fila y columna
#'    mutate(
#'      edad= curp |> edu_extract_curp("edad_anios"), #calcula la edad poniendo primero la columna curp de la tibble, utilizando el pipe |> (equivalente a %>%) y posteriormente la función en cuestión
#'      estado_nacimiento=  edu_extract_curp(curp,"estado_nacimiento_largo"),
#'      del_dela= curp |> edu_extract_curp("combinacion_del_dela"),
#'      genero= curp |> edu_extract_curp("genero"),
#'      genero2= curp |> edu_extract_curp("genero_largo")
#'
#'    )
#'
#'
#' #'
#' @export


# curp.do()
edu_extract_curp <-  function(curp,dato_a_obtener,fecha_calculo_edad=now()) {
  estados <- read_csv("~/EduToolsR/data/edu_estados_mx.csv",show_col_types = F)
  # readr::read_csv(system.file("data", "edu_estados_mx.csv", package = "EduToolsR"),show_col_types = F)

  # resultado <- curp %>%
  # as_tibble() %>%
  # transmute(
  #   resultado = case_match(
  #     {{ dato_a_obtener }},
  #     "fecha_nacimiento" ~ curp %>% str_sub(5, 10),
  #     "genero" ~ curp %>% str_sub(11, 11),
  #     "genero2" ~ case_match(curp %>% str_sub(11, 11), "H" ~ "Hombre", "M" ~ "Mujer"),
  #     "edad_anios" ~ interval(curp %>% str_sub(5, 10), fecha_calculo_edad) %/% dyears(1) %>% as.character(),
  #     "edad_meses" ~ interval(curp %>% str_sub(5, 10), fecha_calculo_edad) %/% dmonths(1) %>% as.character(),
  #     "combinacion_el_la" ~ case_match(curp %>% str_sub(11, 11), "H" ~ "el", "M" ~ "la"),
  #     "combinacion_l_la" ~ case_match(curp %>% str_sub(11, 11), "H" ~ "l", "M" ~ " la"),
  #     "combinacion_al_ala" ~ case_match(curp %>% str_sub(11, 11), "H" ~ "al", "M" ~ "a la"),
  #     "combinacion_del_dela" ~ case_match(curp %>% str_sub(11, 11), "H" ~ "del", "M" ~ "de la"),
  #     "combinacion_o_a" ~ case_match(curp %>% str_sub(11, 11), "H" ~ "", "M" ~ "a"),
  #     "combinacion_o_a2" ~ case_match(curp %>% str_sub(11, 11), "H" ~ "o", "M" ~ "a"),
  #     "estado_nacimiento" ~ curp %>% str_sub(12, 13),
  #     "estado_nacimiento_largo" ~ left_join(curp %>% str_sub(12, 13) %>% as_tibble(), estados, join_by(value == estado_cod)) %>% pull(estado_nombre)
  #   )
  # ) %>%
  # pull(resultado)





  resultado <- curp %>%
    as_tibble() %>%
    mutate(

        fecha_nacimiento= curp %>% str_sub(5, 10) %>% ymd,
        genero= curp %>% str_sub(11, 11) %>% as_factor(),
        genero_largo= case_match(curp %>% str_sub(11, 11), "H" ~ "Hombre", "M" ~ "Mujer") %>% as_factor,
        edad_anios= interval(curp %>% str_sub(5, 10), fecha_calculo_edad) %/% dyears(1) ,
        edad_meses=interval(curp %>% str_sub(5, 10), fecha_calculo_edad) %/% dmonths(1) ,
        combinacion_el_la= case_match(curp %>% str_sub(11, 11), "H" ~ "el", "M" ~ "la"),
        combinacion_l_la= case_match(curp %>% str_sub(11, 11), "H" ~ "l", "M" ~ " la"),
        combinacion_al_ala= case_match(curp %>% str_sub(11, 11), "H" ~ "al", "M" ~ "a la"),
        combinacion_del_dela= case_match(curp %>% str_sub(11, 11), "H" ~ "del", "M" ~ "de la"),
        combinacion_o_a= case_match(curp %>% str_sub(11, 11), "H" ~ "", "M" ~ "a"),
        combinacion_o_a2= case_match(curp %>% str_sub(11, 11), "H" ~ "o", "M" ~ "a"),
        estado_nacimiento= curp %>% str_sub(12, 13),
        estado_nacimiento_largo= left_join(curp %>% str_sub(12, 13) %>% as_tibble(), estados, join_by(value == estado_cod)) %>% pull(estado_nombre)
    ) %>%
    pull({{dato_a_obtener}})

  return(resultado)

}


