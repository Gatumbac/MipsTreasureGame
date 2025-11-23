.data
tablero: .word 0 #Puntero
infoJuego: .word 0
infoJugador: .word 0, 0, -1, 0 # cantidadTesoros, dineroAcumulado, ultimaPosicion, llegoFinal
infoMaquina: .word 0, 0, -1, 0 # cantidadTesoros, dineroAcumulado, ultimaPosicion, llegoFinal

#MENSAJES
lineaHorizontal: .asciiz "-----------------------------------------------------------------------------------------------\n"
mensajeAutores1: .asciiz "Proyecto Primer Parcial - Organización de Computadores II PAO 2025\n"
mensajeAutores2: .asciiz "Darwin Díaz - Gabriel Tumbaco - Paralelo 2\n"
mensajeBienvenida: .asciiz "¡Bienvenido al juego de las casillas!\n"
mensajeIngresoTamano: .asciiz "Ingresa el tamaño del tablero [20-120]: "
mensajeIngresoTamanoCorrecto: .asciiz "Ingresa un tamaño correcto [20-120]: "
mensajeIngresoNumeroCasillas: .asciiz "Ingrese cantidad de casillas a avanzar [1-6]: "
mensajeCasillasMaquina: .asciiz "Maquina avanza la cantidad de casillas: "
mensajeFinTablero: .asciiz  "El jugador actual llego al final del tablero\n"
mensajeTurnoJugador: .asciiz "Turno Jugador\n"
mensajeTurnoMaquina: .asciiz "Turno Maquina\n"

mensajeEstadoJuego: .asciiz "-- ESTADO DEL JUEGO --\n"
mensajeResumenJuego: .asciiz "-- RESUMEN DEL JUEGO --\n"
msgJugador: .asciiz "Jugador -> Pos: "
msgMaquina: .asciiz "Maquina -> Pos: "
msgDineroObtenido: .asciiz " | Dinero Obtenido: "
msgDineroAcumulado: .asciiz " | Dinero Acumulado: "
msgTesoros: .asciiz " | Tesoros: "

mensajeGanadorPorTesoros: .asciiz "-- GANADOR POR TESOROS --\n"
mensajeGanadorPorDinero: .asciiz "-- GANADOR POR DINERO --\n"
mensajeDesempate: .asciiz "-- DESEMPATE POR TESOROS --\n"

mensajeGanadorJugador: .asciiz "Ganador: Jugador\n"
mensajeGanadorMaquina: .asciiz "Ganador: Maquina\n"
mensajeDineroTotalGanado: .asciiz "Dinero total para el ganador: "



#PORCENTAJES
porcentajeTreinta: .float 0.3

#Cadena para pruebas
salto: .asciiz "\n"
separador: .asciiz " - "
 
.text
.globl main
 
main:
    li $s0, 1 #turno
    li $s1, 0 #tamano
    li $s2, 0 #tesorosTablero
    li $t0, 0 #numeroAleatorio
    li $t1, 0 #casillas
    
    li $v0, 4
    la $a0, mensajeAutores1
    syscall
    
    li $v0, 4
    la $a0, mensajeAutores2
    syscall
    
    li $v0, 4
    la $a0, salto
    syscall
    
    li $v0, 4
    la $a0, mensajeBienvenida
    syscall
    
    li $v0, 4
    la $a0, mensajeIngresoTamano
    syscall
    
    li $v0, 5
    syscall
    
ingresarTamano:
    slti $t2, $v0, 20
    li $t3, 120
    sgt $t3, $v0, $t3
    or $t2, $t2, $t3
    beq $t2, $zero, asignacionMemoria
    li $v0, 4
    la $a0, mensajeIngresoTamanoCorrecto
    syscall
    li $v0, 5
    syscall
    j ingresarTamano
    
asignacionMemoria:
    move $s1, $v0
    li $a0, 4
    mul $a0, $a0, $s1
    li $v0, 9
    syscall
    move $s3, $v0  #Ojo: Trabajaremos con tablero en s3
    la $t2, tablero  #Hay que ver si eliminamos tablero lo dejamos
    sw $v0, 0($t2)
    l.s $f0, porcentajeTreinta
    mtc1 $s1, $f1
    cvt.s.w $f1, $f1
    mul.s  $f0, $f0, $f1
    round.w.s $f0, $f0
    mfc1 $s2, $f0
    li $t2, 0
    
