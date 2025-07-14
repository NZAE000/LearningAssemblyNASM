;; section .data ;; 
;; section .bss ;; reserve memory space in execution time (this instruction inside .elf or .exe).

section .text
    global main

main:
    ;; Save stackframe above.
    push ebp
    mov ebp, esp

    ;; Move esp and restore ebp.
    pop ebp
    
    xor eax, eax ;; mov eax, 0
    ret