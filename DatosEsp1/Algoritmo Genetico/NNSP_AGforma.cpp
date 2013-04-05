/*************************************************************
*                   Programa de NNSP                         *
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

#define POBLACION 300
#define umbral 0.05
#define NumEjemplos 2190
#define NumConst 8
#define NumAsig 2
#define NumOI 2
#define NumOU 1

int NBYTES=NumConst+NumAsig+NumOI+NumOU;
float Ejemplos[NumEjemplos][7];
float constantes[NumConst];
unsigned int variables[NumAsig], OI[NumOI], OU[NumOU];
float apuestas[NumEjemplos][3],P[NumEjemplos][3];
int Resultados[NumEjemplos];
int var[8],opint[4],opun[3];
float operIn[4],operUn[3];

int main(){

    srand ( time(NULL) ); //uso semilla inicial aleatoria, diferente

    FILE *file = fopen ("EjemplosAG.txt", "r" );
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
    }
    for(int p=0;p<3;p++){
    apuestas[i][p]=Ejemplos[i][p+3];
    }
    Resultados[i]=(int)Ejemplos[i][6];
    i++;}
    fclose ( file );
    }
    else
    {
    perror ( "EjemplosAG.txt" ); /* why didn't the file open? */
    }

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
		printf("Fitness=%.2f %d %d\n",mejor->Fitness(),Espera,contador);
		if((mejor->Fitness()-mejor_anterior)>umbral){
		Espera=0;
		mejor_anterior=mejor->Fitness();
		}
		fp=ag.Fitness();

		Espera++;
		contador++;
   }
   while (contador<10000&&Espera<500); //condicion de parada el fitness de la mejor solucion

    printf ("\nTermino en %d iteraciones", contador);

	return 0;
}


float nuestra_funcion(unsigned char *cromosoma) // la funcion que decodifica y calcula el fitness de UN cromosoma
{
//Guardar cromosomas
int offset=0;
  for(int i=0;i<NumConst;i++){
    unsigned int x = cromosoma[i];
    x=exGrayBinario(x);//8 Constantes
    constantes[i]=(20.0/255.0)*((float)x-128.0);//Constantes: Mapear 0->-10, 255->10
    }
    offset=NumConst;
  for(int i=0;i<NumAsig;i++){
    unsigned int x = cromosoma[i+offset];
    variables[i]=exGrayBinario(x);//Asignacion de Variables
  }
        offset=NumConst+NumAsig;
  for(int i=0;i<NumOI;i++){
    unsigned int x = cromosoma[i+offset];
    OI[i]=exGrayBinario(x);//Asignacion de Variables
  }
    offset=NumConst+NumAsig+NumOI;
  for(int i=0;i<NumOU;i++){
    unsigned int x = cromosoma[i+offset];
    OU[i]=exGrayBinario(x);//Asignacion de Variables
    }

    decodificarBytes();

    float Ganancia=calcularGanancia();

    float fitness=Ganancia;
	return fitness;
}

void decodificarBytes(void){

    unsigned int v1=variables[0],v2=variables[1];

        //Variables Prob,Bet,Const1,Const2
        var[0] = (v1 & 0xC0)/64;//Operacion1
        var[1] = (v1 & 0x30)/16;//Operacion1
        var[2] = (v1 & 0x0C)/4;//Operacion2
        var[3] = v1 & 0x03;//Operacion2
        var[4] = (v2 & 0xC0)/64;//Operacion3
        var[5] = (v2 & 0x30)/16;//Operacion3
        var[6] = (v2 & 0x0C)/4;//Operacion4
        var[7] = v2 & 0x0C;//Operacion4

        //Operaciones Internas
        opint[0] = (OI[0] & 0xE0)/32;//Operacion1
        opint[1] = (OI[0] & 0x1C)/4;//Operacion2
        opint[2] = (OI[1] & 0xE0)/32;//Operacion3
        opint[3] = (OI[1] & 0x1C)/4;//Operacion4

        //Operaciones Externas
        opun[0] = (OU[0] & 0xC0)/64;//Operacion12
        opun[1] = (OU[0] & 0x30)/16;//Operacion23
        opun[2] = (OU[0] & 0xC0)/4;//Operacion34
}