rellenarConCeros:
    slt $t3, $t2, $s1
    beq $t3, $zero, rellenarConTesoros
    sll $t3, $t2, 2
    add $t3, $t3, $s3
    sw $zero, 0($t3)
    addi $t2, $t2, 1
    j rellenarConCeros
    
rellenarConTesoros:
    sgt $t2, $s2, $zero    
    beq $t2, $zero, definirIteradora
    li $v0, 42
    addi $a1, $s1, -1
    syscall
    move $t0, $a0
    #la $t2, tablero
    #lw $t2, 0($t2)
    sll $t3, $t0, 2
    add $t3, $t3, $s3
    lw $t4, 0($t3)
    bne $t4, $zero, rellenarConTesoros
    li $t2, -1
    sw $t2, 0($t3)
    addi $s2, $s2, -1
    j rellenarConTesoros
 
definirIteradora:
    li $t2, 0
    
rellenarConDinero:
    slt $t3, $t2, $s1
    beq $t3, $zero, definirTurno
    sll $t3, $t2, 2
    #la $t4, tablero
    add $t3, $t3, $s3
    lw $t4, 0($t3)
    bne $t4, $zero, incrementarFor
    li $v0, 42
    li $a1, 90
    syscall
    addi $t5, $a0, 10
    sw $t5, 0($t3)
    
incrementarFor:
    #Imprimir
    li $v0, 1
    addi $t9, $t2, 1
    move $a0, $t9
    syscall
    la $t8, separador
    li $v0, 4
    move $a0, $t8
    syscall
    li $v0, 1
    lw $t9, 0($t3)
    move $a0, $t9
    syscall
    la $t8, salto
    li $v0, 4
    move $a0, $t8
    syscall
    #Imprimir
    addi $t2, $t2, 1
    j rellenarConDinero
    
definirTurno:
    la $s5, infoJugador
    la $s6, infoMaquina
    
    #s4 sera infoJuego
    li $t0, 1
    #si turno != 1
    bne $s0, $t0, cambiarTurnoMaquina
    la $s4, infoJugador
   
    j loopJuego
    
cambiarTurnoMaquina:
    la $s4, infoMaquina

loopJuego:
    
    #CONDICION DE JUEGO
    li $t0, 1
    li $t4, 3
    lw $t1, 0($s4) #tesoros del jugador actual
    lw $t2, 12($s5) #llego final jugador
    lw $t3, 12($s6) #llego final maquina
    
    slt $t1, $t1, $t4
    beq $t1, $zero, resumenJuego
    bne $t2, $t1, whileJuego
    beq $t3, $t1, resumenJuego
    
    #SI NO SE COMPLE LA CONDICION DE JUEGO - Sale del bucle

whileJuego:

    #Dentro del while
    li $v0, 4
    la $a0, salto
    syscall
    
    li $v0, 4
    la $a0, lineaHorizontal
    syscall
    
    #turno != 1
    li $t0, 1
    bne $s0, $t0, printTurnoMaquina
    
    li $v0, 4
    la $a0, mensajeTurnoJugador
    syscall
    j pedirTurnos

printTurnoMaquina:
    li $v0, 4
    la $a0, mensajeTurnoMaquina
    syscall

pedirTurnos:
    #turno != 1
    li $t0, 1
    bne $s0, $t0, asignarCasillasMaquina

    li $v0, 4
    la $a0, mensajeIngresoNumeroCasillas
    syscall
    
    #pedir casillas
    li $v0, 5
    syscall
    
ingresarCasillas:
    
    #verificacion de rango
    slti $t2, $v0, 1
    li $t3, 6
    sgt $t3, $v0, $t3
    or $t2, $t2, $t3
    move $t5, $v0
    beq $t2, $zero, verificacionCasillas
    
    #mensaje ingreso
    li $v0, 4
    la $a0, mensajeIngresoNumeroCasillas
    syscall
    
    #pedir y volver a verificar
    li $v0, 5
    syscall
    move $t5, $v0
    j ingresarCasillas

asignarCasillasMaquina:

    li $v0, 42
    li $a1, 5
    syscall
    addi $t5, $a0, 1
    
    #imprimir mensaje maquina
    li $v0, 4
    la $a0, mensajeCasillasMaquina
    syscall
    
    li $v0, 1
    move $a0, $t5
    syscall
    
    li $v0, 4
    la $a0, salto
    syscall
    
