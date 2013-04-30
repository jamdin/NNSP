Pasos para agregar una liga

1-Guardar los archivos de cada temporada obtenidos de la pagina
  www.football-data.co.uk. Para guardar uso el formato 'Letra del pais'+P+Temporada.
  Por ejemplo para Espana (S) la temporada 2012-2013 es SP1213.xlsx
  Espana (S), Inglaterra (E), Alemania (D), Italia (I), Francia (F)

2-Se obtienen los equipos que jugaron en cada temporada con el script DetectarEquipos.m y luego se crea el
  archivo de todos los equipos que han jugado en esa liga con el script TodosEquipos.m.

3-Luego se separa los datos de todas las temporadas por equipos usando el script SepararPorEquipos.m.

4-Se generan los ejemplos para la red neuronal usando el script generarEjemplos.m

5-Se ejecuta ImplementarNN.m cambiando la carga de datos con los datos generados para cada liga.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Pasos para predecir Resultados y Apuestas

1-Guardar en un archivo de excel los datos de la jornada por liga, i.e
	EquipoLoc1		EquipoVis1		PagaLocal1	PagaDraw1	PagaVis1
	EquipoLoc2		EquipoVis2		PagaLocal2	PagaDraw2	PagaVis2
	  ...			   ...			  ...		  ...		  ...

2-Generar las predicciones usando las Redes Neuronales. Se abre el script datosPartidosAG.m y se selecciona
  la liga ('Espana','Inglaterra', etc.) y la jornada que se quiere predecir ('121331','121332',etc.).
  Se configura el archivo de texto de entrada con el archivo guardado y la salida con la variable 'dir'.
  Se repite esto para todas las ligas.

3-Luego de tener los archivos de texto con las predicciones de todas las ligas, se abre el algoritmo genetico
  NNSP_AGCombinacion2rondas.cpp. Se cambian los archivos que se van a leer con los generados por la red. Se corre
  el algoritmo que genera un archivo .txt con todos los partidos seleccionados en cada una de las corridas y sus
  respectivas apuestas.

4-Se carga el archivo generado en el script calcularApuestas.m lo cual genera (redondeando al % mas cercano) las
  apuestas por partido.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Pasos para actualizar la base de datos

1-Bajar los datos actualizados de cada liga de la pagina www.football-data.co.uk y se sustituyen por el correspondiente
  en cada liga.
2-Se corre el script actualizarDatos.m con entrada el nombre de la liga ('Espana','Inglaterra','Alemania',etc.).