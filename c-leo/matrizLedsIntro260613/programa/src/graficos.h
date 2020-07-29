#ifndef GRAFICOS_H
#define GRAFICOS_H

int inicializarGraficos();
void finGraficos();
void proximoFrame();
void dibujarLeds();
void dibujarPaleta();
void dibujarTexto();
bool manejarEventos();

extern int colorElegido[2];

#endif