verificacionCasillas:
    # casillas correctas tanto en la maquina como en jugador
    # casilla en $t5
    
    lw $t4, 8($s4)
    add $t4, $t4, $t5
    #t4 -> indiceTablero
    
    blt $t4, $s1, aumentarStats
    sw $s1, 8($s4)
    li $t1, 1
    sw $t1, 12($s4)
    
    li $v0, 4
    la $a0, mensajeFinTablero
    syscall

cambiarTurnoEInfoJuego:
    li $t6, 2
    div $s0, $t6
    mfhi $t5
    addi $s0, $t5, 1
    j definirTurno
    
aumentarStats:
    #indice tablero -> $t4
    #guardar avance
    sw $t4, 8($s4)
    
    #verificar si era tesoro o dinero tablero -> $s3
    sll	$t5, $t4, 2
    add $t5, $t5, $s3
    lw $t6, 0($t5)
    #en t6 tengo si es tesoro o si es dinero
    
    li $t7, -1
    bne $t6, $t7, aumentarDineroAcumulado
    
    lw $t8, 0($s4)
    addi $t8, $t8, 1
    sw $t8, 0($s4)
    
    sw $zero, 0($t5)
    j calcularDineroObtenido

aumentarDineroAcumulado:
    lw $t8, 4($s4)
    add $t8, $t8, $t6
    sw $t8, 4($s4)

calcularDineroObtenido:
    sll	$t5, $t4, 2
    add $t5, $t5, $s3
    lw $t6, 0($t5)
    
    #reutilizo $t2, t3 
    #t2 sera dinero obtenido juador
    #t3 sera dinero obtenido maquina
    
    li $t0 ,1
    li $t2, 0
    li $t3, 0


    beq $s0, $t0, aumentarDineroObtenidoJugador
    move $t3, $t6
    j imprimirEstadoJuego
    
aumentarDineroObtenidoJugador:
    move $t2, $t6

imprimirEstadoJuego:
    # Imprimir salto
    li $v0, 4
    la $a0, salto
    syscall

    # Imprimir encabezado
    li $v0, 4
    la $a0, mensajeEstadoJuego
    syscall

    #### ---------------- IMPRIMIR JUGADOR ---------------- ####
    # "Jugador -> Pos: "
    li $v0, 4
    la $a0, msgJugador
    syscall

    # Posición jugador = infoJugador[2]
    lw $t0, 8($s5)
    addi $t0, $t0 ,1
    li $v0, 1
    move $a0, $t0
    syscall

    # " | Dinero Obtenido: "
    li $v0, 4
    la $a0, msgDineroObtenido
    syscall

    # $t2 = dinero obtenido jugador
    li $v0, 1
    move $a0, $t2
    syscall

    # " | Dinero Acumulado: "
    li $v0, 4
    la $a0, msgDineroAcumulado
    syscall

    # infoJugador[1]
    lw $t0, 4($s5)
    li $v0, 1
    move $a0, $t0
    syscall

    # " | Tesoros: "
    li $v0, 4
    la $a0, msgTesoros
    syscall

    # infoJugador[0]
    lw $t0, 0($s5)
    li $v0, 1
    move $a0, $t0
    syscall

    #### ---------------- IMPRIMIR MAQUINA ---------------- ####

    # salto
    li $v0, 4
    la $a0, salto
    syscall

    # "Maquina -> Pos: "
    li $v0, 4
    la $a0, msgMaquina
    syscall

    # infoMaquina[2]
    lw $t0, 8($s6)
    addi $t0, $t0 ,1
    li $v0, 1
    move $a0, $t0
    syscall

    # " | Dinero Obtenido: "
    li $v0, 4
    la $a0, msgDineroObtenido
    syscall

    # $t3 = dinero obtenido máquina
    li $v0, 1
    move $a0, $t3
    syscall

    # " | Dinero Acumulado: "
    li $v0, 4
    la $a0, msgDineroAcumulado
    syscall

    # infoMaquina[1]
    lw $t0, 4($s6)
    li $v0, 1
    move $a0, $t0
    syscall

    # " | Tesoros: "
    li $v0, 4
    la $a0, msgTesoros
    syscall

    # infoMaquina[0]
    lw $t0, 0($s6)
    li $v0, 1
    move $a0, $t0
    syscall
    
    # salto
    li $v0, 4
    la $a0, salto
    syscall
    
    li $v0, 4
    la $a0, lineaHorizontal
    syscall
    
