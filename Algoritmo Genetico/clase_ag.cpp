/*--------------------------------------------------------------------------------
	Nombre de Archivo: clase_ag.cpp
   	Revision: 1.2
        Fecha: 10Jun2010
   	Autor: Jose Cappelletto

	Implementacion de: clase_ag.hpp
	- Coleccion de clase Cromosoma y AlgoritmoGenetico
	- Operadores de mutacion, seleccion y cruce, manejo automatico de poblaciones
	- Funcion de evaluacion de fitness externa
	- Acceso restringido a propiedades de ambas clases

--------------------------------------------------------------------------------*/

#include "clase_ag.hpp"

/*------------------------------------------------------------------------------
--------------------------------------------------------------------------------
			CLASECromosoma
--------------------------------------------------------------------------------
------------------------------------------------------------------------------*/

int CLASECromosoma::Clonar(CLASECromosoma *copia)
	{
   	if (!iLongitud) return -1;
      if (iLongitud!=copia->iLongitud) //son identicos los contenedores de datos?
		{
      	copia->Borrar(); //libero espacio en copia por diferencia de espacio
         copia->Crear(iLongitud); //redimensiono a mismo tamaño del original
      }
      copia->dFitness = dFitness; //copia del fitness
      memcpy(copia->Cromosoma, Cromosoma, iLongitud); //transferencia de datos, copia exacta
      return iLongitud; //devuelvo tamaño de copia
   }

bool CLASECromosoma::Crear(int cuanto) //elimino si existe anterior, creo cromosoma de tamaño 'n'
	{
   	if (iLongitud) delete Cromosoma; //si el tamaño es no nulo, lo borro
      Cromosoma = new unsigned char[cuanto]; //creo cromosoma de nuevo tamaño
      iLongitud = cuanto; //asigno el tamaño (parametro de entrada)
      dFitness = 0; //fitness inicial igual a cero
      return true;
   }//

//elimina (destruye?) cromosoma
bool CLASECromosoma::Borrar() //elimino si existe anterior
	{
   	if (iLongitud)//si tenia algo, borro
      {
      	delete Cromosoma; //libero memoria
	      dFitness = 0; //fitness igualo a cero
         iLongitud = 0; //hago tamaño igual a cero
         return true;
      }
      else return false; //no habia nada que borrar
   }//

/*operador de mutacion que evalua la probabilidad de mutar cada bit del cromosoma
con probabilidad igual, a lo largo de todo el string*/
int CLASECromosoma::Mutar(float tasa)
	{
	//para mutar bit a bit todo el cromosoma, creo una mascara con 1 y 0 con una tasa de probabilidad dada
	register unsigned long i;
	register unsigned char mascara, c;

	for (i=0; i<iLongitud; i++)
		{
			mascara = 0; //mascara vacia
			c=0x01; //mascara con bit menos significativo (que ire desplazando a la izquierda)
		for (int f=0; f<8; c+=c, f++) //Mascara con probabilidad uniforme a nivel de bits
			{
				if ((float)(rand()%1000)/1000 < tasa) mascara += c;
				//lanzo dado con probabilidad dada por 'tasa', para poner en 1 o 0 el bit 'f' de la mascara
			}
			*(Cromosoma + i) = *(Cromosoma + i) ^ mascara; //aplico la mascara generada para el byte 'i'
		}
	return true;
   }

//operador de mutacion que muta un solo bit de todo el cromosoma
//este operador de mutacion muta 1 solo bit en el byte, con una probabilidad uniforme (pm=1/8)
//el byte a ser mutado tambien es seleccionado aleatoriamente dentro de todo el cromosoma
int CLASECromosoma::Mutar()
	{
      register unsigned char *ap;

      ap = Cromosoma + (rand()%iLongitud);//determino sobre cual byte opero
      *ap = *ap ^ (unsigned char)(1<<(rand()%8)); //mascar con un byte (un solo bit en uno)
    	return 0;
   }



/*------------------------------------------------------------------------------
--------------------------------------------------------------------------------
			CLASEAGenetico
--------------------------------------------------------------------------------
------------------------------------------------------------------------------*/
CLASEAGenetico::CLASEAGenetico() //constructor
      {
      	 dTasaMutacion = AG_MUTACION_DEFAULT; //valor por defecto asignado a la tasa de mutacion
         iTamanoPoblacionA = iTamanoPoblacionB = 0; //poblaciones vacias
         ulEdad = 0; //edad inicial = 0 (esta comenzando)
         usarElitismo = false;
         usarHarem = false;
         fraccionHarem = 0.01; //1% de la poblacion por harem
      }


