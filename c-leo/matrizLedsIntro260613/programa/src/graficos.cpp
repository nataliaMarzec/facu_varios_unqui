#include "puerto.h"
#include "font.h"
#include <cstdlib>

#ifndef SININTERFAZ
	#include <SDL/SDL.h>
	#include <SDL/SDL_image.h>

	static SDL_Surface *pantalla = NULL, *ledImg = NULL;
	static SDL_Thread *tLeds = NULL;
	static int frame = 0;

	//Ubicaciones y tamaños de los objetos
	const int XPALETA = 8*64+16;
	const int YPALETA = 8;
	const int WPALETA = 64;
	const int HPALETA = 64*4;
	const int DLED = 64;
	const int XLEDS = 8, YLEDS = 8;
	const int ANCHOPANTALLA = 600;
	const int ALTOPANTALLA = 64*8+3*16;
	
	const int XBOTON = 16;
	const int YBOTON = DLED*8+16;
	const int WBOTON = 16;
	const int HBOTON = 16;

	const int XTEXTO = 16+32;
	const int YTEXTO = DLED*8+16;
	const int WTEXTO = 480;
	const int HTEXTO = 16;
	
	static int botonApretado = 0;
	
	inline void setPixel(SDL_Surface * surface, int x, int y, Uint32 color){
		if(x<0 || x>=surface->w || y<0 || y>=surface->h) return;
		Uint8 * pixel = (Uint8*)surface->pixels;
		pixel += (y * surface->pitch) + (x * sizeof(Uint32));
		*((Uint32*)pixel) = color;
	}
	
#endif

	//Colores de la paleta (click izquierdo, click derecho)
	int colorElegido[2] = {1,0};

int inicializarGraficos(){
	#ifndef SININTERFAZ
		if(SDL_Init(SDL_INIT_EVERYTHING) < 0){
			fprintf(stderr, "Error inicializando SDL: %s\n", SDL_GetError());
			return -1;
		}
		atexit(SDL_Quit);
		
		pantalla = SDL_SetVideoMode(ANCHOPANTALLA,ALTOPANTALLA,32,SDL_SWSURFACE);
		if(!pantalla){
			fprintf(stderr, "Error creando ventana: %s\n", SDL_GetError());
			return -1;
		}
		SDL_WM_SetCaption("Matriz de LEDs",NULL);
		
		ledImg = IMG_Load("res/leds.png");
		if(!ledImg){
			fprintf(stderr, "Error cargando leds: %s\n", IMG_GetError());
			return -1;
		}
		tLeds = SDL_CreateThread(threadLeds, NULL);
		
		SDL_WM_SetCaption("Matriz de LEDs - Introduccion a la Ing Electronica", NULL);
		SDL_EnableUNICODE( SDL_ENABLE );
		SDL_EnableKeyRepeat(SDL_DEFAULT_REPEAT_DELAY, SDL_DEFAULT_REPEAT_INTERVAL);
	#else
		threadLeds(NULL);
	#endif
	return 0;
}

void finGraficos(){
	#ifndef SININTERFAZ
		threadFin = true;
		SDL_WaitThread(tLeds, NULL); //Esperamos a que el hilo termine
	#endif
}
void proximoFrame(){
	#ifndef SININTERFAZ
		SDL_Flip(pantalla);
		SDL_Delay(1000/60); /*~60fps*/
		frame++;
		SDL_FillRect(pantalla,NULL,0x00FFFFFF); //Pintar todo de blanco
	#endif
}

