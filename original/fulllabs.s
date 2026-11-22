//--- --- --- --- --- --- DEFINICION DE FUNCIONES
    .extern paredes
    .extern trigger

    .global laberinto
    // dibuja el laberinto original

    .global evil_laberinto
    // dibuja el laberinto alternativo

    .global draw_triggers
    // dibuja los triggers de cambio y la meta
//--- --- --- --- --- --- FIN DEFINICION DE FUNCIONES

laberinto: //------------------------------------------------------------------------------------------------------------------------------
    mov x29, x30                // guarda x30 en X29
    
    // Encender led rojo y apagar led verde
	mov w21, #0x04
	str w21, [x20, #0x1C] //enciendo rojo

	mov w21, 0x08
	str w21, [x20, 0x28] //apago verde
	
	mov w3, 0xFFFF    	// 0xFFFF = Blanco
	add x10, x0, 0		// X10 Contiene la dirección base del framebuffer
	
	mov x2,512         	// Tamaño en Y
fondo1:
	mov x1,512         	// Tamaño en X	
fondo2:
	sturh w3,[x10]	   	// Setear el color del pixel N
	add x10,x10,2	   	// Siguiente pixel
	sub x1,x1,1	   	// Decrementar el contador X
	cbnz x1,fondo2	   	// Si no terminó la fila, volver a pintar
	sub x2,x2,1	   	// Decrementar el contador Y
	cbnz x2,fondo1	  	// Si no es la última fila, saltar

	mov w3,0xFA52         // Setear color de paredes, fucsia

	//tope de tablero
	mov x4,0		// Inicio de la figura, argumento inicio x
	mov x5,512		// Posicion final x
	mov x6,0		// Posicion inicio y
	mov x7,16		// Posicion final y
	bl paredes		// Ir a la funcion paredes	
	//izq tablero
	mov x4,0
	mov x5,16
	mov x6,0
	mov x7,512
	bl paredes
	//base tablero
	mov x4,0
	mov x5,512
	mov x6,496
	mov x7,512
	bl paredes
	//der tablero
	mov x4,496
	mov x5,512
	mov x6,0
	mov x7,512
	bl paredes
	
	mov x4,32
	mov x5,48
	mov x6,16
	mov x7,112
	bl paredes
	
	mov x4,16
	mov x5,48
	mov x6,128
	mov x7,144
	bl paredes

	mov x4,32
	mov x5,48
	mov x6,144
	mov x7,336
	bl paredes

	mov x4,176
	mov x5,192
	mov x6,336
	mov x7,352
	bl paredes
	
	mov x4,48
	mov x5,64
	mov x6,320
	mov x7,336
	bl paredes
	
	mov x4,16
	mov x5,64
	mov x6,352
	mov x7,368
	bl paredes
	
	mov x4,32
	mov x5,64
	mov x6,368
	mov x7,416
	bl paredes
	
	mov x4,32
	mov x5,48
	mov x6,416
	mov x7,480
	bl paredes
	
	mov x4,48
	mov x5,224
	mov x6,464
	mov x7,480
	bl paredes
	
	mov x4,64
	mov x5,192
	mov x6,432
	mov x7,448
	bl paredes
	
	mov x4,176
	mov x5,192
	mov x6,368
	mov x7,432
	bl paredes
	
	mov x4,160
	mov x5,176
	mov x6,368
	mov x7,384
	bl paredes
	
	mov x4,240
	mov x5,256
	mov x6,416
	mov x7,480
	bl paredes

	mov x4,256
	mov x5,384
	mov x6,464
	mov x7,480
	bl paredes
	
	mov x4,400
	mov x5,464
	mov x6,464
	mov x7,480
	bl paredes
	
	mov x4,448
	mov x5,464
	mov x6,240
	mov x7,464
	bl paredes
	
	mov x4,464
	mov x5,480
	mov x6,240
	mov x7,256
	bl paredes
	
	mov x4,432
	mov x5,448
	mov x6,352
	mov x7,368
	bl paredes
	
	mov x4,480
	mov x5,496
	mov x6,272
	mov x7,496
	bl paredes

	mov x4,48
	mov x5,208
	mov x6,96
	mov x7,112
	bl paredes

	mov x4,64
	mov x5,80
	mov x6,112
	mov x7,304
	bl paredes

	mov x4,80
	mov x5,128
	mov x6,272
	mov x7,288
	bl paredes

	mov x4,80
	mov x5,96
	mov x6,288
	mov x7,384
	bl paredes

	mov x4,80
	mov x5,112
	mov x6,384
	mov x7,416
	bl paredes
	
	mov x4,128
	mov x5,144
	mov x6,224
	mov x7,416
	bl paredes

	mov x4,112
	mov x5,128
	mov x6,288
	mov x7,304
	bl paredes

	mov x4,144
	mov x5,160
	mov x6,400
	mov x7,416
	bl paredes

	mov x4,368
	mov x5,400
	mov x6,336
	mov x7,416
	bl paredes

	mov x4,400
	mov x5,416
	mov x6,336
	mov x7,352
	bl paredes

	mov x4,240
	mov x5,256
	mov x6,336
	mov x7,400
	bl paredes

	mov x4,272
	mov x5,352
	mov x6,336
	mov x7,352
	bl paredes

	mov x4,272
	mov x5,352
	mov x6,400
	mov x7,416
	bl paredes

	mov x4,336
	mov x5,352
	mov x6,352
	mov x7,400
	bl paredes

	mov x4,272
	mov x5,320
	mov x6,368
	mov x7,384
	bl paredes

	mov x4,272
	mov x5,432
	mov x6,432
	mov x7,448
	bl paredes

	mov x4,416
	mov x5,432
	mov x6,368
	mov x7,432
	bl paredes

	mov x4,208
	mov x5,224
	mov x6,320
	mov x7,448
	bl paredes

	mov x4,160
	mov x5,288
	mov x6,304
	mov x7,320
	bl paredes

	mov x4,160
	mov x5,176
	mov x6,320
	mov x7,352
	bl paredes

	mov x4,336
	mov x5,352
	mov x6,176
	mov x7,192
	bl paredes

	mov x4,64
	mov x5,240
	mov x6,32
	mov x7,48
	bl paredes

	mov x4,64
	mov x5,240
	mov x6,64
	mov x7,80
	bl paredes

	mov x4,320
	mov x5,480
	mov x6,64
	mov x7,80
	bl paredes

	mov x4,288
	mov x5,480
	mov x6,32
	mov x7,48
	bl paredes

	mov x4,224
	mov x5,240
	mov x6,48
	mov x7,144
	bl paredes

	mov x4,256
	mov x5,304
	mov x6,80
	mov x7,96
	bl paredes

	mov x4,288
	mov x5,400
	mov x6,96
	mov x7,112
	bl paredes

	mov x4,112
	mov x5,208
	mov x6,128
	mov x7,144
	bl paredes

	mov x4,208
	mov x5,224
	mov x6,128
	mov x7,144
	bl paredes

	mov x4,256
	mov x5,304
	mov x6,128
	mov x7,144
	bl paredes

	mov x4,336
	mov x5,368
	mov x6,128
	mov x7,144
	bl paredes

	mov x4,112
	mov x5,144
	mov x6,160
	mov x7,176
	bl paredes

	mov x4,160
	mov x5,272
	mov x6,160
	mov x7,176
	bl paredes

	mov x4,112
	mov x5,160
	mov x6,192
	mov x7,208
	bl paredes

	mov x4,192
	mov x5,272
	mov x6,192
	mov x7,208
	bl paredes

	mov x4,448
	mov x5,480
	mov x6,80
	mov x7,160
	bl paredes

	mov x4,464
	mov x5,480
	mov x6,160
	mov x7,224
	bl paredes

	mov x4,416
	mov x5,432
	mov x6,96
	mov x7,192
	bl paredes

	mov x4,432
	mov x5,448
	mov x6,176
	mov x7,192
	bl paredes

	mov x4,416
	mov x5,432
	mov x6,256
	mov x7,336
	bl paredes

	mov x4,384
	mov x5,400
	mov x6,112
	mov x7,240
	bl paredes

	mov x4,384
	mov x5,400
	mov x6,288
	mov x7,320
	bl paredes

	mov x4,352
	mov x5,368
	mov x6,144
	mov x7,208
	bl paredes

	mov x4,352
	mov x5,368
	mov x6,288
	mov x7,320
	bl paredes

	mov x4,320
	mov x5,336
	mov x6,16
	mov x7,32
	bl paredes

	mov x4,320
	mov x5,336
	mov x6,160
	mov x7,240
	bl paredes

	mov x4,320
	mov x5,336
	mov x6,256
	mov x7,288
	bl paredes

	mov x4,288
	mov x5,304
	mov x6,48
	mov x7,80
	bl paredes

	mov x4,288
	mov x5,304
	mov x6,160
	mov x7,256
	bl paredes

	mov x4,256
	mov x5,272
	mov x6,16
	mov x7,64
	bl paredes

	mov x4,256
	mov x5,272
	mov x6,96
	mov x7,112
	bl paredes

	mov x4,256
	mov x5,272
	mov x6,208
	mov x7,256
	bl paredes

	mov x4,224
	mov x5,240
	mov x6,224
	mov x7,256
	bl paredes

	mov x4,192
	mov x5,208
	mov x6,208
	mov x7,288
	bl paredes

	mov x4,160
	mov x5,176
	mov x6,192
	mov x7,288
	bl paredes

	mov x4,224
	mov x5,304
	mov x6,272
	mov x7,288
	bl paredes

	mov x4,304
	mov x5,352
	mov x6,304
	mov x7,320
	bl paredes

	mov x4,336
	mov x5,416
	mov x6,256
	mov x7,272
	bl paredes

	mov x4,336
	mov x5,384
	mov x6,224
	mov x7,240
	bl paredes

	mov x4,416
	mov x5,448
	mov x6,208
	mov x7,240
	bl paredes

	mov x4,96
	mov x5,112
	mov x6,128
	mov x7,256
	bl paredes

	mov x4,64
	mov x5,80
	mov x6,48
	mov x7,64
	bl paredes

	mov x4,96
	mov x5,112
	mov x6,320
	mov x7,336
	bl paredes

	mov x4,112
	mov x5,128
	mov x6,352
	mov x7,368
	bl paredes

	mov x4,240
	mov x5,256
	mov x6,240
	mov x7,256
	bl paredes

    br x29               //volver a la instruccion link

evil_laberinto: //----------------------------------------------------------------------------------------------------------------------------------------
    mov x29, x30                // guarda x30 en X29
    
    mov w21, #0x08
	str w21, [x20, #0x1C] //enciendo verde

	mov w21, 0x04
	str w21, [x20, 0x28] //apago rojo
	
	add x10, x0, 0		// X10 Contiene la dirección base del framebuffer

	mov w3, 0x0000    	// 0x000 = Negro
	add x10, x0, 0		// X10 Contiene la dirección base del framebuffer
	
	mov x2,512         	// Tamaño en Y
efondo1:
	mov x1,512         	// Tamaño en X	
efondo2:
	sturh w3,[x10]	   	// Setear el color del pixel N
	add x10,x10,2	   	// Siguiente pixel
	sub x1,x1,1	   	// Decrementar el contador X
	cbnz x1,efondo2	   	// Si no terminó la fila, volver a pintar
	sub x2,x2,1	   	// Decrementar el contador Y
	cbnz x2,efondo1	  	// Si no es la última fila, saltar

	mov w3,0x8DF9         // Setear color de paredes, celeste

//dibujar el laberinto lado b
	//tope de tablero
	mov x4,0		// Inicio de la figura, argumento inicio x
	mov x5,512		// Posicion final x
	mov x6,0		// Posicion inicio y
	mov x7,16		// Posicion final y
	bl paredes		// Ir a la funcion paredes	
	//izq tablero
	mov x4,0
	mov x5,16
	mov x6,0
	mov x7,512
	bl paredes
	//base tablero
	mov x4,0
	mov x5,512
	mov x6,496
	mov x7,512
	bl paredes
	//der tablero
	mov x4,496
	mov x5,512
	mov x6,0
	mov x7,512
	bl paredes

	mov x4,288
	mov x5,320
	mov x6,320
	mov x7,352
	bl paredes

	mov x4,304
	mov x5,320
	mov x6,352
	mov x7,384
	bl paredes

	mov x4,256
	mov x5,272
	mov x6,352
	mov x7,384
	bl paredes

	mov x4,272
	mov x5,304
	mov x6,368
	mov x7,384
	bl paredes

	mov x4,64
	mov x5,288
	mov x6,320
	mov x7,336
	bl paredes

	mov x4,64
	mov x5,80
	mov x6,336
	mov x7,448
	bl paredes

	mov x4,80
	mov x5,176
	mov x6,432
	mov x7,448
	bl paredes

	mov x4,160
	mov x5,176
	mov x6,384
	mov x7,432
	bl paredes

	mov x4,96
	mov x5,160
	mov x6,384
	mov x7,400
	bl paredes

	mov x4,128
	mov x5,144
	mov x6,352
	mov x7,416
	bl paredes

	mov x4,96
	mov x5,112
	mov x6,400
	mov x7,416
	bl paredes

	mov x4,96
	mov x5,128
	mov x6,352
	mov x7,368
	bl paredes

	mov x4,224
	mov x5,240
	mov x6,336
	mov x7,400
	bl paredes

	mov x4,160
	mov x5,208
	mov x6,352
	mov x7,368
	bl paredes

	mov x4,192
	mov x5,240
	mov x6,416
	mov x7,432
	bl paredes

	mov x4,192
	mov x5,208
	mov x6,368
	mov x7,416
	bl paredes

	mov x4,32
	mov x5,48
	mov x6,352
	mov x7,464
	bl paredes

	mov x4,32
	mov x5,160
	mov x6,464
	mov x7,480
	bl paredes

	mov x4,176
	mov x5,192
	mov x6,464
	mov x7,496
	bl paredes

	mov x4,240
	mov x5,256
	mov x6,480
	mov x7,496
	bl paredes

	mov x4,192
	mov x5,240
	mov x6,448
	mov x7,464
	bl paredes

	mov x4,208
	mov x5,224
	mov x6,464
	mov x7,480
	bl paredes

	mov x4,256
	mov x5,272
	mov x6,416
	mov x7,480
	bl paredes

	mov x4,272
	mov x5,384
	mov x6,464
	mov x7,480
	bl paredes

	mov x4,272
	mov x5,336
	mov x6,432
	mov x7,448
	bl paredes

	mov x4,352
	mov x5,432
	mov x6,432
	mov x7,448
	bl paredes

	mov x4,448
	mov x5,464
	mov x6,432
	mov x7,448
	bl paredes

	mov x4,400
	mov x5,416
	mov x6,464
	mov x7,496
	bl paredes

	mov x4,416
	mov x5,480
	mov x6,464
	mov x7,480
	bl paredes

	mov x4,464
	mov x5,480
	mov x6,208
	mov x7,464
	bl paredes

	mov x4,464
	mov x5,480
	mov x6,80
	mov x7,192
	bl paredes

	mov x4,464
	mov x5,480
	mov x6,16
	mov x7,64
	bl paredes

	mov x4,448
	mov x5,464
	mov x6,16
	mov x7,32
	bl paredes

	mov x4,416
	mov x5,432
	mov x6,32
	mov x7,48
	bl paredes

	mov x4,400
	mov x5,464
	mov x6,48
	mov x7,64
	bl paredes

	mov x4,384
	mov x5,400
	mov x6,16
	mov x7,48
	bl paredes

	mov x4,224
	mov x5,384
	mov x6,32
	mov x7,48
	bl paredes

	mov x4,336
	mov x5,352
	mov x6,48
	mov x7,64
	bl paredes

	mov x4,224
	mov x5,240
	mov x6,48
	mov x7,160
	bl paredes

	mov x4,240
	mov x5,256
	mov x6,48
	mov x7,80
	bl paredes

	mov x4,256
	mov x5,272
	mov x6,64
	mov x7,80
	bl paredes

	mov x4,240
	mov x5,272
	mov x6,96
	mov x7,128
	bl paredes

	mov x4,288
	mov x5,320
	mov x6,64
	mov x7,96
	bl paredes

	mov x4,352
	mov x5,400
	mov x6,80
	mov x7,112
	bl paredes

	mov x4,368
	mov x5,384
	mov x6,64
	mov x7,80
	bl paredes

	mov x4,320
	mov x5,352
	mov x6,80
	mov x7,96
	bl paredes

	mov x4,416
	mov x5,448
	mov x6,80
	mov x7,112
	bl paredes

	mov x4,448
	mov x5,464
	mov x6,96
	mov x7,112
	bl paredes

	mov x4,432
	mov x5,448
	mov x6,112
	mov x7,176
	bl paredes

	mov x4,448
	mov x5,464
	mov x6,160
	mov x7,176
	bl paredes

	mov x4,400
	mov x5,416
	mov x6,96
	mov x7,272
	bl paredes

	mov x4,432
	mov x5,448
	mov x6,192
	mov x7,272
	bl paredes

	mov x4,416
	mov x5,432
	mov x6,192
	mov x7,208
	bl paredes

	mov x4,432
	mov x5,448
	mov x6,288
	mov x7,416
	bl paredes

	mov x4,400
	mov x5,416
	mov x6,320
	mov x7,432
	bl paredes

	mov x4,368
	mov x5,384
	mov x6,320
	mov x7,416
	bl paredes

	mov x4,384
	mov x5,400
	mov x6,320
	mov x7,336
	bl paredes

	mov x4,272
	mov x5,368
	mov x6,400
	mov x7,416
	bl paredes

	mov x4,320
	mov x5,432
	mov x6,288
	mov x7,304
	bl paredes

	mov x4,272
	mov x5,288
	mov x6,368
	mov x7,384
	bl paredes

	mov x4,336
	mov x5,352
	mov x6,320
	mov x7,384
	bl paredes

	mov x4,320
	mov x5,400
	mov x6,240
	mov x7,256