int CLASEAGenetico::PoblacionLibre()
	{
   	return iTamanoPoblacionA - iTamanoPoblacionB;
	//Devuelve el espacio libre en la poblacion A = diferencia en poblacion A - poblacion B
   }

/*declaracion externa del destructor para eliminar una advertencia de expasion del for (inline)*/
CLASEAGenetico::~CLASEAGenetico() //destructor
   {
	for (int i=0; i<iTamanoPoblacionA; i++)
        	delete PoblacionA[i]; //libero toda la poblacion A

     	for (int i=0; i<iTamanoPoblacionB; i++)
        	delete PoblacionB[i]; //libero toda la poblacion B
   }

//devuelve la edad de la poblacion
unsigned long CLASEAGenetico::Edad()
	{
   	return ulEdad;
   }

//devuelve el numero de puntos de cruce
int CLASEAGenetico::PuntosCruce(){
    return iPuntosCruce;
    }

//asigna (tras validar) el numero de puntos de cruce
int CLASEAGenetico::PuntosCruce(unsigned int n){
    if (n<1) n = 1;
    iPuntosCruce = n;
    return iPuntosCruce;
    }
//devuelve el fitness del mejor individuo de la poblacion
float CLASEAGenetico::MayorFitness()
	{
		return SeleccionarMejor()->dFitness;
   }

//fn que vincula con fn de evaluacion de cromosoma
int CLASEAGenetico::FuncionEvaluacion(float (* fn)(unsigned char *))
	{
   	fnEvaluarCromosoma = fn;
      return 0;
   }

void CLASEAGenetico::PoblacionAleatoria(int ini, int lon)
	{
		if (iTamanoPoblacionA) //si la poblacion inicialmente es no nula (ya habia sido reservada antes)
      	for (int i=0; i<iTamanoPoblacionA; i++)
         	delete PoblacionA[i]; //libero cada uno de los individuos

		if (iTamanoPoblacionB) //igual manera opero sobre la poblacion B
      	for (int i=0; i<iTamanoPoblacionB; i++)
         	delete PoblacionB[i]; //libero cada uno de los individuos
    //si habia alguna poblacion anteriormente, la elimino
   	iTamanoPoblacionB = iTamanoPoblacionA = 0; //esta todo vacio

   	for (int i=0;i<ini;i++)
      {
			PoblacionB[iTamanoPoblacionB] = new CLASECromosoma; // creo un nuevo cromosoma en poblacion B, no importa el contenido
			PoblacionB[iTamanoPoblacionB]->Crear(lon); //de longitud dada, para reserva de espacio necesario en copias
			iTamanoPoblacionB++; //incremento contador de individuos (tamaño de la poblacion)

			PoblacionA[iTamanoPoblacionA] = new CLASECromosoma; // creo un nuevo cromosoma
			PoblacionA[iTamanoPoblacionA]->Crear(lon); //de longitud dada
			PoblacionA[iTamanoPoblacionA]->Mutar((float)(rand()%1000)/1000); //con datos aleatorios, por operador de mutacion
			PoblacionA[iTamanoPoblacionA]->dFitness = 0;//no valen nada
            iTamanoPoblacionA++; //incremento poblacion*/
      }
      ulEdad = 0; //Edad de la poblacion actual = 0 (acabo de crearla toda nueva)
   }

//inserta un individuo ap en la poblacion B, si hay espacio
int CLASEAGenetico::InsertarPoblacionB (CLASECromosoma *ap){
    if (iTamanoPoblacionA <= iTamanoPoblacionB) return -1; //no hay mas espacio
    ap->Clonar(PoblacionB[iTamanoPoblacionB]); //hago una copia exacta del individuo en la poblacion
    return iTamanoPoblacionB++; //devuelvo donde lo almaceno
    }

