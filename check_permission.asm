%include "../include/io.mac"

extern ant_permissions

extern printf
global check_permission

section .text

check_permission:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     eax, [ebp + 8]  ; id and permission
    mov     ebx, [ebp + 12] ; address to return the result
    ;; DO NOT MODIFY
   
       ;; Your code starts here
    mov     ecx, eax
    shr     ecx, 24       ; ant's ID
    mov     edx, eax
    and     edx, 0xFFFFFF ; rooms the ant wants to reserve
    mov     eax, dword [ant_permissions + 4 * ecx] ; rooms the ant can reserve
    and     eax, edx     ; check if the ant can reserve 
    cmp     eax, edx     ; compare with the rooms the ant wants to reserve
    jne     bad           ; bad response if they are not the same
good:
    mov     dword [ebx], 1 ; good response
    jmp     end
bad:
    mov     dword [ebx], 0 ; 
end:
    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
