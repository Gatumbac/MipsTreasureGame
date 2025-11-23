/******************************************************************************

                            Online C Compiler.
                Code, Compile, Run and Debug C program online.
Write your code in this editor and press "Run" button to compile and execute it.

*******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main() {
    
    int turno = 1; // turno [1-2]
    int tamano = 0; // tamano tablero
    int tesorosTablero = 0; //cantidad de tesoros en el tablero
    int *tablero; // puntero al primer elemento del arreglo que representa al tablero
    int infoJugador[] = {0, 0, 0, 0}; //cantidadTesoros, dineroAcumulado, ultimaPosicion, llegoFinal
    int infoMaquina[] = {0, 0, 0, 0}; //cantidadTesoros, dineroAcumulado, ultimaPosicion, llegoFinal
    int *infoJuego; // guarda la informacion del jugador actual dependiendo del turno
    int numeroAleatorio; //almacena el indice aleatorio de algun tesoro
    int casillas; //cantidad de casillas avanzadas por cada jugador en un turno
    
    printf("¡Bienvenido al juego de las casillas!\n");
    printf("Ingresa el tamaño del tablero [20-120]: ");
    
    // Validar el tamano del tablero
    scanf("%d", &tamano);
    while(tamano < 20 || tamano > 120){
        printf("Ingresa un tamano correcto [20-120]: ");
        scanf("%d", &tamano);
    }
    
    // Inicializar el tablero y la cantidad de tesoros disponibles
    tablero = (int *) calloc(tamano, sizeof(int));
    tesorosTablero = floor(0.3 * tamano);
    
    //Llenar las casillas de tesoros con -1 (el resto sera 0)
    while(tesorosTablero > 0){
        numeroAleatorio = rand() % tamano;
        if(tablero[numeroAleatorio] == 0){
            tablero[numeroAleatorio] = -1;
            tesorosTablero -= 1;
        }
    }
    
    // Llenar con dinero las casillas que no son tesoros.
    for(int i = 0; i < tamano; i++){
        if(tablero[i] == 0){
            tablero[i] = (rand() % (91)) + 10;
        }
        //printf("%d - %d\n", i, tablero[i]);
    }
    
    // Se carga la info del jugador actual (siempre inicia primero el jugador)
    // Se podria hacer aleatorio quien inicia primero
    if(turno == 1) {
        infoJuego = infoJugador;
    } else {
        infoJuego = infoMaquina;
    }
    
    // Condicion del juego
    // se juega mientras sea falso que el jugador actual consiguio los 3 tesoros o que los dos jugadores llegaron al final.
    while(!(infoJuego[0] == 3 || (infoJugador[3] == 1 && infoMaquina[3] == 1))){
        printf("\n");
        printf("-----------------------------------------------------------------------------------\n");
        if (turno == 1) {
            printf("Turno Jugador\n");
        } else {
            printf("Turno Maquina\n");
        }
        
        // Turno 1 - Jugador 
        // Turno 2 - Maquina
        // Logica de verificacion de casillas, dependiendo del turno
        if (turno == 2) {
            casillas = (rand() % (6)) + 1;
            printf("Maquina avanza %d casillas\n", casillas);
        } else {
            printf("Ingrese cantidad de casillas a avanzar [1-6]: ");
            scanf("%d", &casillas);
            while(casillas < 1 || casillas > 6){
                printf("Ingrese cantidad de casillas a avanzar [1-6]: ");
                scanf("%d", &casillas);
            }
        }

        // Verificacion si el jugador actual llego al final del tablero
        // Indice ultimaPosicionJugador + casillas
        // Indexamos en el tablero
        int indiceTablero;
        indiceTablero = infoJuego[2] + casillas;
        if (indiceTablero >= tamano) {
            infoJuego[2] = tamano;
            infoJuego[3] = 1;
            printf("El jugador actual llego al final del tablero\n");
            turno = turno % 2 + 1;
            //Podria ser una funcion.
            if(turno == 1) {
                infoJuego = infoJugador;
            } else {
                infoJuego = infoMaquina;
            }
            continue;
        }
        
        // Si aun no llega al final del tablero, se verifica la casilla y se aumentan stats
        infoJuego[2] = indiceTablero;
        int casillaTablero = tablero[indiceTablero];
        if (casillaTablero == -1) {
            infoJuego[0]++;
            tablero[indiceTablero] = 0;
        } else {
            infoJuego[1] += casillaTablero;
        }
        
        casillaTablero = tablero[indiceTablero];

        int droObtenidoJugador = turno == 1 ? casillaTablero : 0;
        int droObtendoMaquina = turno == 2 ? casillaTablero : 0;
        
        printf("\n-- ESTADO DEL JUEGO --\n");
        printf("Jugador -> Pos: %d | Dinero Obtenido: %d | Dinero Acumulado: %d | Tesoros: %d\n", infoJugador[2], droObtenidoJugador, infoJugador[1], infoJugador[0]);
        printf("Maquina -> Pos: %d | Dinero Obtenido: %d | Dinero Acumulado: %d | Tesoros: %d\n", infoMaquina[2], droObtendoMaquina, infoMaquina[1], infoMaquina[0]);
        printf("-----------------------------------------------------------------------------------\n");
        
        if (infoJuego[0] < 3 && !(infoJugador[3] == 1 || infoMaquina[3] == 1)) {
            turno = turno % 2 + 1;
            if(turno == 1) {
                infoJuego = infoJugador;
            } else {
                infoJuego = infoMaquina;
            }
        }
        
    } //Fin del while
    
    printf("-----------------------------------------------------------------------------------\n");
    printf("\n-- RESUMEN DEL JUEGO --\n");    
    printf("Jugador -> Pos. Final: %d | Dinero Acumulado: %d | Tesoros: %d\n", infoJugador[2], infoJugador[1], infoJugador[0]);
    printf("Maquina -> Pos. Final: %d | Dinero Acumulado: %d | Tesoros: %d\n", infoMaquina[2], infoMaquina[1], infoMaquina[0]);
    
    printf("\n");
    if (infoJuego[0] == 3) {
        // Se verifica quien fue el ultimo jugador.
        // No se modifico el turno.
        if (turno == 1) { 
            printf("Ganador: Jugador\n");
        } else {
            printf("Ganador: Maquina\n");
        } 
    } else {
        // Se verifica quien tuvo mas dinero
        if (infoJugador[1] > infoMaquina[1]) {
            printf("Ganador: Jugador\n");
        } else if (infoJugador[1] < infoMaquina[1]) {
            printf("Ganador: Maquina\n");
        } else {
            // Empate - Se decide por tesoros
            if (infoJugador[0] >= infoMaquina[0]) {
                printf("Ganador: Jugador\n");
            } else {
                printf("Ganador: Maquina\n");
            }
        }
    }
    
    printf("Dinero total para el ganador: %d\n", infoJugador[1] + infoMaquina[1]);
    printf("-----------------------------------------------------------------------------------\n");
}