section .data
    msg  db "La suma de %d y %d es %d", 0x0A, 0  ;;
    var1 dd 3
    var2 dd 4

section .text
    global main
    extern printf ;; extern global symbol


suma:
    push ebp
    mov  ebp, esp

    ;; ecx = var1 + var2
    mov eax, [var1]
    mov ecx, [var2]
    add ecx, eax

    mov eax, [var1]
    mov ebx, [var2]

    ;; Before call, load parameters in this stack
    push ecx
    push ebx
    push eax
    push msg

    call printf

    add esp, 4*4 ;; Although the instruction 'mov esp, ebp' restore esp.
    mov esp, ebp
    pop ebp

    ret


main:
    
    push ebp        ;; Store old ebp value (first address of before stack frame) in the begin of this stack frame
    mov  ebp, esp   ;; Update ebp to first address of this stack frame

    call suma

    mov esp, ebp    ;; Set esp value to first address of this stack frame
    pop ebp         ;; Restore old value of ebp (first address of before stack frame)

    xor eax, eax
    ret