/* Play a la poblacion */
int CLASEAGenetico::Generacion(){
      CLASECromosoma *ap, clonA, clonB, *elite;
      int i;
      iTamanoPoblacionB = 0; //nadie en la poblacion de respaldo (vacia)

      /**********************ELITISMO************************/
      //veo si esta activado el flag de elitismo
      //en elitismo se escoje el mejor individuo y se inserta directamente en la poblacion final (hijos)
      if (usarElitismo==true){
          //selecciono al mejor individuo de la poblacion
          elite = SeleccionarMejor(); //obtengo apuntador al mejor de la poblacion
          elite->Clonar(&clonA); //saco una copia del mejor, para no afectar al original. Uso la funcion 'Clonar'
          InsertarPoblacionB(&clonA); //lo coloco directo en la poblacion B (poblacion nueva)
      }
      /*******************************************************/

      /**********************HAREM************************/
      //veo si esta activado el flag de harem
      //Harem: agarra el mejor individuo y lo cruza con parte de la poblacion inicial hasta llenar una fraccion de la poblacion final
      if (usarHarem==true){
          //selecciono al mejor individuo de la poblacion
          elite = SeleccionarMejor(); //obtengo apuntador al mejor de la poblacion
          elite->Clonar(&clonA); //saco una copia del mejor, para no afectar al original. Uso la funcion 'Clonar'
          //determino la porcion de la poblacion que sera llenada mediante el cruce del elite con el resto de la poblacion
          int fraccion = (int) fraccionHarem  * iTamanoPoblacionA;
          for (i=0; i<iTamanoPoblacionA/5;i++){
              elite->Clonar(&clonA); //clonA <- copia(elite)
              SeleccionarTournament()->Clonar(&clonB); //clonB <- copia(otro)
              CruzarN(&clonA, &clonB, iPuntosCruce); //lo cruzo en 'N' puntos de cruce
              clonA.Mutar(); //muto cada uno de los descendientes
			  clonB.Mutar();
              InsertarPoblacionB(&clonA); //los inserto en la poblacion nueva
              InsertarPoblacionB(&clonB);
              }
      }
      /****************************************************/

	while (PoblacionLibre()>0){ //mientras haya espacio libre para mas individuos...
	      //ahora procedo al proceso de seleccion segun criterio, por simplicidad esta implementacion usa seleccion tournament
   	   ap = SeleccionarTournament(); //veo ganador de seleccion por fitness,
		ap->Clonar(&clonA);
   	   ap = SeleccionarTournament(); //veo ganador de seleccion por fitness,
		ap->Clonar(&clonB);

   	   //ahora cruzo los dos clones
	      CruzarN(&clonA, &clonB, iPuntosCruce);
      	//ahora debo insertar una copia de los clones en la poblacionB

			//pero antes muto los hijos
      	clonA.Mutar(dTasaMutacion);
         clonB.Mutar(dTasaMutacion);
   		//luego inserto duplicado en la poblacion B, hasta donde quepa
        //de los dos hijos, calculo el nuvo fitness y escojo el mejor
        clonA.dFitness = (*fnEvaluarCromosoma)(clonA.Cromosoma);
        clonB.dFitness = (*fnEvaluarCromosoma)(clonB.Cromosoma);
        if (clonA.dFitness > clonB.dFitness) InsertarPoblacionB(&clonA);
        else	InsertarPoblacionB(&clonB);
    }//*/
    ulEdad++; //incremento edad de la poblacion
    //luego actualizo la poblacion A, reemplazandola por los individuos de la poblacion B
    ActualizarPoblacion();
	//hay que calcular el nuevo fitness de los cromosomas insertados en la poblacion A
    for (i=0;i<iTamanoPoblacionA;i++)
      	PoblacionA[i]->dFitness = (*fnEvaluarCromosoma)(PoblacionA[i]->Cromosoma);
	return 0;
    }

/*Migra todos los ejemplares de la poblacion B a la poblacion A*/
void CLASEAGenetico::ActualizarPoblacion()
	{
   	for (int i=0; i<iTamanoPoblacionB; i++)
			memcpy(PoblacionA[i]->Cromosoma,PoblacionB[i]->Cromosoma,PoblacionB[i]->iLongitud); //a<--b

      // reemplazo el string del cromosoma, asi reduzco solicitud de espacio dinamicamente
      // a solo los casos donde se reinicia poblacion o se crea una poblacion nueva

      iTamanoPoblacionA = iTamanoPoblacionB; //todos
      iTamanoPoblacionB = 0; //nadie
   }


