/*************************************************************
*                NNSP Todos Ejemplos                         *
*            Elaborado por: Jamie Diner                      *
**************************************************************/

///////////////////////////////
//Falta agregar la funcion de guardar la forma de la ecuacion 04/04/2013
//////////////////////////////


#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include "clase_ag.cpp"
#include "extra_ag.cpp"

CLASEAGenetico ag; //variable global que corresponde a mi poblacion completa

float nuestra_funcion(unsigned char *); //prototipo de la funcion que decodifica y calcula el fitness de UN cromosoma
void decodificarBytes(void);
void escribirexcelfit(FILE *archivo);
void escribirexcelubic(FILE *archivo);
float calcularGanancia(void);
float penalizarJuegos(void);
void leerEjemplos(void);

#define POBLACION 300
#define umbral 0.05
#define NumEjemplos 1450
//#define fila 30
#define PenalizarCien 0
#define RefuerzoCero 10
#define penJuegos 0.1
#define NumFilas 10
#define NBYTES 30  //NBYTES=NumFilas*3
#define datosPartido "EjemplosAGFra.txt"

int fila;
float Ejemplos[NumEjemplos][7];
float xbet[NBYTES],xmejor[NBYTES];
float apuestas[NumEjemplos][3],P[NumEjemplos][3];
int Resultados[NumEjemplos];
float G[NBYTES];
float Inversion=0.0, apcero=0, numjuegos,apcien=0;


int main(){

    FILE *archivo;
    archivo=fopen("gananciasFraS.txt","w+");
    leerEjemplos();

    for(fila=0;fila<=(NumEjemplos-10);fila=fila+10){
    printf("Fila:%d\tFitness:",fila);
    srand ( time(NULL) ); //uso semilla inicial aleatoria, diferente
	//configuro el AG
	ag.usarElitismo=true;
	ag.PoblacionAleatoria(POBLACION,NBYTES); //configuro una poblacion de tamaño dado, con nBytes por cromosoma (individuo)
    ag.dTasaMutacion = 0.005; //tasa de mutacion de 0 a 1
	ag.FuncionEvaluacion(nuestra_funcion); //defino cual es la funcion que evalua cada cromosoma y devuelve el fitnes entre 0 y 1 (Es llamada automaticamante por al AG
	CLASECromosoma *mejor; //CREO UN APUNTADOR al mejor individuo
	int contador = 0;
	float mejor_anterior=0.0,fp;
	int Espera=0;

 do
   {
 		ag.Generacion(); //creo una nueva generacion de individuos
		mejor = ag.SeleccionarMejor(); //obtengo el apuntador al mejor
/*
		if(contador%100==0){
		printf("Fitness=%.2f\t%.4f %.4f %.4f\t%.4f %.4f %.4f\n",mejor->Fitness(),P[fila][0],P[fila][1],P[fila][2],G[0],G[1],G[2]);
		for(int i=0;i<NumFilas;i++){
            for(int j=0;j<3;j++){
                printf("%.4f\t",xmejor[j+i*3]);
            }
            printf("\n");
		}

		}*/

		//printf("Fitness=%.2f %.4f %.4f %.4f %.4f %.4f %.4f %d %d\n",mejor->Fitness(),xbet[0],xbet[1],xbet[2],P[fila][0],P[fila][1],P[fila][2],Espera,contador);
		if((mejor->Fitness()-mejor_anterior)>umbral){
		Espera=0;
		mejor_anterior=mejor->Fitness();
		for(int m=0;m<NBYTES;m++){
		xmejor[m]=xbet[m];}
		}
		fp=ag.Fitness();

		Espera++;
		contador++;
   }
   while (contador<10000&&Espera<500); //condicion de parada el fitness de la mejor solucion
    printf("%.4f\n",mejor_anterior);
    //printf ("\nTermino en %d iteraciones\n", contador);
    int r;
    float g=0.0,a;
    for(int i=0;i<NumFilas;i++){
    r=Resultados[fila+i];
    a=apuestas[fila+i][r-1];
    g+=xmejor[i*3+(r-1)]*a;
    printf("%d %.2f %.2f %.2f\n",r,a,g,Inversion);
    }
    printf("Ganancia=%.2f Ganancia Neta=%.2f\n",g,(g-Inversion));
    fprintf(archivo,"%.4f\t%.4f\n",g,(g-Inversion));
}
    fclose(archivo);
	return 0;

}


