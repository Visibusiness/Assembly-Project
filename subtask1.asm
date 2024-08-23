%include "../include/io.mac"

struc creds
    passkey: resw 1
    username: resb 51
endstruc

struc request
    admin: resb 1
    prio: resb 1
    login_creds: resb creds_size
endstruc

section .text
    global sort_requests
    extern printf

sort_requests:
    enter 0,0
    pusha

    mov ebx, [ebp + 8]      ; requests
    mov ecx, [ebp + 12]     ; length
   
    xor eax, eax 
    xor edx, edx 
    
    add edx, 1
   
    mov esi, ebx
    xor edi, edi 
    mov ebx, request_size

first_sort_for:
    push ecx
    push eax
    push edx
    mov dl, byte[esi + edi + admin]
    mov cl, byte[esi + ebx + admin]
    cmp dl, cl
    jl swap
    jne second_sort_for
    xor dx, dx
    xor cx, cx
    movzx dx, byte[esi + edi + prio]
    movzx cx, byte[esi + ebx + prio]
    cmp dx, cx
    jg swap
    jne second_sort_for
    xor eax, eax
    push edi 
    push ebx 
    cmp dx, cx
    je for_by_username

for_by_username:
    xor edx, edx
    xor ecx, ecx
    mov dl, byte[esi + edi + login_creds + username]
    mov cl, byte[esi + ebx + login_creds + username]
    cmp dl, cl
    jg pop_username
    jl pop_non_swap
    add edi, 1
    add ebx, 1
    add eax, 1
    cmp eax, 51
    jl for_by_username
    pop ebx 
    pop edi 
    jmp second_sort_for

pop_non_swap:
    pop ebx 
    pop edi 
    jmp second_sort_for

pop_username:
    pop ebx
    pop edi
    jmp swap
unpop:
    pop ebx 
    pop edi 
    push edi
    push ebx 
    xor edx, edx
    jmp swap_letter

swap:
    xor ecx, ecx
    xor eax, eax
    mov ecx, dword[esi + ebx]
    mov eax, dword[esi + edi]
    mov dword[esi + edi], ecx
    mov dword[esi + ebx], eax
    push edi
    push ebx 
    jmp unpop
    jmp second_sort_for

swap_letter:
    xor ecx, ecx
    xor eax, eax
    mov cl, byte[esi + ebx + login_creds + username]
    mov al, byte[esi + edi + login_creds + username]
    mov byte[esi + edi + login_creds + username], cl
    mov byte[esi + ebx + login_creds + username], al
    add edx, 1
    add edi, 1
    add ebx, 1
    cmp edx, 51
    jl swap_letter
    pop ebx 
    pop edi 
    jmp second_sort_for

second_sort_for:
    pop edx
    pop eax
    pop ecx
    add edx, 1
    add ebx, request_size
    cmp ecx, edx
    jg first_sort_for
    add eax, 1
    add eax, 1
    cmp eax, ecx
    jg end
    sub eax, 1
    mov edx, eax
    add edi, request_size
    mov ebx, edi
    jmp first_sort_for

end:
    xor ebx, ebx
    mov ebx, esi

    popa
    leave
    ret