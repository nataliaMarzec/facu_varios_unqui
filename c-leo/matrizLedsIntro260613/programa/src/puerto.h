#include <string>
using namespace std;

#ifndef LEDS_H
#define LEDS_H

extern int leds[8*8];
extern int threadLeds(void *arg);
extern bool threadFin;
extern bool mostrarTexto;
extern string textoAMostrar;

void ledsAvanzarTexto();
int inicializarPuerto();
void cerrarPuerto();

#endif
