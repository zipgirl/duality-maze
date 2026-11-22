//--- --- --- --- --- --- DEFINICION DE FUNCIONES
	.global inputRead
	//lee botones en el GPIO
//--- --- --- --- --- --- FIN DEFINICION DE FUNCIONES

inputRead:
	ldr w22,[x20,GPIO_GPLEV0]	//Leer registro GPIO Pin Level 0 y guardar en X22
	br x30						//Volver a la instruccion link