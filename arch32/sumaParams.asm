section .data
    msg  db "The sum of var1 = %d and argc = %d is %d", 0x0A, 0
    var1 dd 5

section .text
    global main
    extern printf   ;; extern global symbol

sum:
    push ebp
    mov  ebp, esp

    ;; Get param1 (argc) that is 8 bytes up (loaded in stack from 'main' function).
    mov eax, [ebp + 8]
    mov ecx, [var1]     ;; load var1 value on ecx
    add ecx, eax        ;; ecx = argc + var1
    mov ebx, [var1]     ;; ebx = var1
    
    ;; Before call, load params in the stack
    push ecx    ;; argc + var1
    push eax    ;; argc
    push ebx    ;; var1
    push msg    ;; address msg

    call printf

    add esp, 4*4
    mov esp, ebp
    pop ebp

    ret

;;0XFFFFFF
;; || param2 (argv)              ||         |
;; || param1 (argc)              ||   _start frame
;; || return address(call main)  ||         |
;; || old ebp address            || <- esp, ebp (begin main frame)
;; ||           ....             ||
;; ||           ....             || 
;;0X000000

;; int main(int argc, char** argv)
main:
    push ebp
    mov  ebp, esp

    ;; Get param1 (argc) that is 8 bytes up
    mov  eax, [ebp + 8]  ;; Also, it can be  'mov eax, 8[ebp]' 
    push eax    ;; Load param in the stack ('sum function' must get that param)
    ;; The above, can be with instruction 'push dword [ebp + 8]' ( qword(64b), dword(32b), word(16b), byte(8b), since you have to specify the size! )

    call sum

    add eax, 4
    mov esp, ebp
    pop ebp

    xor eax, eax
    ret

;; lea (load effective address) For exp: ' lea eax, [ebx + 4*ecx + 2] ' -> (designed for arrays).