condicionCambioTurno:
    #cambio turno
    li $t0, 1
    li $t4, 3
    lw $t1, 0($s4) #tesoros del jugador actual
    lw $t2, 12($s5) #llego final jugador
    lw $t3, 12($s6) #llego final maquina
    
    slt $t1, $t1, $t4
    beq $t1, $zero, loopJuego
    beq $t2, $t0, loopJuego
    beq $t3, $t0, loopJuego
    
    #si paso las trws condiciones, cambias el turno
    
    j cambiarTurnoEInfoJuego

resumenJuego:

    li $v0, 4
    la $a0, lineaHorizontal
    syscall
    
    # Salto y encabezado
    li $v0, 4
    la $a0, salto
    syscall

    li $v0, 4
    la $a0, mensajeResumenJuego
    syscall

    li $v0, 4
    la $a0, salto
    syscall

    ##### --------- MOSTRAR RESULTADOS DEL JUGADOR --------- #####

    # Mensaje
    li $v0, 4
    la $a0, msgJugador
    syscall

    # Pos final jugador → infoJugador[2]
    lw $t0, 8($s5)
    addi $t0, $t0 ,1
    li $v0, 1
    move $a0, $t0
    syscall

    # " | Dinero Acumulado: "
    li $v0, 4
    la $a0, msgDineroAcumulado
    syscall

    lw $t0, 4($s5)
    li $v0, 1
    move $a0, $t0
    syscall

    # " | Tesoros: "
    li $v0, 4
    la $a0, msgTesoros
    syscall

    lw $t0, 0($s5)
    li $v0, 1
    move $a0, $t0
    syscall

    ##### --------- MOSTRAR RESULTADOS DE LA MÁQUINA --------- #####

    li $v0, 4
    la $a0, salto
    syscall

    # Mensaje
    li $v0, 4
    la $a0, msgMaquina
    syscall

    # Pos final máquina → infoMaquina[2]
    lw $t0, 8($s6)
    addi $t0, $t0 ,1
    li $v0, 1
    move $a0, $t0
    syscall

    # " | Dinero Acumulado: "
    li $v0, 4
    la $a0, msgDineroAcumulado
    syscall

    lw $t0, 4($s6)
    li $v0, 1
    move $a0, $t0
    syscall

    # " | Tesoros: "
    li $v0, 4
    la $a0, msgTesoros
    syscall

    lw $t0, 0($s6)
    li $v0, 1
    move $a0, $t0
    syscall
    
    li $v0, 4
    la $a0, salto
    syscall
    
imprimirGanador:

    li $v0, 4
    la $a0, salto
    syscall
    
    li $t0, 3
    lw $t1, 0($s4) #cantidad tesoros  
    bne $t1, $t0, imprimirGanadorPorDinero
    
    li $v0, 4
    la $a0, mensajeGanadorPorTesoros
    syscall
    
    li $t0, 1
    bne $s0, $t0, imprimirGanadorMaquina
    j imprimirGanadorJugador

imprimirGanadorPorDinero:

    li $v0, 4
    la $a0, mensajeGanadorPorDinero
    syscall
    
    lw $t3, 4($s5) #dinero acumulado jugador
    lw $t4, 4($s6) #dinero acumulado maquina
    
    bgt $t3, $t4, imprimirGanadorJugador
    blt $t3, $t4, imprimirGanadorMaquina
    
    #empate - decision por tesoros
    li $v0, 4
    la $a0, mensajeDesempate
    syscall
    
    lw $t8, 0($s5) #tesoros jugador
    lw $t9, 0($s6) #tesoros maquina
    
    blt $t9, $t8, imprimirGanadorJugador
    j imprimirGanadorMaquina
    
imprimirGanadorJugador:
    li $v0, 4
    la $a0, mensajeGanadorJugador
    syscall
    j imprimirDineroGanado
    
imprimirGanadorMaquina:
    li $v0, 4
    la $a0, mensajeGanadorMaquina
    syscall
    j imprimirDineroGanado

imprimirDineroGanado:
    lw $t3, 4($s5) #dinero acumulado jugador
    lw $t4, 4($s6) #dinero acumulado maquina
    add $t5, $t3, $t4
    
    li $v0, 4
    la $a0, mensajeDineroTotalGanado
    syscall
    
    li $v0, 1
    move $a0, $t5
    syscall
    
    li $v0, 4
    la $a0, salto
    syscall
    
end:
    li $v0, 4
    la $a0, lineaHorizontal
    syscall
    
    li $v0, 10
    syscall
