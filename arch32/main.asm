;; section .data ;; 
;; section .bss ;; reserve memory space in execution time (this instruction inside .elf or .exe).

section .text
    global main

main:
    ;;mov eax 0
    xor eax, eax
    ret