float calcularGanancia(void){
    float v1,v2,G[3],Ganancia=0,parcial;

    for(int ej=0;ej<NumEjemplos;ej++){//En todos los ejemplos
        for(int hda=0;hda<3;hda++){//Home,Draw y Away
            for(int un=0;un<3;un++){//Operaciones Union
                 for(int i=0;i<4;i++){//Operaciones Internas
                    switch (opint[i]){//Saca Resultados de las operaciones internas
                        case 0:{//Suma
                            switch(var[2*i]){
                             case 0:{
                                 v1=P[ej][hda];
                                   break;}
                             case 1:{
                                 v1=apuestas[ej][hda];
                                 break;}
                             case 2:{
                                 v1=constantes[2*i];
                                 break;}
                             case 3:{
                                 v1=constantes[2*i+1];
                                 break;}}
                            switch(var[2*i+1]){
                             case 0:{
                                 v2=P[ej][hda];
                                   break;}
                             case 1:{
                                 v2=apuestas[ej][hda];
                                 break;}
                             case 2:{
                                 v2=constantes[2*i];
                                 break;}
                             case 3:{
                                 v2=constantes[2*i+1];
                                 break;}
                                            }
                            operIn[i]=v1+v2;
                        break;
                        }
                        case 1:{//Resta
                            switch(var[2*i]){
                             case 0:{
                                 v1=P[ej][hda];
                                   break;}
                             case 1:{
                                 v1=apuestas[ej][hda];
                                 break;}
                             case 2:{
                                 v1=constantes[2*i];
                                 break;}
                             case 3:{
                                 v1=constantes[2*i+1];
                                 break;}}
                            switch(var[2*i+1]){
                             case 0:{
                                 v2=P[ej][hda];
                                   break;}
                             case 1:{
                                 v2=apuestas[ej][hda];
                                 break;}
                             case 2:{
                                 v2=constantes[2*i];
                                 break;}
                             case 3:{
                                 v2=constantes[2*i+1];
                                 break;}
                                            }
                            operIn[i]=v1-v2;
                        break;
                        }
                        case 2:{//Multiplicacion
                            switch(var[2*i]){
                             case 0:{
                                 v1=P[ej][hda];
                                   break;}
                             case 1:{
                                 v1=apuestas[ej][hda];
                                 break;}
                             case 2:{
                                 v1=constantes[2*i];
                                 break;}
                             case 3:{
                                 v1=constantes[2*i+1];
                                 break;}}
                            switch(var[2*i+1]){
                             case 0:{
                                 v2=P[ej][hda];
                                   break;}
                             case 1:{
                                 v2=apuestas[ej][hda];
                                 break;}
                             case 2:{
                                 v2=constantes[2*i];
                                 break;}
                             case 3:{
                                 v2=constantes[2*i+1];
                                 break;}
                                            }
                            operIn[i]=v1*v2;
                        break;
                        }
                        case 3:{//Division
                            switch(var[2*i]){
                             case 0:{
                                 v1=P[ej][hda];
                                   break;}
                             case 1:{
                                 v1=apuestas[ej][hda];
                                 break;}
                             case 2:{
                                 v1=constantes[2*i];
                                 break;}
                             case 3:{
                                 v1=constantes[2*i+1];
                                 break;}}
                            switch(var[2*i+1]){
                             case 0:{
                                 v2=P[ej][hda];
                                   break;}
                             case 1:{
                                 v2=apuestas[ej][hda];
                                 break;}
                             case 2:{
                                 v2=constantes[2*i];
                                 break;}
                             case 3:{
                                 v2=constantes[2*i+1];
                                 break;}
                                            }
                            if(v2!=0){
                            operIn[i]=v1/v2;}
                            else{
                            operIn[i]=1;}
                        break;
                        }
                        case 4:{//exp
                            switch(var[2*i]){
                             case 0:{
                                 v1=P[ej][hda];
                                   break;}
                             case 1:{
                                 v1=apuestas[ej][hda];
                                 break;}
                             case 2:{
                                 v1=constantes[2*i];
                                 break;}
                             case 3:{
                                 v1=constantes[2*i+1];
                                 break;}}
                                 operIn[i]=expf(v1);
                                 }
                        case 5:{//log
                            switch(var[2*i]){
                             case 0:{
                                 v1=P[ej][hda];
                                   break;}
                             case 1:{
                                 v1=apuestas[ej][hda];
                                 break;}
                             case 2:{
                                 v1=constantes[2*i];
                                 break;}
                             case 3:{
                                 v1=constantes[2*i+1];
                                 break;}}

                                 if(v1!=0){
                                 operIn[i]=logf(v1);
                                 }
                                 else{
                                 operIn[i]=1;}
                        }
                        case 6:{//cos
                            switch(var[2*i]){
                             case 0:{
                                 v1=P[ej][hda];
                                   break;}
                             case 1:{
                                 v1=apuestas[ej][hda];
                                 break;}
                             case 2:{
                                 v1=constantes[2*i];
                                 break;}
                             case 3:{
                                 v1=constantes[2*i+1];
                                 break;}}
                                 operIn[i]=cos(v1);
                                 }
                        case 7:{//sin
                    switch(var[2*i]){
                     case 0:{
                         v1=P[ej][hda];
                           break;}
                     case 1:{
                         v1=apuestas[ej][hda];
                         break;}
                     case 2:{
                         v1=constantes[2*i];
                         break;}
                     case 3:{
                         v1=constantes[2*i+1];
                         break;}}
                         operIn[i]=sin(v1);
                         }
                    }
                }
                    if(un==0){
                    parcial=operIn[un];}

                    switch(opun[un]){
                        case 0:{//Suma
                        operUn[un]=parcial+operIn[un+1];
                        break;}
                        case 1:{//Resta
                        operUn[un]=parcial-operIn[un+1];
                        break;}
                        case 2:{//Multiplicacion
                        operUn[un]=parcial*operIn[un+1];
                        break;}
                        case 3:{//Division
                        if (operIn[un+1]!=0){
                        operUn[un]=parcial/operIn[un+1];}
                        else{
                        operUn[un]=parcial;}
                        break;}
                    }
                    parcial=operUn[un];
                    }
                G[hda]=parcial;
        }
        Ganancia=Ganancia+G[Resultados[ej-1]];
    }
    return Ganancia/(1000*NumEjemplos);
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
