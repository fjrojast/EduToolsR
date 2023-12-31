% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/curp.R
\name{edu_extract_curp}
\alias{edu_extract_curp}
\title{Extraer información a partir de la cédula CURP de México}
\usage{
edu_extract_curp(curp, dato_a_obtener, fecha_calculo_edad = now())
}
\arguments{
\item{curp}{Especifica la curp desde la cual se van a obtener los datos}

\item{dato_a_obtener}{Especificar el dato a obtener, dentro de  las siguientes: estado_nacimiento, estado_nacimiento_largo, fecha_nacimiento, genero, genero_largo, edad_anios, edad_meses, combinacion_el_la, combinacion_l_la, combinacion_al_ala, combinacion_del_dela, combinacion_o_a, combinacion_o_a2}

\item{matches_}{fecha_calculo_edad. Es un dato opcional y aplica para cuando se requiere cálculos de edades. Si no se especifica, automáticamente realiza el cálculo con relación a la fecha actual de la computadora. Sin embargo hay casos en los que se necesita saber la edad que tenía la persona a la que corresponde la curp, por ejemplo el día primero de septiembre de 2023. En ese caso, se especifica "2023-09-01"}
}
\description{
Función que cumple 2 objetivos distintos:
\enumerate{
\item Extraer información complementaria a partir de la codificación de la clave CURP, de manera que dicha información pueda ser procesada para análisis exploratorio:
}
\itemize{
\item Género de la persona a la que se refiere la CURP, en formato corto: H/M o formato largo: Hombre/Mujer
\item Edad de la persona a la que se refiere la CURP, en formato numérico expresado en años o meses
\item El estado en el que nació, en representación corta o larga: JC/Jalisco, NE/Nacido en el extranjero
}
\enumerate{
\item Crear campos que pueden ser utilizados para el refinamiento de la combinación de correspondencia. Es común que cuando hay documentos que por ser dirigido a un género indistinto, se escribe por ejemplo Estimado(a), del(la) y así para otras contracciones, artículos o preposiciones.
}
}
\section{Datos en formato tidy}{

Funciones para reorganizar los datos.
}

\examples{
\dontshow{if (interactive()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}

"XAXA791211HNEJJ08" \%>\% edu_extract_curp("genero") # devuelve "H"

"XAXA791211HNEJJ08" \%>\% edu_extract_curp("genero_largo") # devuelve "Hombre"

"XAXA791211HNEJJ08" \%>\% edu_extract_curp("edad_anios") # devuelve la edad en años, calculados a la fecha de la computadora

"XAXA791211HNEJJ08" \%>\% edu_extract_curp("edad_anios","2021-09-01") # devuelve la edad en años, calculados al 1° de septiembre del 2021

"XAXA791211HNEJJ08" \%>\% edu_extract_curp("edad_meses","2021-09-01") # devuelve la edad en meses,  calculados al 1° de septiembre del 2021
"XAXA791211HNEJJ08" \%>\% edu_extract_curp("edad_meses") # devuelve la edad en meses

"XAXA791211HNEJJ08" \%>\% edu_extract_curp("estado_nacimiento") # devuelve "NE"

"XAXA791211HNEJJ08" \%>\% edu_extract_curp("estado_nacimiento_largo") # devuelve "Nacido en el extranjero"

"XAXA791211HNEJJ08" \%>\% edu_extract_curp("combinacion_el_la") # devuelve "el", aplicable para combinar correspondencia en estos contextos: El niño, la niña

"XAXA791211HNEJJ08" \%>\% edu_extract_curp("combinacion_l_la") # devuelve "l", aplicable para combinar correspondencia en estos contextos: del niño, de la niña

"XAXA791211HNEJJ08" \%>\% edu_extract_curp("combinacion_al_ala") # devuelve "al", aplicable para combinar correspondencia en estos contextos: al niño, a la niña

"XAXA791211HNEJJ08" \%>\% edu_extract_curp("combinacion_del_dela") # devuelve "del", aplicable en estos contextos: del niño, de la niña

"XAXA791211HNEJJ08" \%>\% edu_extract_curp("combinacion_o_a") # devuelve una cadena vacía, aplicable en estos contextos: hablando de un niño, hablando de una niña

"XAXA791211MNEJJ08" \%>\% edu_extract_curp("combinacion_o_a") # devuelve "a", aplicable en estos contextos: hablando de un niño, hablando de una niña

"XAXA791211HNEJJ08" \%>\% edu_extract_curp("combinacion_o_a2") # devuelve "o", aplicable en estos contextos:

#También puede ser utilizado dentro de mutate:

tibble(curp=c("XAXA791211HNEJJ08","XAXA880304MJCKK33")) \%>\%    #definimos una tibble de una sola fila y columna
   mutate(
     edad= curp |> edu_extract_curp("edad_anios"), #calcula la edad poniendo primero la columna curp de la tibble, utilizando el pipe |> (equivalente a \%>\%) y posteriormente la función en cuestión
     estado_nacimiento=  edu_extract_curp(curp,"estado_nacimiento_largo"),
     del_dela= curp |> edu_extract_curp("combinacion_del_dela"),
     genero= curp |> edu_extract_curp("genero"),
     genero2= curp |> edu_extract_curp("genero_largo")

   )


#'
\dontshow{\}) # examplesIf}
}
\concept{curp}
