/*************************************************************
*                   Fuzzy Tuning                             *
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
void leerEjemplos(char* datosPartido);
void aplicarAG(void);
void leerTablas(void);
float encontrar_y(float md1,float md2,float md3,float md4,float md5);
float membresia(float x,float b,float c);
float encontrar_md(int d);
float ylocal(void);
float yvis(void);
float yunion(void);

#define POBLACION 1000
#define umbral 0.0005
#define NumEjemplos 400
#define NumMiniEjem 10
#define NumParametros 14
#define NBYTES 75
#define dirbc "FuzzyTuningEspbc.txt"
#define dirw "FuzzyTuningEspw.txt"
#define dirSel "SeleccionEspFuzzy.txt"
#define dirTabla1 "Tabla1.txt"
#define dirTabla2 "Tabla2.txt"
#define PenB 1

#define y1 -5.0
#define y2 -3.0
#define y3 -1.0
#define y4 1.0
#define y5 3.0


int Ejemplos[NumEjemplos][14];
int xlocal[NumEjemplos][5],xvis[NumEjemplos][5],xdir[NumEjemplos][2],xsel[5];
int xlocalmini[NumMiniEjem][5],xvismini[NumMiniEjem][5],xdirmini[NumMiniEjem][2];
float blocal[5],clocal[5],wlocal[15],blmejor[5],clmejor[5],wlmejor[15];
float bvis[5],cvis[5],wvis[15],bvmejor[5],cvmejor[5],wvmejor[15];
float bunion[5],cunion[5],wunion[15],bumejor[5],cumejor[5],wumejor[15];
int Resultados[NumEjemplos];
int tabla1[15][6],tabla2[15][5];

int main(){


    leerEjemplos(dirSel);
    leerTablas();
    aplicarAG();


    FILE *archivo,*archivo2;
    archivo=fopen(dirbc,"w+");
    archivo2=fopen(dirw,"w+");
     for(int i=0;i<5;i++){
         fprintf(archivo,"%.4f\t%.4f\t%.4f\n",blmejor[i],bvmejor[i],bumejor[i]);}
          fprintf(archivo,"\n");
     for(int i=0;i<5;i++){
         fprintf(archivo,"%.4f\t%.4f\t%.4f\n",clmejor[i],cvmejor[i],cumejor[i]);}

    fclose(archivo);

    for(int i=0;i<15;i++){
         fprintf(archivo2,"%.4f\t%.4f\t%.4f\n",wlmejor[i],wvmejor[i],wumejor[i]);
         }

    fclose(archivo2);
	return 0;

}


float nuestra_funcion(unsigned char *cromosoma) // la funcion que decodifica y calcula el fitness de UN cromosoma
{
   float error_acum=0.0,penalb=0.0;
 int offset=0;
  for(int i=0;i<5;i++){//blocal
    unsigned int x = cromosoma[i+offset];
    x=exGrayBinario(x);
    float a2,a1;
    switch(i){
        case 0:{//BL
            a2=-3;
            a1=-5;
        break;
        }
        case 1:{//BL
            a2=-1;
            a1=-3;
        break;
        }
        case 2:{//BL
            a2=1;
            a1=-1;
        break;
        }
        case 3:{//BL
            a2=3;
            a1=1;
        break;
        }
        case 4:{//BL
            a2=5;
            a1=3;
        break;
        }

    }

    blocal[i]=((a2-a1)*(float)x/255.0)+a1;// Mapear 0->-5, 255->+5
    }

    offset=5;
  for(int i=0;i<5;i++){//clocal
    unsigned int x = cromosoma[i+offset];
    x=exGrayBinario(x);
    clocal[i]=(4.9*(float)x/255.0)+0.1;// Mapear 0->0, 255->10
    }
    offset=10;
  for(int i=0;i<15;i++){//wlocal
    unsigned int x = cromosoma[i+offset];
    x=exGrayBinario(x);
    wlocal[i]=((float)x/255.0);// Mapear 0->0, 255->1
    }
    offset=25;
  for(int i=0;i<5;i++){//bvis
    unsigned int x = cromosoma[i+offset];
    x=exGrayBinario(x);
    float a2,a1;
    switch(i){
        case 0:{//BL
            a2=-3;
            a1=-5;
        break;
        }
        case 1:{//BL
            a2=-1;
            a1=-3;
        break;
        }
        case 2:{//BL
            a2=1;
            a1=-1;
        break;
        }
        case 3:{//BL
            a2=3;
            a1=1;
        break;
        }
        case 4:{//BL
            a2=5;
            a1=3;
        break;
        }

    }

    bvis[i]=((a2-a1)*(float)x/255.0)+a1;// Mapear 0->-5, 255->+5
    }

    offset=30;
  for(int i=0;i<5;i++){//cvis
    unsigned int x = cromosoma[i+offset];
    x=exGrayBinario(x);
    cvis[i]=(4.9*(float)x/255.0)+0.1;// Mapear 0->0, 255->10
    }
    offset=35;
  for(int i=0;i<15;i++){//wvis
    unsigned int x = cromosoma[i+offset];
    x=exGrayBinario(x);
    wvis[i]=((float)x/255.0);// Mapear 0->0, 255->1
    }
    offset=50;
for(int i=0;i<5;i++){//bdir
    unsigned int x = cromosoma[i+offset];
    x=exGrayBinario(x);
    float a2,a1;
    switch(i){
        case 0:{//BL
            a2=-3;
            a1=-5;
        break;
        }
        case 1:{//BL
            a2=-1;
            a1=-3;
        break;
        }
        case 2:{//BL
            a2=1;
            a1=-1;
        break;
        }
        case 3:{//BL
            a2=3;
            a1=1;
        break;
        }
        case 4:{//BL
            a2=5;
            a1=3;
        break;
        }

    }

    bunion[i]=((a2-a1)*(float)x/255.0)+a1;// Mapear 0->-5, 255->+5
    }


    offset=55;
  for(int i=0;i<5;i++){//cdir
    unsigned int x = cromosoma[i+offset];
    x=exGrayBinario(x);
    cunion[i]=(4.9*(float)x/255.0)+0.1;// Mapear 0->0, 255->10
    }
    offset=60;
  for(int i=0;i<15;i++){//wdir
    unsigned int x = cromosoma[i+offset];
    x=exGrayBinario(x);
    wunion[i]=((float)x/255.0);// Mapear 0->0, 255->1
    }

    //For de los Ejemplos
    for(int i=0;i<NumEjemplos;i++){
        for(int ind=0;ind<5;ind++){
            xsel[ind]=xlocal[i][ind];
            }
        float yl=ylocal();

        for(int ind=0;ind<5;ind++){
            xsel[ind]=xvis[i][ind];
            }
        float yv=yvis();
        xsel[0]=xdir[i][0];
        xsel[1]=xdir[i][1];
        xsel[2]=yl;
        xsel[3]=yv;
        float yu=yunion();
        int res=Resultados[i];
        float error=(float)(res-(int)yu);
        error_acum+=pow(error,2);
    }
    error_acum=error_acum/(NumEjemplos);
    float fitness=1/(1+error_acum);
	return fitness;
}

float encontrar_y(float md1,float md2,float md3,float md4,float md5){
    float y=(y1*md1+y2*md2+y3*md3+y4*md4+y5*md5)/(md1+md2+md3+md4+md5);
    return y;
}

float membresia(int x,float b,float c){
    float a=((float)x-b)/(c+0.0001);
    float m=1.0/(1.0+pow(a,2));
    return m;
}

float ylocal(void){
    float w,b,c,mj,minimo,mdd[3],maximo,md[5];
    int tij,indice=0,yl;

    for(int i=0;i<15;i++){
        indice++;
        w=wlocal[i];
        minimo=10000;
        for(int j=0;j<5;j++){
            tij=tabla1[i][j]-1;//Se pone -1 para que el indice coincida con los arreglos b y c
            b=blocal[tij];
            c=clocal[tij];
            mj=membresia(xsel[j],b,c);
            minimo=fmin(minimo,mj);
        }
       mdd[(indice-1)%3]=w*minimo;
       if(indice%3==0){
       maximo=mdd[0];
       maximo=fmax(maximo,mdd[1]);
       maximo=fmax(maximo,mdd[2]);
       md[i/3]=maximo;
       }
    }
    float y=encontrar_y(md[0],md[1],md[2],md[3],md[4]);
    yl=y;
    return yl;
}

float yvis(void){
    float w,b,c,mj,minimo,mdd[3],maximo,md[5];
    int tij,indice=0,yv;

    for(int i=0;i<15;i++){
        indice++;
        w=wvis[i];
        minimo=10000;
        for(int j=0;j<5;j++){
            tij=tabla1[i][j]-1;//Se pone -1 para que el indice coincida con los arreglos b y c
            b=bvis[tij];
            c=cvis[tij];
            mj=membresia(xsel[j],b,c);
            minimo=fmin(minimo,mj);
        }
       mdd[(indice-1)%3]=w*minimo;
       if(indice%3==0){
       maximo=mdd[0];
       maximo=fmax(maximo,mdd[1]);
       maximo=fmax(maximo,mdd[2]);
       md[i/3]=maximo;
       }
    }
    float y=encontrar_y(md[0],md[1],md[2],md[3],md[4]);
    yv=y;
    return yv;
}

float yunion(void){
    float w,b,c,mj,minimo,mdd[3],maximo,md[5];
    int tij,indice=0,yu;

    for(int i=0;i<15;i++){
        indice++;
        w=wunion[i];
        minimo=10000;
        for(int j=0;j<4;j++){
            tij=tabla2[i][j]-1;//Se pone -1 para que el indice coincida con los arreglos b y c
            b=bunion[tij];
            c=cunion[tij];
            mj=membresia(xsel[j],b,c);
            minimo=fmin(minimo,mj);
        }
       mdd[i%3]=w*minimo;
       if(indice%3==0){
       maximo=mdd[0];
       maximo=fmax(maximo,mdd[1]);
       maximo=fmax(maximo,mdd[2]);
       md[i/3]=maximo;
       }
    }
    float y=encontrar_y(md[0],md[1],md[2],md[3],md[4]);
    yu=y;
    return yu;

}

void leerEjemplos(char* datosPartido){

FILE *file = fopen (datosPartido, "r" );
    if ( file != NULL )
    {
   for (int i=0;i<NumEjemplos;i++) /* read a line */
    {
        for(int par=0;par<NumParametros;par++){
    fscanf(file,"%d",&Ejemplos[i][par]);
        }
    for(int p=0;p<5;p++){
    xlocal[i][p]=Ejemplos[i][p];
    }
    for(int p=0;p<5;p++){
    xvis[i][p]=Ejemplos[i][p+5];
    }
    for(int p=0;p<2;p++){
    xdir[i][p]=Ejemplos[i][p+10];
    }
    Resultados[i]=(int)Ejemplos[i][12];
    }
    fclose ( file );
    }
    else
    {
    perror ( datosPartido );
    }


}

