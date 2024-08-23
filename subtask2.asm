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
    global check_passkeys
    extern printf

check_passkeys:

    enter 0, 0
    pusha

    mov ebx, [ebp + 8]     
    mov ecx, [ebp + 12]     
    mov eax, [ebp + 16]     


    push eax
    xor edx, edx 
    mov esi, ebx
    xor edi, edi

for_check_pass:
    xor eax, eax
    push ecx 
    push edx
    mov bx, word[esi + edi + login_creds + passkey]
    jmp cmp_hacker
    jmp exit_for

cmp_hacker:
    push ebx
    test bx, 1
    jnz cmp_hacker2 
    jmp exit_no_hacker 

cmp_hacker2:
    shr bx, 15
    test bx, 1
    jz exit_no_hacker
    pop ebx
    jmp cmp_hacker3

cmp_hacker3:
    push ebx
    xor ecx, ecx
    xor edx, edx 
    shr bl, 1 

for_first_7_biti:
    test bl, 1
    jz add_1
    jmp continue_for_1

add_1:
    add ecx, 1
    jmp continue_for_1

continue_for_1:
    shr bl, 1
    add edx, 1
    cmp edx, 7
    jne for_first_7_biti
    test ecx, 1 
    jz exit_no_hacker 
    pop ebx
    jmp cmp_hacker4

cmp_hacker4:
    push ebx
    xor ecx, ecx
    xor edx, edx 

for_last_7_biti:
    test bh, 1
    jz add_2
    jmp continue_for_2

add_2:
    add ecx, 1
    jmp continue_for_2

continue_for_2:
    shr bh, 1
    add edx, 1
    cmp edx, 7
    jne for_last_7_biti
    test ecx, 1
    jz exit_hacker 
    jmp exit_no_hacker

exit_no_hacker:
    pop ebx
    mov eax, 0
    jmp exit_for

exit_hacker:
    pop ebx
    mov eax, 1
    jmp exit_for

exit_for:
    pop edx
    pop ecx
    pop ebx
    cmp eax, 0
    je no_hacker
    cmp eax, 1
    je yes_hacker

no_hacker:
    mov byte[ebx + edx], 0
    jmp continue

yes_hacker:
    mov byte[ebx + edx], 1
    jmp continue

continue:
    add edx, 1
    add edi, request_size
    push ebx
    cmp ecx, edx
    jg for_check_pass
    jmp end_check

end_check:
    xor ebx, ebx
    mov ebx, esi
    pop eax



    popa
    leave
    ret