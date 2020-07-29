#define LPT1 0x378

#ifdef WIN32
	#include <windows.h>
	extern "C" void _stdcall Out32(short a, short d);
	extern "C" short Inp32(short a);
#else
	#include <fcntl.h>
	#include <unistd.h>
	#include <linux/parport.h>
	#include <linux/ppdev.h>
	#include <sys/ioctl.h>
	#include <sys/stat.h>
	#include <sys/types.h>
	#include <stdio.h>
	static int puertoFD;
	
	void Out32(short a, short d){
		char dataL = d;
		
		if(a == LPT1){
			ioctl(puertoFD, PPWDATA, &dataL);
		}else if(a == LPT1+2){
			ioctl(puertoFD, PPWCONTROL, &dataL);
		}
	}
#endif

#include <string>
#include "puerto.h"
#include "graficos.h"
#include "font.h"
using namespace std;

int leds[8*8] = {0};
bool threadFin = false;

static unsigned char valorControl = 0;

static void cambiarControl(){
	//Actualiza los pines del puerto
	Out32(LPT1+2, valorControl);
}
static void clk(unsigned char v){
	//Cambia el valor de la señal de CLOCK
	if(v)
		valorControl &= ~(unsigned char)1;
	else	
		valorControl |= 1;
}
static void data1(unsigned char v){
	//Cambia el valor de la señal de DATA_R
	if(!v)
		valorControl &= ~(unsigned char)2;
	else	
		valorControl |= 2;
	
}
static void data2(unsigned char v){
	//Cambia el valor de la señal de DATA_V
	if(!v)
		valorControl |= 4;
	else	
		valorControl &= ~(4);
	
}
static void cargarShift(unsigned char val){
	//Carga un bit en los dos shift registers
	
	data1(val&2);
	data2(val&1);
	cambiarControl();
		
	clk(1);
	cambiarControl();
	clk(0);
	cambiarControl();
}

int estadoActual = 0;

void calcularEstado(){
	#ifndef WIN32
		int val; 
		ioctl(puertoFD, PPRSTATUS, &val);
		val^=PARPORT_STATUS_BUSY; 
	
		int busy = !(val & PARPORT_STATUS_BUSY);
		int ack = !(val & PARPORT_STATUS_ACK);
		int error = !(val & PARPORT_STATUS_ERROR);
		int paperout = !(val & PARPORT_STATUS_PAPEROUT);
	#else
		int val = Inp32(LPT1+1); 
		val^=0x80; 
	
		int busy = !(val & 0x80);
		int ack = !(val & 0x40);
		int error = !(val & 0x8);
		int paperout = !(val & 0x20);
	#endif
	
	/*
	Cambia el estado de acuerdo a los contactos detectados
	paperout + ack -> abajo
	busy + ack -> izq
	busy + error -> arriba
	error + paperout -> der*/
	
	if(paperout && ack) 	estadoActual = 0;
	if(busy && ack) 		estadoActual = 1;
	if(busy && error) 		estadoActual = 2;
	if(paperout && error) 	estadoActual = 3;
}

static void actualizarFila(){
	static int fila = 0;
	unsigned char val = ~(1<<fila);
	Out32(LPT1, 0xFF); //Apagamos todas las filas
	
	for(int columna=0;columna<8;columna++){
		switch(estadoActual){ //Cargamos valores de cada columna (Depende de la rotación elegida)
			case 0:
				cargarShift(leds[(fila)+(columna)*8]); //Abajo (rotación original)
				break;		
			case 1:
				cargarShift(leds[(7-columna)+fila*8]); //Izquierda (90º horario)
				break;
			case 2:
				cargarShift(leds[(7-fila)+(7-columna)*8]); //Arriba (180º)
				break;
			case 3:
				cargarShift(leds[columna+(7-fila)*8]); //Derecha (90º antihorario)
				break;
		}
	}
	
	Out32(LPT1, val); //Activamos la fila actual
			
	fila++;
	if(fila == 8) fila = 0;
}
int threadLeds(void *arg){
	int frame=0;
	inicializarPuerto();
	
	#ifdef WIN32
		//Permite hacer Sleeps más cortos
		timeBeginPeriod(1);
	#endif
	
	while(!threadFin){
		actualizarFila();
		calcularEstado();
		
		#ifdef WIN32
			Sleep(3);
		#else
			usleep(3000);
		#endif
		
		frame++;
		if(frame%(8*4)==0 && mostrarTexto) ledsAvanzarTexto();
	}
	
	#ifdef WIN32
		timeEndPeriod(1);
	#endif
	
	cerrarPuerto();
	return 0;
}

string textoAMostrar = "Hola FIUBA";
static int textoDsp = 0, textoIdx = 0;	
bool mostrarTexto = true;

void ledsAvanzarTexto(){
	///TODO: Arreglar: si hay un solo caracter anda mal
	if(textoAMostrar.size() <= 1) return; 
	
	//Actualizamos el buffer de acuerdo a las letras
	for(int y=0;y<8;y++)
	for(int x=0;x<8;x++){
		unsigned char letra = textoAMostrar[textoIdx], letraSiguiente = textoAMostrar[textoIdx+1];
		
		//Letra actual
		leds[y*8+(7-x)] =(font[letra*8+y]>>(x-textoDsp)) & 1;
		
		//Letra siguiente
		leds[y*8+(7-x)]|=(font[letraSiguiente*8+y]>>(x-textoDsp+8)) & 1;
		
		//Cambiamos el color al elegido
		leds[y*8+(7-x)]*=colorElegido[0];
	}
	
	//Pasamos a la siguiente posición
	textoDsp++;
	if(textoDsp==8){
		//Pasamos al siguiente caracter
		textoDsp=0;
		textoIdx++;
		textoIdx %= textoAMostrar.size();
	}
}

int inicializarPuerto(){
	#ifndef WIN32
		puertoFD = open("/dev/parport0", O_RDWR);
		if(puertoFD < 0){
			fprintf(stderr,"Error abriendo puerto paralelo (open).\n");
			return -1;
		}
		if(ioctl(puertoFD, PPCLAIM, NULL)){
			fprintf(stderr,"Error pidiendo puerto paralelo.\n");
			close(puertoFD);
			return -1;
		}
		int modo = IEEE1284_MODE_ECP;
		if(ioctl(puertoFD, PPSETMODE, &modo)){
			fprintf(stderr,"Error estableciendo modo.\n");
			ioctl(puertoFD, PPRELEASE);
			close(puertoFD);
			return -1;
		}
		
		//Puerto de datos como salida
		int modoSalida=0x00; 
		ioctl(puertoFD, PPDATADIR, &modoSalida);
	#endif
	return 0;
}
void cerrarPuerto(){
	#ifndef WIN32
		ioctl(puertoFD, PPRELEASE);
		close(puertoFD);
	#endif
}