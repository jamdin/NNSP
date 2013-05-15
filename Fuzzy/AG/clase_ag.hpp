/*--------------------------------------------------------------------------------
	Nombre de Archivo: clase_ag.hpp
	Revision: 1.2 @ 10 Junio 2010
	Autor: Jose Cappelletto
	Inicio: 20 Mayo 2005

	- Coleccion de clase Cromosoma y AlgoritmoGenetico
   	- Operadores de mutacion, seleccion y cruce, manejo automatico de poblaciones
	- Funcion de evaluacion de fitness externa
	- Acceso restringido a propiedades de ambas clases

--------------------------------------------------------------------------------*/
/********************************************************************************

   - Codificacion de datos en string binario, cero esquema de codificacion especial
   - Funcion de fitness externa
   - Operadores estandar de cruce, mutacion, etc...
   - Metodos de evaluacion de probabilidad de cruce dado por ruleta, ventana deslizante, dado, etc
   - Cero herencia, clase unica?
   - Funciones externas de codificacion de datos.
   - Funcion interna de codificacion a partir de apuntador a segmento de datos
   - Deteccion de esquematas?
*********************************************************************************/

/* HISTORIA DE REVISIONES
    rev 1.2
    - Manejo de opciones separadas para habilitar/deshabiltar elitismo (sug. Nicolas veloz)
    - Fitness de la primera generacion (poblacion aleatoria) antes era toda cero, ahora se calcula explicitamente
    ya que de lo contrario, si tambien se aplica elitismo, entonces produce sesgo en la primera generacion (sug. Alejandro Gonzalez)

    rev 1.1
    - ERROR: Corregido problema en el operador de cruce debido a fallo en operador unario utilizado
    que cancelaba toda la mascara acortando el string binario!!!
    - ERROR: Corregido problema de recursos de memoria. insertado delete que faltaba
    para eliminar la mascara de cruce creada dinamicamente

    >> Primera version completa. 1.0
      - Codigo construido, y evaluado para simples problemas de sintesis de patrones en un string HEXA.
      - Implementado en .hpp/.cpp

   rev 0.5
      - Primera revision funcional con operadores de clonacion, mutacion, cruce
        actualizacion de poblaciones, evaluacion externa de fitness por apuntador
        a funcion que recibe ap y devuelve float para el string evaluado.
      - Pruebas directas con esquema de codificacion hexa
      - Evaluacion de desempeño del codigo. Mejores resultados utilizando operador cruce de
       elite con el resto de ejemplares. Posibles problemas con el esuqema de seleccion_torunament,
       ya que surje una fuerte dependencia del operador de mutacion, mas que del operador cruce
      - Usar ruleta de goldberg? ventana deslizante?

   rev 0.4c
      - Implementacion de metodo de insercion de individuo en la poblacion B dado el ap
      - ERROR CORREGIDO: proceso de insercion, se implemento control de numero de individuos,
      	ultimas peticiones de insercion se pueden perder
      - Acceso a Edad, MejorFitness
      - Control de parada (fitness_threshold) externo

   rev 0.4b
   	- Operador de Mutacion y computo de fitness global de la poblacion
      - AG: Creacion de poblacion inicial aleatoria, manejo de memoria dinamico
      - Operadores de Creacion, Borrado, Clonacion y Mutacion probados....
      - AG: Creacion de poblacion aleatoria probada, con redimensionamiento de poblacion
      - AG: actualizacion de poblacion por copiado de contenido de memoria (string)
      - AG: ERROR en Generacion, al insertar ultimo elemento de poblacion B

   rev 0.4
   	- Implementacion de la clase Algoritmo Genetico
      - Esquema de dos poblaciones (arreglo de apuntadores)
      - Cromosoma: capacidad de redimensionar el string del cromosoma, sin memory leak
      - AG: Computo de fitness promedio
      - Seleccion tournament, best, worst, de la coleccion de strings en poblacion A
      - CR: Operador de clonacion de cromosoma, por memcpy, sin memory leak
      - AG: Operador de cruce1 resuelto por llamada a CruzarN (mascara deterministica)

   rev 0.a - 0.3
      - Implementacion de operadores de creacion, destruccion, mutacion y evaluacion de los cromosomas
      - Definicion de prototipos de operadores (versiones polimorficas)
      - Implementacion de mutacion con dTasaMutacion especificada por usuario
      - Destructor libera recursos

*/

#ifndef _CLASE_AG_H_
#define _CLASE_AG_H_

