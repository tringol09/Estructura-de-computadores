# Código MIPS - Programa 3: Serie Fibonacci
# Archivo: ApellidoNombre_Fibonacci.asm

# Programa: Serie Fibonacci
# Archivo: ApellidoNombre_Fibonacci.asm
# Descripción: Genera n términos de la serie Fibonacci y calcula su suma

.data
prompt_cantidad: .asciiz "¿Cuántos números de Fibonacci desea generar? "
serie_msg: .asciiz "Serie Fibonacci: "
suma_msg: .asciiz "\nLa suma total es: "
comma: .asciiz ", "
newline: .asciiz "\n"

.text
main:
    # Solicitar cantidad de números Fibonacci
    li $v0, 4                    # syscall para imprimir string
    la $a0, prompt_cantidad      # cargar dirección del mensaje
    syscall                      # ejecutar syscall
    
    li $v0, 5                    # syscall para leer entero
    syscall                      # ejecutar syscall
    move $t0, $v0                # $t0 = cantidad de números
    
    # Validar que sea mayor que 0
    ble $t0, $zero, fin          # si n <= 0, terminar programa
    
    # Mostrar mensaje de inicio de serie
    li $v0, 4                    # syscall para imprimir string
    la $a0, serie_msg            # cargar mensaje
    syscall                      # ejecutar syscall
    
    # Inicializar variables Fibonacci
    li $t1, 0                    # $t1 = fib_anterior (F0 = 0)
    li $t2, 1                    # $t2 = fib_actual (F1 = 1)
    li $t3, 0                    # $t3 = suma total
    li $t4, 1                    # $t4 = contador
    
    # Caso especial: si n = 1, solo mostrar 0
    beq $t0, 1, caso_uno         # si n = 1, ir a caso especial
    
    # Mostrar primer número (0)
    li $v0, 1                    # syscall para imprimir entero
    move $a0, $t1                # cargar F0 = 0
    syscall                      # ejecutar syscall
    add $t3, $t3, $t1            # suma += 0
    
    # Mostrar coma si hay más números
    beq $t0, 1, mostrar_suma     # si n = 1, ir a mostrar suma
    li $v0, 4                    # syscall para imprimir string
    la $a0, comma                # cargar coma
    syscall                      # ejecutar syscall
    
    # Incrementar contador
    addi $t4, $t4, 1             # contador++
    
generar_fibonacci:
    # Verificar si hemos generado todos los números
    bgt $t4, $t0, mostrar_suma   # si contador > n, mostrar suma
    
    # Mostrar número actual
    li $v0, 1                    # syscall para imprimir entero
    move $a0, $t2                # cargar número Fibonacci actual
    syscall                      # ejecutar syscall
    
    # Agregar a la suma
    add $t3, $t3, $t2            # suma += fib_actual
    
    # Calcular siguiente número Fibonacci
    add $t5, $t1, $t2            # $t5 = fib_anterior + fib_actual
    move $t1, $t2                # fib_anterior = fib_actual
    move $t2, $t5                # fib_actual = fib_siguiente
    
    # Incrementar contador
    addi $t4, $t4, 1             # contador++
    
    # Mostrar coma si no es el último número
    bge $t4, $t0, sin_coma       # si es el último, no mostrar coma
    li $v0, 4                    # syscall para imprimir string
    la $a0, comma                # cargar coma
    syscall                      # ejecutar syscall
    
sin_coma:
    j generar_fibonacci          # continuar bucle
    
caso_uno:
    # Mostrar solo el primer número (0)
    li $v0, 1                    # syscall para imprimir entero
    move $a0, $t1                # cargar 0
    syscall                      # ejecutar syscall
    add $t3, $t3, $t1            # suma = 0
    
mostrar_suma:
    # Mostrar mensaje de suma
    li $v0, 4                    # syscall para imprimir string
    la $a0, suma_msg             # cargar mensaje de suma
    syscall                      # ejecutar syscall
    
    # Mostrar valor de la suma
    li $v0, 1                    # syscall para imprimir entero
    move $a0, $t3                # cargar suma total
    syscall                      # ejecutar syscall
    
    # Salto de línea final
    li $v0, 4                    # syscall para imprimir string
    la $a0, newline              # cargar salto de línea
    syscall                      # ejecutar syscall
    
fin:
    # Terminar programa
    li $v0, 10                   # syscall para terminar
    syscall                      # ejecutar syscall