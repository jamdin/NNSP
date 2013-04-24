/*************************************************************
*            NNSP Todos Ejemplos 2 rondas                    *
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
void leerEjemplos(char* datosPartido);
void aplicarAG(void);

#define POBLACION 300
#define umbral 0.05
#define NumEjemplos 1450
//#define fila 30
#define PenalizarCien 0
#define RefuerzoCero 10
#define penJuegos 0.1
//#define NumFilas 10
//#define NBYTES 30  //NBYTES=NumFilas*3


int fila,NumFilas,NBYTES;
float Ejemplos[NumEjemplos][7],seleccion[10][7],sels[10][7],sele[10][7],seld[9][7],seli[10][7],self[10][7];
float xbet[30],xmejor[30];
float apuestas[NumEjemplos][3],P[NumEjemplos][3];
int Resultados[NumEjemplos];
float G[30];
float Inversion=0.0, apcero=0, numjuegos,apcien=0;
int numsel,nums,nume,numd,numi,numf;


int main(){

    FILE *archivo;
    archivo=fopen("gananciasTodosUnidos.txt","w+");


    for(fila=0;fila<=(NumEjemplos-10);fila=fila+10){
        printf("Fila:%d\n",fila);
    NumFilas=10;
    NBYTES=3*NumFilas;
    leerEjemplos("PCortadosEsp.txt");
    aplicarAG();
     for(int i=0;i<NumFilas;i++){
            for(int j=0;j<7;j++){
                sels[i][j]=seleccion[i][j];
            }
		}

	nums=numsel;

    leerEjemplos("PCortadosIng.txt");
    aplicarAG();
     for(int i=0;i<NumFilas;i++){
            for(int j=0;j<7;j++){
                sele[i][j]=seleccion[i][j];
            }
		}
	nume=numsel;

    NumFilas=9;
    NBYTES=3*NumFilas;

    leerEjemplos("PCortadosAle.txt");
    aplicarAG();
     for(int i=0;i<NumFilas;i++){
            for(int j=0;j<7;j++){
                seld[i][j]=seleccion[i][j];
            }
		}
	numd=numsel;

    NumFilas=10;
    NBYTES=3*NumFilas;

	leerEjemplos("PCortadosIta.txt");
    aplicarAG();
     for(int i=0;i<NumFilas;i++){
            for(int j=0;j<7;j++){
                seli[i][j]=seleccion[i][j];
            }
		}
	numi=numsel;

        leerEjemplos("PCortadosFra.txt");
    aplicarAG();
     for(int i=0;i<NumFilas;i++){
            for(int j=0;j<7;j++){
                self[i][j]=seleccion[i][j];
            }
		}
	numf=numsel;

    int ntot=nums+nume+numd+numi+numf;
    float Ejtot[ntot][7];
    int offset=0;

    for(int i=0;i<nums;i++){
            for(int j=0;j<7;j++){
                Ejtot[i][j]=sels[i][j];
            }
		}
	offset+=nums;
    for(int i=0;i<nume;i++){
            for(int j=0;j<7;j++){
                Ejtot[i+offset][j]=sele[i][j];
                            }
		}
	offset+=nume;
    for(int i=0;i<numd;i++){
            for(int j=0;j<7;j++){
                Ejtot[i+offset][j]=seld[i][j];
            }
		}
    offset+=numd;
    for(int i=0;i<numi;i++){
            for(int j=0;j<7;j++){
                Ejtot[i+offset][j]=seli[i][j];
            }
		}
    offset+=numi;

    for(int i=0;i<numf;i++){
            for(int j=0;j<7;j++){
                Ejtot[i+offset][j]=self[i][j];
            }
		}


    NumFilas=ntot;
    NBYTES=3*NumFilas;

	for(int i=0;i<NumFilas;i++){

        for(int p=0;p<3;p++){
            P[i+fila][p]=Ejtot[i][p];
        }
        for(int p=0;p<3;p++){
            apuestas[i+fila][p]=Ejtot[i][p+3];
        }
        Resultados[i+fila]=(int)Ejtot[i][6];
    }


    aplicarAG();
    /*
     for(int i=0;i<NumFilas;i++){
            for(int j=0;j<3;j++){
                printf("%.4f\t",xmejor[j+3*i]);
            }
            printf("\n");
		}
*/

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

    if(Inversion!=100){
        Inversion=0;
        for(int i=0;i<NBYTES;i++){
            Inversion+=xbet[i];
}
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

void leerEjemplos(char* datosPartido){

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

void aplicarAG(void){
    float matap[NumFilas][3],sumafila[NumFilas];
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

    for(int i=0;i<NumFilas;i++){
        sumafila[i]=0.0;
            for(int j=0;j<3;j++){
                matap[i][j]=xmejor[j+i*3];
                sumafila[i]+=round(matap[i][j]);
            }
            }

    //Reiniciar Variables
    numsel=0;
    for(int i=0;i<NumFilas;i++){//Reiniciar seleccion
            for(int j=0;j<7;j++){
                seleccion[i][j]=0;
            }
		}

    for(int f=0;f<NumFilas;f++){
        if(sumafila[f]!=0){
            for(int p=0;p<3;p++){
                seleccion[numsel][p]=P[f][p];
            }

            for(int p=0;p<3;p++){
                seleccion[numsel][p+3]=apuestas[f][p];
                }
            seleccion[numsel][6]=Resultados[f];
            numsel++;
        }
    }

        printf("%d\n",numsel);

}
