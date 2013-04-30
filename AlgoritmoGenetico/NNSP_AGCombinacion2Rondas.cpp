/*************************************************************
*                   NNSP 2 rondas                            *
*            Elaborado por: Jamie Diner                      *
**************************************************************/


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
void reiniciarVar(void);
float penalizarPartidoGan(void);
int encontrarMayor(float x,float y,float z);

#define POBLACION 300
#define umbral 0.05
#define NumEjemplos 70
//#define fila 30
#define PenalizarCien 0
#define RefuerzoCero 10
#define penJuegos 0.1
#define penPar 0
#define NFilEsp 9
#define NFilIng 10
#define NFilAle 8
#define NFilIta 10
#define NFilFra 10
#define dirAp "predTodosUnidos1213AbrS4_Nombre.txt"
#define dirEsp "PartidosJ33Esp_conNombres3.txt"
#define dirIng "PartidosJ34Ing_conNombres.txt"
#define dirAle "PartidosJ31Ale_conNombres.txt"
#define dirIta "PartidosJ34Ita_conNombres.txt"
#define dirFra "PartidosJ34Fra_conNombres.txt"
//#define NumFilas 10
//#define NBYTES 30  //NBYTES=NumFilas*3


int fila=0,NumFilas,NBYTES;
float Ejemplos[NumEjemplos][6],seleccion[NumEjemplos][6],sels[NFilEsp][6],sele[NFilIng][6],seld[NFilAle][6],seli[NFilIta][6],self[NFilFra][6];
float xbet[NumEjemplos],xmejor[NumEjemplos],xsel[NumEjemplos],xselRep[NumEjemplos];
float apuestas[NumEjemplos][3],P[NumEjemplos][3];
int Resultados[NumEjemplos];
float G[50];
float Inversion=0.0, apcero=0, numjuegos,apcien=0;
int numsel,nums,nume,numd,numi,numf;
char EquipoLocal[NumEjemplos][25],EquipoVis[NumEjemplos][25],EquipoSelH[NumEjemplos][25],EquipoSelA[NumEjemplos][25];
char EquipoSelHS[10][25],EquipoSelAS[10][25],EquipoSelHE[10][25],EquipoSelAE[10][25],EquipoSelHD[10][25],EquipoSelAD[10][25];
char EquipoSelHI[10][25],EquipoSelAI[10][25],EquipoSelHF[10][25],EquipoSelAF[10][25],EquipoSelRepH[NumEjemplos][25],EquipoSelRepA[NumEjemplos][25];


