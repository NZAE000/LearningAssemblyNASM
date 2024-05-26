section .data ;; Datos
    msg db "hola", 0x0A, 0 ;; "hola\n\0"

section .text ;; Code (read only!!)
    global main
    extern printf ;; 'extern' is a adicional directive: printf is a extern global symbol

prn: ;; Any function
    push ebp
    mov  ebp, esp
    
    ;; Before call, load parameters in this stack
    mov  eax, msg ;; Load msg address to eax register
    push eax      ;; Can be do 'push' to hand:  sub esp, 4  then  mov [esp], eax  ([esp] is to access the stack at position esp)
    ;;push msg    ;; Can also be done directly, instead of doing it with a registry
    call printf
    pop eax       ;; Can be do 'pop' to hand:   add esp, 4, but the instruction 'mov esp, ebp' restore esp to begin address

    mov esp, ebp
    pop ebp

    ret

main:
    ;; ebp, esp = registers
    push ebp      ;; Store old ebp value(begin address of before stack frame) to begin stack frame
    mov  ebp, esp ;; Load esp value on ebp (update ebp): ebp store(pointer to) begin stack frame address

    call prn

    mov esp, ebp ;; set esp pointer to begin stack frame address!! (important)
    pop ebp      ;; Restore begin address of before stack frame on ebp

    ;;mov eax, 0 ;; (2bytes)
    xor eax, eax ;; (1byte)
    ret ;; return eax value