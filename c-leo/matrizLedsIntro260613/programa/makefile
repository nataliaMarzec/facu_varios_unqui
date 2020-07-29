all:
	g++ src/main.cpp src/puerto.cpp src/graficos.cpp -o matriz.exe -Wall -lmingw32 -lsdlmain -lsdl -lsdl_image -mwindows -static-libgcc -static-libstdc++ -linpout32 -lWinmm

fast:
	g++ src/main.cpp src/puerto.cpp src/graficos.cpp -o matriz.exe -Wall -DSININTERFAZ -static-libgcc -static-libstdc++ -linpout32 -lWinmm
	
run:
	matriz
	
clean:
	del matriz.exe
	
.PHONY: run fast clean