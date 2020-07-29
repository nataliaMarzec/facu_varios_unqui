#include "graficos.h"
#include "puerto.h"

int main(int argc, char **args){
	bool fin=false;
	
	if(inicializarGraficos()) return -1;

	while(!fin){
		fin = manejarEventos();
	
		dibujarLeds();
		dibujarPaleta();
		dibujarTexto();
			
		proximoFrame();
	}
	
	finGraficos();
	return 0;
}