int main(){

    FILE *archivo;
    archivo=fopen(dirAp,"w+");
    //leerEjemplos("PartidosJ31Esp_conNombres.txt");
    int indiceRep=0;

    for(int rep=0;rep<10;rep++){

    //reiniciarVar();
    NumFilas=NFilEsp;
    NBYTES=3*NumFilas;
    leerEjemplos(dirEsp);
    aplicarAG();
     for(int i=0;i<NumFilas;i++){
         strcpy(EquipoSelHS[i],EquipoSelH[i]);
         strcpy(EquipoSelAS[i],EquipoSelA[i]);
            for(int j=0;j<7;j++){
                sels[i][j]=seleccion[i][j];
            }
		}

	nums=numsel;
    system("PAUSE");
    NumFilas=NFilIng;
    NBYTES=3*NumFilas;
    leerEjemplos(dirIng);
    aplicarAG();
     for(int i=0;i<NumFilas;i++){
         strcpy(EquipoSelHE[i],EquipoSelH[i]);
         strcpy(EquipoSelAE[i],EquipoSelA[i]);
            for(int j=0;j<7;j++){
                sele[i][j]=seleccion[i][j];
            }
		}
	nume=numsel;

    NumFilas=NFilAle;
    NBYTES=3*NumFilas;

    leerEjemplos(dirAle);
    aplicarAG();
     for(int i=0;i<NumFilas;i++){
         strcpy(EquipoSelHD[i],EquipoSelH[i]);
         strcpy(EquipoSelAD[i],EquipoSelA[i]);
            for(int j=0;j<7;j++){
                seld[i][j]=seleccion[i][j];
            }
		}
	numd=numsel;

    NumFilas=NFilIta;
    NBYTES=3*NumFilas;

	leerEjemplos(dirIta);
    aplicarAG();
     for(int i=0;i<NumFilas;i++){
         strcpy(EquipoSelHI[i],EquipoSelH[i]);
         strcpy(EquipoSelAI[i],EquipoSelA[i]);
            for(int j=0;j<7;j++){
                seli[i][j]=seleccion[i][j];
            }
		}
	numi=numsel;

    NumFilas=NFilFra;
    NBYTES=3*NumFilas;
    leerEjemplos(dirFra);
    aplicarAG();
     for(int i=0;i<NumFilas;i++){
         strcpy(EquipoSelHF[i],EquipoSelH[i]);
         strcpy(EquipoSelAF[i],EquipoSelA[i]);
            for(int j=0;j<7;j++){
                self[i][j]=seleccion[i][j];
            }
		}
	numf=numsel;

    int ntot=nums+nume+numd+numi+numf;
    float Ejtot[ntot][7];
    char EquipoSelTotH[ntot][25],EquipoSelTotA[ntot][25];
    int offset=0;

    for(int i=0;i<nums;i++){
         strcpy(EquipoLocal[i],EquipoSelHS[i]);
         strcpy(EquipoVis[i],EquipoSelAS[i]);
            for(int j=0;j<7;j++){
                Ejtot[i][j]=sels[i][j];
            }
		}
	offset+=nums;
    for(int i=0;i<nume;i++){
         strcpy(EquipoLocal[i+offset],EquipoSelHE[i]);
         strcpy(EquipoVis[i+offset],EquipoSelAE[i]);
            for(int j=0;j<7;j++){
                Ejtot[i+offset][j]=sele[i][j];
                            }
		}
	offset+=nume;
    for(int i=0;i<numd;i++){
         strcpy(EquipoLocal[i+offset],EquipoSelHD[i]);
         strcpy(EquipoVis[i+offset],EquipoSelAD[i]);
            for(int j=0;j<7;j++){
                Ejtot[i+offset][j]=seld[i][j];
            }
		}
    offset+=numd;
    for(int i=0;i<numi;i++){
         strcpy(EquipoLocal[i+offset],EquipoSelHI[i]);
         strcpy(EquipoVis[i+offset],EquipoSelAI[i]);
            for(int j=0;j<7;j++){
                Ejtot[i+offset][j]=seli[i][j];
            }
		}
    offset+=numi;

    for(int i=0;i<numf;i++){
         strcpy(EquipoLocal[i+offset],EquipoSelHF[i]);
         strcpy(EquipoVis[i+offset],EquipoSelAF[i]);
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
    }


    aplicarAG();

    for(int i=0;i<numsel;i++){
         strcpy(EquipoSelRepH[i+indiceRep],EquipoSelH[i]);
         strcpy(EquipoSelRepA[i+indiceRep],EquipoSelA[i]);
            for(int j=0;j<3;j++){
                xselRep[j+3*(i+indiceRep)]=xsel[j+3*i];
            }
		}
	indiceRep+=numsel;
	printf("Repeticion:%d\n",rep);
	for(int i=0;i<indiceRep;i++){
         printf("%s\t%s\t",EquipoSelRepH[i],EquipoSelRepA[i]);
            for(int j=0;j<3;j++){
                printf("%.4f\t",xselRep[j+3*i]);
            }
            printf("\n");
		}

    }

     for(int i=0;i<indiceRep;i++){
         fprintf(archivo,"%s\t%s\t",EquipoSelRepH[i],EquipoSelRepA[i]);
            for(int j=0;j<3;j++){
                fprintf(archivo,"%.4f\t",xselRep[j+3*i]);
            }
            fprintf(archivo,"\n");
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
    float pen=penalizarPartidoGan();
    numjuegos=penalizarJuegos();
    float fitness=Ganancia+apcero-numjuegos-apcien-pen;
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

float penalizarPartidoGan(void){
     int mayorApuest,mayorPred;
     float pen=0.0;
     for(int f=0;f<NumFilas;f++){//Recorre los ejemplos
        mayorApuest=encontrarMayor(xbet[0+f*3],xbet[1+f*3],xbet[2+f*3]);
        mayorPred=encontrarMayor(P[f+fila][0],P[f+fila][1],P[f+fila][2]);

        if(mayorApuest!=mayorPred){
        pen+=penPar/(xbet[(mayorApuest-1)+f*3]+0.01);
        }
        }
    return pen;
}

int encontrarMayor(float x,float y,float z){
    int mayor=1;
    if(x<y&&y>z){
    mayor=2;}
    if(x<z&&y<z){
    mayor=3;
    }
    return mayor;
}


void leerEjemplos(char* datosPartido){

FILE *file = fopen (datosPartido, "r" );
    if ( file != NULL )
    {
   for (int i=0;i<NumEjemplos;i++) /* read a line */
    {
    fscanf(file,"%25s\t%25s\t%f\t%f\t%f\t%f\t%f\t%f",&EquipoLocal[i],&EquipoVis[i],&Ejemplos[i][0],&Ejemplos[i][1],&Ejemplos[i][2],&Ejemplos[i][3],&Ejemplos[i][4],&Ejemplos[i][5]);
    //printf("%20s\t%20s\t%f\t%f\t%f\t%f\t%f\t%f",EquipoLocal[i],EquipoVis[i],Ejemplos[i][0],Ejemplos[i][1],Ejemplos[i][2],Ejemplos[i][3],Ejemplos[i][4],Ejemplos[i][5]);
    //printf("\n%s",EquipoLocal[i]);

/*
    for(int par=0;par<7;par++){
    fscanf(file,"%f",&Ejemplos[i][par]);
    }*/
    for(int p=0;p<3;p++){
    P[i][p]=Ejemplos[i][p];
    if(P[i][p]<0.1){
    P[i][p]=0.0;
    }

    }
    for(int p=0;p<3;p++){
    apuestas[i][p]=Ejemplos[i][p+3];
    }
    //printf("%.2f %.2f %.2f\n",P[i][0],P[i][1],P[i][2]);
    }
    fclose ( file );
    }
    else
    {
    perror ( datosPartido );
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
        xsel[i]=0;
        strcpy(EquipoSelH[i],"");
        strcpy(EquipoSelA[i],"");
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
            for(int j=0;j<3;j++){
                xsel[j+3*numsel]=xmejor[j+3*f];
            }
                strcpy(EquipoSelH[numsel],EquipoLocal[f]);
                strcpy(EquipoSelA[numsel],EquipoVis[f]);
            numsel++;
        }
    }

		for(int i=0;i<numsel;i++){
            printf("%s\t%s\t",EquipoSelH[i],EquipoSelA[i]);
            for(int j=0;j<3;j++){
                printf("%.4f\t",xsel[j+3*i]);
            }
            printf("%.2f\t%.2f\t%.2f",seleccion[i][0],seleccion[i][1],seleccion[i][2]);
            printf("\n");
		}

        printf("%d\n",numsel);
//        system("PAUSE");
}

void reiniciarVar(void){
for(int i=0;i<NumEjemplos;i++){
    for(int j=0;j<25;j++){
        EquipoLocal[i][j]=0;
        EquipoVis[i][j]=0;
        EquipoSelH[i][j]=0;
        EquipoSelA[i][j]=0;
}}
for(int i=0;i<10;i++){
    for(int j=0;j<25;j++){
        strcpy(EquipoSelHS[i],"");
        strcpy(EquipoSelAS[i],"");
        strcpy(EquipoSelHE[i],"");
        strcpy(EquipoSelAE[i],"");
        strcpy(EquipoSelHD[i],"");
        strcpy(EquipoSelAD[i],"");
        strcpy(EquipoSelHI[i],"");
        strcpy(EquipoSelAI[i],"");
        strcpy(EquipoSelHF[i],"");
        strcpy(EquipoSelAF[i],"");
    }
    }

}
