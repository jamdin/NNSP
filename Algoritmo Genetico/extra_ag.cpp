//extra_ag.cpp
/*
 Coleccion de funciones extras utiles en la implementacion de algoritmos geneticos con 'clase_ag'
*/

#include<stdio.h>
#include<stdlib.h>


//funcion que convierte de binario a gray (1 byte)
unsigned char exBinarioGray(unsigned char);
//funcion que convierte de gray a binario (1 byte)
unsigned char exGrayBinario(unsigned char);
/*
int main()
{
    unsigned char gray=0x0F;
    unsigned char bin;
    int k=0;

printf ("-");
int i;
for (i=0; i<256;i++)
    {
    /*****************CORE*******************

        printf ("\n%X\t%X\t%X\t%X", (unsigned char) i, exBinarioGray(i), exGrayBinario(exBinarioGray(i)), exBinarioGray(exGrayBinario(exBinarioGray(i))));
    }
printf ("\n-------------------");
printf ("\n-------------------");
}
*/
//funcion que convierte de binario a gray (1 byte)
unsigned char exBinarioGray(unsigned char bin)
{
        return bin^(bin>>1); //BIN XOR (BIN>>1)
}
//funcion que convierte de gray a binario (1 byte)
unsigned char exGrayBinario(unsigned char gray)
{
    unsigned char bin=gray^(gray>>1);
    for(register int k=2;k<8;k++) bin=bin^(gray>>k);
    return bin;
}