/*Operador de cruce entre dos cromosomas, con numero de puntos de cruce por parametro*/
int CLASEAGenetico::CruzarN(CLASECromosoma *a,CLASECromosoma *b, int n)
	{
		//implementacion actual efectua cruce sobre todos los byte del string que contiene cada cromosoma
		//recibo el apuntador a los dos padres, debo generar dos hijos, e insertarlos en la poblacion b
      //primero creo la mascara de cruce con 'n' puntos de cruce
      //una opcion es a partir de 'n', obtener la probabilidad de cruce sobre cada byte/bit

      unsigned char *mascara;
      int longitud = a->iLongitud; //asumo dos cromosomas de igual longitud
      int i,donde;

      if (longitud<=0) return -1; //no hay nada que cruzar

      mascara = new unsigned char [longitud]; //mascara de igual longitud que cromosoma
      //creo una mascara vacia
      for (i=0; i<longitud; i++)
      	*(mascara + i) = 0xFF;

      //ahora, procedo a la construccion de la mascara en base a 'n' puntos de cruce
      for (i=0; i<n; i++)
      {
      	donde = rand()%longitud; //el punto de cruce lo selecciono aleatoriamente a lo largo de toda la longitud del cromosoma
         *(mascara + donde) = 0xFF<<rand()%7; //mascara del punto de cruce WARNING IRRELEVANTE
         for (i=donde+1;i<longitud;i++)
         	*(mascara + i) = ~*(mascara + i); //cambio los bits del resto de la mascara
      }
      //por ultimo, obtengo los dos hijos a partir de operacion con la mascara

      CLASECromosoma cA,cB;

      cA.Crear(longitud);      cB.Crear(longitud); //reservo espacio

      for (i=0; i<longitud; i++) //creo dos cromosomas nuevos
      {
			//WARNING de perdida de datos
			*(cA.Cromosoma + i) = (*(a->Cromosoma + i) & *(mascara + i)) | (*(b->Cromosoma + i) & ~*(mascara + i));
			*(cB.Cromosoma + i) = (*(b->Cromosoma + i) & *(mascara + i)) | (*(a->Cromosoma + i) & ~*(mascara + i));
      }
		memcpy (a->Cromosoma, cA.Cromosoma, longitud);
		memcpy (b->Cromosoma, cB.Cromosoma, longitud); //escribo en espacio de memoria reservado en poblacion creada

		cA.Borrar();		cB.Borrar(); //libero espacio reservado por cromosomas temporales
      delete mascara; //libero espacio reservado para la mascara
    	return longitud;
   }

/*	Cruce de un punto */
int CLASEAGenetico::Cruzar(CLASECromosoma *a, CLASECromosoma *b)
	{
		return CruzarN (a,b,1); //version simple de cruce, en un solo punto del cromosoma (llama a CruzarN)
   }

//devuelve ap de mejor individuo de dos seleccionados aleatoriamente
CLASECromosoma *CLASEAGenetico::SeleccionarTournament()
	{
   	int i,j;
      i = rand()%iTamanoPoblacionA; //escojo dos individuos aleatoriamente con la misma probabilidad
      j = rand()%iTamanoPoblacionA;
      if (PoblacionA[i]->dFitness > PoblacionA[j]->dFitness) 	return PoblacionA[i];
      else return PoblacionA[j]; //devuelvo apuntador de mejor de los dos cromosomas evaluados
   }

/*
	Funcion de computo de fitness promedio de toda la poblacion A
*/
float CLASEAGenetico::Fitness()
	{
		float acumulado=0;

      if (!iTamanoPoblacionA) return 0; //nada de nada
   	for (int i=0; i<iTamanoPoblacionA; i++)
      	acumulado += PoblacionA[i]->dFitness; //incremento acumulador

      return acumulado/iTamanoPoblacionA; //devuelvo el promedio de todos los fitness
   }


//devuelve ap al mejor ejemplar de la poblacion
CLASECromosoma *CLASEAGenetico::SeleccionarMejor()
	{
		if (!iTamanoPoblacionA) return NULL;

   	float max = PoblacionA[0]->dFitness; //pos '0'
      int cual = 0;
      for (int i=0; i<iTamanoPoblacionA; i++)
      	if (PoblacionA[i]->dFitness > max) //es mejor que el actual? 'cual'
         {
         	max = PoblacionA[i]->dFitness; //reasigno nuevo valor de maximo
            cual = i;
         }
		return PoblacionA[cual];
   }

//devuelve ap de peor ejemplar de la poblacion
CLASECromosoma *CLASEAGenetico::SeleccionarPeor()
	{
		if (!iTamanoPoblacionA) return NULL;

   	float min = PoblacionA[0]->dFitness; //pos '0'
      int cual = 0;
      for (int i=0; i<iTamanoPoblacionA; i++)
      	if (PoblacionA[i]->dFitness < min)
         {
         	min = PoblacionA[i]->dFitness; //reasigno nuevo valor de minimo
            cual = i;
         }
		return PoblacionA[cual]; //devuelve el apuntador al peor especimen
   }