#define AG_MAX_POBLACION 4000
#define AG_MUTACION_DEFAULT 0.001

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

/*------------------------------------------------------------------------------
	Clase: Cromosoma
	>> Contiene informacion codificada de los parametros que identifican a cada especimen
	Para fines practicos de diseño, longitud de datos debe de ser de 256 bits

	Metodos:
	* Generar (Crear): Crea un inviduo nuevo, de manera aleatoria, llenando todos los campos
		Se puede implementar en el constructor de la clase
	* Mutar: Modifica segun el esquema aleatorio algun elemento del cromosoma, o todo el mismo

------------------------------------------------------------------------------*/

class CLASECromosoma //contiene estructura que maneja datos codificados del modelo
{
   private:
      int iLongitud; //lontigud del arreglo
      float dFitness; //fitnes asociado a la instancia
      int iD; //ID de control de la instancia

	public:
   	CLASECromosoma() //constructor
      {
      	iLongitud = 0;         Cromosoma = NULL;
        dFitness = 0;	//inicialmente cada cromosoma tiene fitnes y longitud cero
      }

   	~CLASECromosoma() //destructor
      {
      	if (iLongitud) delete Cromosoma; //libero si se reservo memoria
      }

      bool Crear (int); //crea un nuevo cromosoma con 'n' bytes
      bool Borrar (); //elimina info almacenada y mantiene solo elementos minimos del cromosoma
      float Fitness() {return dFitness;} //devuelve el fitness asociado al ente codificado en el cromosoma
   	  int Longitud(void) {return iLongitud;} //devuelve la longitud del cromosoma
      int Mutar (float); //muta cromosoma con una tasa dada
      int Mutar (); //operador de mutacion que cambia un bit de todo el string
      int Clonar(CLASECromosoma *); //creo duplicado del cromosoma this en el ap recibido
   	  unsigned char *Cromosoma; //apuntador a toda la informacion

      friend class CLASEAGenetico; //acceso
};

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

class CLASEAGenetico
{
   public:
   	CLASEAGenetico(); //constructor
        ~CLASEAGenetico(); //destructor

      bool usarElitismo;
      bool usarHarem;

      float dTasaMutacion; //tasa de mutacion (0 a 1)
      float fraccionHarem; //fraccion de la poblacion que se obtendra por harem con el elite
      float Fitness(void); //calcula y devuelve el valor de fitness promedio de poblacion
      int Generacion(void); //opera sobre poblacion para obtencion de una nueva generacion de individuos
      void PoblacionAleatoria(int n, int l); //genera una poblacion incial de 'n' individuos de largo 'l' (bytes)
      float MayorFitness(void); //devuelve el fitness del mejor individuo de la poblacion
      unsigned long Edad(void); //devuelve la edad de la poblacion
      int FuncionEvaluacion(float (* fn)(unsigned char *)); //fn que vincula con fn de evaluacion de cromosoma

      CLASECromosoma *SeleccionarMejor(void); //devuelve mejor individuo
      CLASECromosoma *SeleccionarPeor(void); //devuelve peor individuo
      CLASECromosoma *SeleccionarTournament (); //devuelve ap a cromosoma seleccionado por criterio TOURNAMENT
      int Cruzar (CLASECromosoma *,CLASECromosoma *); //cruce de dos individuos, devuelve 2 nuevos
      int CruzarN (CLASECromosoma *,CLASECromosoma *,int); //cruce de dos individuos, devuelve 2 nuevos
      void ActualizarPoblacion(void); //paso de poblacionB a poblacionA
      int InsertarPoblacionB (CLASECromosoma *); //inserta una copia fiel del cromosoma
      int PoblacionLibre(); //devuelve cuantos individuos mas se pueden agregar a la poblacion B
      int PuntosCruce(); //funcion que devuelve el numero de puntos de cruce
      int PuntosCruce(unsigned int); //funcion que asigna el numero de puntos de cruce

   private:
      float (*fnEvaluarCromosoma) (unsigned char *);//funcion que asigna al apuntador a funcion de
      CLASECromosoma *PoblacionA[AG_MAX_POBLACION],*PoblacionB[AG_MAX_POBLACION]; //arreglo finito de apuntadores a cromosomas (individuos)
		//dos poblaciones separadas, padres e hijos
      int iTamanoPoblacionA, iTamanoPoblacionB; //numero de individuos de cada poblacion
      float dFitness; //fitness promedio de la poblacion
      unsigned long ulEdad; //edad de la poblacion (numero de iteraciones)
      unsigned int iPuntosCruce;
};

#endif
