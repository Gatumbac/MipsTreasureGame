# 🏆 Juego de los Tesoros — MIPS Assembly

Proyecto desarrollado para el **Primer Parcial de Organización de Computadores (CCPG1049)** – ESPOL.  
El objetivo es implementar un juego interactivo en MIPS que permita comprender la ejecución de instrucciones a bajo nivel y el manejo de estructuras de datos en memoria.

## 🎮 Descripción del Juego

El programa simula una **búsqueda de tesoros** entre el usuario y la máquina sobre un tablero unidimensional.  
Existen tesoros escondidos y casillas con dinero aleatorio. Ambos jugadores avanzan por turnos hasta que:

- Uno encuentre **3 tesoros**, **o**
- Ambos lleguen al final del tablero.

Al final se muestran las estadísticas completas y el ganador.

## 🧩 Características Principales

- Elección del tamaño del tablero (**20 a 120 casillas**)
- Generación aleatoria de:
  - Ubicación del 30% de tesoros
  - Montos de dinero en casillas normales
  - Movimientos de la máquina (1–6)
- Visualización del estado del juego en cada turno:
  - Posición de cada jugador
  - Dinero ganado en el turno
  - Dinero acumulado
  - Tesoros encontrados
- Determinación automática del ganador

## 🛠️ Tecnologías / Herramientas

- **Ensamlador MIPS**
- Entorno recomendado:
  - **MARS** o **QtSPIM**
- Uso de:
  - Punteros
  - Arreglos dinámicos
  - Syscalls para entrada y salida
  - Instrucciones aritméticas y de control de flujo
  - Memoria estática y dinámica

## 🚀 Cómo Ejecutar el Proyecto

1. Abrir el archivo `.asm` en **MARS** o **QtSPIM**.
2. Ensamblar el código (`Assemble`).
3. Ejecutar (`Run`).
4. Seguir las instrucciones en pantalla:
   - Ingresar tamaño del tablero
   - Realizar movimientos
   - Continuar el juego hasta el final

## 📈 Posibles Mejoras

- Mostrar el tablero de manera gráfica (ASCII).
- Añadir niveles de dificultad.
- Registrar historial de partidas.
- Implementar más tipos de casillas especiales.
- Guardar estadísticas en archivos externos.

## 👥 Autores

- **Darwin Díaz**
- **Gabriel Tumbaco**
- Paralelo 2 – ESPOL


