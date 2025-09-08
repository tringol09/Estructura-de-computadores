# Código MIPS - Programa 1: Número Mayor
# Archivo: ApellidoNombre_Mayor.asm

# Programa: Encontrar el número mayor
# Archivo: ApellidoNombre_Mayor.asm
# Descripción: Programa que encuentra el mayor entre 3-5 números

.data
prompt_cantidad: .asciiz "¿Cuántos números desea comparar (3-5)? "
prompt_numero: .asciiz "Ingrese el número: "
resultado_msg: .asciiz "El número mayor es: "
error_rango: .asciiz "Error: Debe ingresar entre 3 y 5 números\n"
newline: .asciiz "\n"

.text
main:
    # Solicitar cantidad de números
    li $v0, 4                    # syscall para imprimir string
    la $a0, prompt_cantidad      # cargar dirección del mensaje
    syscall                      # ejecutar syscall
    
    li $v0, 5                    # syscall para leer entero
    syscall                      # ejecutar syscall
    move $t0, $v0                # $t0 = cantidad de números
    
    # Validar que esté en rango 3-5
    li $t1, 3                    # límite inferior
    li $t2, 5                    # límite superior
    blt $t0, $t1, error          # si cantidad < 3, ir a error
    bgt $t0, $t2, error          # si cantidad > 5, ir a error
    
    # Leer primer número como inicial máximo
    li $v0, 4                    # syscall para imprimir string
    la $a0, prompt_numero        # cargar mensaje
    syscall                      # ejecutar syscall
    
    li $v0, 5                    # syscall para leer entero
    syscall                      # ejecutar syscall
    move $t3, $v0                # $t3 = número máximo actual
    
    # Inicializar contador para números restantes
    addi $t4, $t0, -1            # $t4 = cantidad - 1 (números restantes)
    
leer_numeros:
    beq $t4, $zero, mostrar_resultado  # si no quedan números, mostrar resultado
    
    # Leer siguiente número
    li $v0, 4                    # syscall para imprimir string
    la $a0, prompt_numero        # cargar mensaje
    syscall                      # ejecutar syscall
    
    li $v0, 5                    # syscall para leer entero
    syscall                      # ejecutar syscall
    move $t5, $v0                # $t5 = número actual
    
    # Comparar con el máximo actual
    ble $t5, $t3, siguiente      # si número_actual <= máximo, continuar
    move $t3, $t5                # actualizar máximo
    
siguiente:
    addi $t4, $t4, -1            # decrementar contador
    j leer_numeros               # volver al inicio del bucle
    
mostrar_resultado:
    # Mostrar mensaje de resultado
    li $v0, 4                    # syscall para imprimir string
    la $a0, resultado_msg        # cargar mensaje
    syscall                      # ejecutar syscall
    
    # Mostrar número mayor
    li $v0, 1                    # syscall para imprimir entero
    move $a0, $t3                # cargar número mayor
    syscall                      # ejecutar syscall
    
    # Salto de línea
    li $v0, 4                    # syscall para imprimir string
    la $a0, newline              # cargar salto de línea
    syscall                      # ejecutar syscall
    
    j fin                        # ir a fin del programa
    
error:
    # Mostrar mensaje de error
    li $v0, 4                    # syscall para imprimir string
    la $a0, error_rango          # cargar mensaje de error
    syscall                      # ejecutar syscall
    
fin:
    # Terminar programa
    li $v0, 10                   # syscall para terminar
    syscall                      # ejecutar syscall