float nuestra_funcion(unsigned char *cromosoma) // la funcion que decodifica y calcula el fitness de UN cromosoma
{
//Guardar cromosomas
    Inversion=0.0, apcero=0.0,apcien=0.0;
  for(int i=0;i<NBYTES;i++){
    unsigned int x = cromosoma[i];
    x=exGrayBinario(x);
    xbet[i]=(100.0/255.0)*((float)x);// Mapear 0->0, 255->100

    if(xbet[i]==0.0){
    apcero+=RefuerzoCero;//reforzar solo las apuestas que en verdad tengan prob de ganar
    }
    Inversion+=xbet[i];
    }

    for(int i=0;i<NBYTES;i++){
      xbet[i]=100.0*xbet[i]/Inversion;
      }
      Inversion=0;
    for(int i=0;i<NBYTES;i++){
      Inversion+=xbet[i];
      if(xbet[i]==100.0){
      apcien+=PenalizarCien;//reforzar solo las apuestas que en verdad tengan prob de ganar
    }}

    float Ganancia=calcularGanancia();
    numjuegos=penalizarJuegos();
    float fitness=Ganancia+apcero-numjuegos-apcien;
	return fitness;
}


float calcularGanancia(void){
    float Ganancia=0.0;
    Inversion=0.0;

    for(int f=0;f<NumFilas;f++){//Recorre los ejemplos
        for(int i=0;i<3;i++){//Recorre los parametros
            Inversion+=xbet[i+f*3];
            G[i+f*3]=xbet[i+f*3]*pow(P[f+fila][i],2)*apuestas[f+fila][i];
            Ganancia+=G[i+f*3];
            //printf("%.2f %.2f %.2f %.4f\n",xbet[i+f*3],pow(P[f+fila][i],1),apuestas[f+fila][i],G[i+f*3]);
            //system("PAUSE");
        }
        }

    if(Inversion==0){
    Inversion=1;
    }

    return 100*(Ganancia*Ganancia-Inversion*Inversion);
}

float penalizarJuegos(void){
    float numJuegos=0.0,inv;
    for(int i=0;i<NBYTES;i++){
        inv=xbet[i];
        if(G[i]<inv){
        numJuegos+=penJuegos;
        }
        }
    return 10*numJuegos;
    }

void leerEjemplos(void){

FILE *file = fopen (datosPartido, "r" );
    int i=0;
    if ( file != NULL )
    {
   while ( i<NumEjemplos ) /* read a line */
    {
    for(int par=0;par<7;par++){
    fscanf(file,"%f",&Ejemplos[i][par]);
    }
    for(int p=0;p<3;p++){
    P[i][p]=Ejemplos[i][p];
    if(P[i][p]<0.1){
    P[i][p]=0.0;
    }

    }
    for(int p=0;p<3;p++){
    apuestas[i][p]=Ejemplos[i][p+3];
    }
    Resultados[i]=(int)Ejemplos[i][6];
    if(Resultados[i]==0){
    printf("%d %d\n",Resultados[i],i);
        system("pause");}

    i++;}
    fclose ( file );
    }
    else
    {
    perror ( datosPartido ); /* why didn't the file open? */
    }


}

/*
void escribirexcelfit(FILE *archivo){
    for(int i=0;i<indfit;i++){
    fprintf(archivo,"%d\t%f\t%f\n",confitmejor[i],varfitmejor[i],varfitprom[i]);
    }
}

void escribirexcelubic(FILE *archivo){
    for(int i=0;i<N_CAJAS;i++){
    fprintf(archivo,"%d\t%d\t%d\n",xcajas[i],ycajas[i],cajasdentro[i]);
    }
    fprintf(archivo,"%f",valortotal);
}
*/