void leerTablas(void){
    FILE *file = fopen (dirTabla1, "r" );
    if ( file != NULL )
    {
   for (int i=0;i<15;i++) /* read a line */
    {
        for(int par=0;par<6;par++){
    fscanf(file,"%d",&tabla1[i][par]);
        }

    }
    fclose ( file );
    }
    else
    {
    perror ( dirTabla1 );
    }
    FILE *file2 = fopen (dirTabla2, "r" );
    if ( file != NULL )
    {
   for (int i=0;i<15;i++) /* read a line */
    {
        for(int par=0;par<5;par++){
    fscanf(file2,"%d",&tabla2[i][par]);
        }

    }
    fclose ( file2 );
    }
    else
    {
    perror ( dirTabla2 );
    }


}

void aplicarAG(void){
    srand ( time(NULL) ); //uso semilla inicial aleatoria, diferente
	//configuro el AG
	ag.usarElitismo=true;
	//ag.usarElitismo=false;
	ag.PoblacionAleatoria(POBLACION,NBYTES); //configuro una poblacion de tamaño dado, con nBytes por cromosoma (individuo)
    ag.dTasaMutacion = 0.0075; //tasa de mutacion de 0 a 1
	ag.FuncionEvaluacion(nuestra_funcion); //defino cual es la funcion que evalua cada cromosoma y devuelve el fitnes entre 0 y 1 (Es llamada automaticamante por al AG
	CLASECromosoma *mejor; //CREO UN APUNTADOR al mejor individuo
	int contador = 0;
	float mejor_anterior=0.0,fp;
	int Espera=0;

 do
   {
       if (contador%10==0){//Elige NumMiniEjem aleatorios para entrenar cada 10 iteraciones
            for(int i=0;i<NumMiniEjem;i++){
              int r=rand()%NumEjemplos;
              for(int f=0;f<5;f++){
              xlocalmini[i][f]=xlocal[r][f];
              xvismini[i][f]=xvis[r][f];
              }
              xdirmini[i][0]=xdir[r][0];
              xdirmini[i][1]=xdir[r][1];
            }
       }

 		ag.Generacion(); //creo una nueva generacion de individuos
		mejor = ag.SeleccionarMejor(); //obtengo el apuntador al mejor
        printf("Fitness:%.4f\tEspera:%d\tContador:%d\t%.4f %.4f %.4f %.4f %.4f %.4f\n",mejor->Fitness(),Espera,contador,blmejor[0],clmejor[0],wlmejor[0],bvmejor[0],cvmejor[0],wvmejor[0]);
        if((mejor->Fitness()-mejor_anterior)>umbral){
		Espera=0;
		mejor_anterior=mejor->Fitness();
		for(int m=0;m<5;m++){
		blmejor[m]=blocal[m];
		clmejor[m]=clocal[m];
		bvmejor[m]=bvis[m];
		cvmejor[m]=cvis[m];
		bumejor[m]=bunion[m];
		cumejor[m]=cunion[m];}
		for(int m=0;m<15;m++){
		wlmejor[m]=wlocal[m];
		wvmejor[m]=wvis[m];
		wumejor[m]=wunion[m];
		}
		}
		fp=ag.Fitness();

		Espera++;
		contador++;
   }
   while (contador<25000&&Espera<500); //condicion de parada el fitness de la mejor solucion
    printf("%.4f\n",mejor_anterior);

}
