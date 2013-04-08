Pasos para agregar una liga
1-Guardar los archivos de cada temporada obtenidos de la pagina
  www.football-data.co.uk. Para guardar uso el formato 'Letra del pais'+P+Temporada.
  Por ejemplo para Espana (S) la temporada 2012-2013 es SP1213.xlsx
  Espana (S), Inglaterra (E), Alemania (D), Italia (I), Francia (F), Holanda (H), Belgica (B), Portugal (P)
  Turquia (T), Grecia (G)

2-Se obtienen los equipos que jugaron en cada temporada con el script DetectarEquipos.m y luego se crea el
  archivo de todos los equipos que han jugado en esa liga con el script TodosEquipos.m.

3-Luego se separa los datos de todas las temporadas por equipos usando el script SepararPorEquipos.m.

4-Se generan los ejemplos para la red neuronal usando el script generarEjemplos.m

5-Se ejecuta ImplementarNN.m cambiando la carga de datos con los datos generados para cada liga.