void dibujarLeds(){
	#ifndef SININTERFAZ
		for(int y=0;y<8;y++)
		for(int x=0;x<8;x++){			
			SDL_Rect rectdst, rectsrc;
			rectdst.x = x*DLED+8;
			rectdst.y = y*DLED+8;
			rectdst.w = DLED;
			rectdst.h = DLED;
			
			rectsrc.x = 0;
			rectsrc.y = leds[y*8+x]*DLED;
			rectsrc.w = DLED;
			rectsrc.h = DLED;
				
			SDL_BlitSurface(ledImg, &rectsrc, pantalla, &rectdst);
		}
	#endif
}
void dibujarPaleta(){	
	#ifndef SININTERFAZ
		SDL_Rect rectdst;
		rectdst.x = XPALETA;
		rectdst.y = YPALETA;
		rectdst.w = WPALETA;
		rectdst.h = HPALETA;
		SDL_BlitSurface(ledImg, NULL, pantalla, &rectdst);
		
		/*Borde de botón*/
		rectdst.x = XBOTON-1;
		rectdst.y = YBOTON-1;
		rectdst.w = WBOTON+2;
		rectdst.h = HBOTON+2;
		SDL_FillRect(pantalla, &rectdst, 0);
		
		/*Parte de adentro del botón*/
		rectdst.x = XBOTON;
		rectdst.y = YBOTON;
		rectdst.w = WBOTON;
		rectdst.h = HBOTON;
		SDL_FillRect(pantalla, &rectdst, mostrarTexto * 0xFFFFFF);
	#endif
}
void dibujarTexto(){
	#ifndef SININTERFAZ
		SDL_Rect rectdst;
		
		/*Borde de cuadro*/
		rectdst.x = XTEXTO-1;
		rectdst.y = YTEXTO-1;
		rectdst.w = WTEXTO+2;
		rectdst.h = HTEXTO+2;
		SDL_FillRect(pantalla, &rectdst, 0);
		
		/*Parte de adentro del cuadro de texto*/
		rectdst.x = XTEXTO;
		rectdst.y = YTEXTO;
		rectdst.w = WTEXTO;
		rectdst.h = HTEXTO;
		SDL_FillRect(pantalla, &rectdst, 0xFFFFFF);
		
		/*Texto del cuadrito*/
		for(unsigned int i=0;i<textoAMostrar.size();i++){
			unsigned char caracter = textoAMostrar[i];
			
			for(int y=0;y<8;y++)
			for(int x=0;x<8;x++){
				unsigned char val = font[caracter*8+y] & (1<<(7-x));
				setPixel(pantalla, XTEXTO+x+i*8+4, YTEXTO+y+4, val?0:0xFFFFFF);
			}
		}
	#endif
}

bool manejarEventos(){
	#ifndef SININTERFAZ
		SDL_Event event;
		
		while(SDL_PollEvent(&event)){
			if(event.type == SDL_QUIT) return true;
			if(event.type == SDL_KEYDOWN){
				if(event.key.keysym.sym == SDLK_ESCAPE) return true;
				if(textoAMostrar.size()<=70){
					//Hay espacio para un caracter más
					if(event.key.keysym.unicode >= 32){
						//Caracter imprimible, lo agregamos al string
						unsigned char cod = event.key.keysym.unicode;
						textoAMostrar += cod;
						/*textoAMostrar += (cod/100)+'0';    
						textoAMostrar += ((cod/10)%10)+'0';    
						textoAMostrar += (cod%10)+'0';    */
					}
				}
				if(event.key.keysym.sym == SDLK_BACKSPACE && textoAMostrar.size()!=0){
					//Borramos el último caracter
					textoAMostrar.erase(textoAMostrar.size()-1);
				}
			}
			if(event.type == SDL_MOUSEBUTTONDOWN){
				if(event.button.button == SDL_BUTTON_LEFT){
					botonApretado = 1;
					if(event.button.x >= XPALETA && event.button.x <= XPALETA+WPALETA &&
					   event.button.y >= YPALETA && event.button.y <= YPALETA+HPALETA){
						//Si tocamos la paleta, cambiamos el color elegido
						colorElegido[0] = (event.button.y - YPALETA)/DLED;
					}
					if(event.button.x >= XBOTON && event.button.x <= XBOTON+WBOTON &&
					   event.button.y >= YBOTON && event.button.y <= YBOTON+HBOTON){
					   //Si tocamos el botón, pasamos al otro estado
						mostrarTexto = !mostrarTexto;
					}
					
				}
				else if(event.button.button == SDL_BUTTON_RIGHT)
					botonApretado = 2;	
			}
			if(event.type == SDL_MOUSEBUTTONUP)
				botonApretado = 0;
				
			if(botonApretado != 0){
				int posX = event.motion.x-XLEDS; 
				int posY = event.motion.y-YLEDS; 	
				
				if(posX >= 0 && posX<DLED*8 && posY >= 0 && posY<DLED*8){
					//Botón presionado dentro de LEDs
					int celdaX = posX/DLED;
					int celdaY = posY/DLED;
					
					if(botonApretado == 1){
						leds[celdaY*8+celdaX] = colorElegido[0];
					}else if(botonApretado == 2){
						leds[celdaY*8+celdaX] = colorElegido[1];
					}
				}
			}
		}
	#endif
	return false;
}
