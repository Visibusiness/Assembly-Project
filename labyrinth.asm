%include "../include/io.mac"

extern printf
extern position
global solve_labyrinth

; you can declare any helper variables in .data or .bss
section .data
    num_line dd 0 ; number of lines
    num_column dd 0 ; number of column
section .text

; void solve_labyrinth(int *out_line, int *out_col, int m, int n, char **labyrinth);
solve_labyrinth:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     eax, [ebp + 8]  ; unsigned int *out_line, pointer to structure containing exit position
    mov     ebx, [ebp + 12] ; unsigned int *out_col, pointer to structure containing exit position
    mov     ecx, [ebp + 16] ; unsigned int m, number of lines in the labyrinth
    mov     edx, [ebp + 20] ; unsigned int n, number of colons in the labyrinth
    mov     esi, [ebp + 24] ; char **a, matrix represantation of the labyrinth
    ;; DO NOT MODIFY
   
    ;; Freestyle starts here
    dec edx
    dec ecx
    mov [num_line] , ecx
    mov [num_column] , edx
    

    mov eax, 0 ;  store the current line
    mov ebx, 0 ;  store the current column
    mov ecx , 0
    mov edx , 0 
    

loop_label:


    mov edx , dword[esi + 4 * eax]; dereference the pointer to the current line
    movzx ecx, byte [edx + ebx] ; dereference the pointer to the current column
    mov byte [edx + ebx], '1' ; mark the current position as visited



    cmp eax, [num_line] ; check if we reached the last line
    jz terminate 
    cmp ebx, [num_column] ; check if we reached the last column
    jz terminate

    mov edx , dword[esi + 4 * eax] ; dereference the pointer to the current line  
    movzx ecx, byte [edx + ebx + 1] ; dereference the pointer to the next column
    cmp ecx, '0' ; check if the next column is not a wall
    jnz skip_right ; if it is a wall skip to the next direction
    inc ebx
    jmp loop_label
skip_down:

    mov edx , dword[esi + 4 * eax] ; dereference the pointer to the current line
    movzx ecx , byte[edx + ebx - 1] ; dereference the pointer to the previous column 
    cmp cl, '0' ; check if the previous column is not a wall
    jnz skip_left ; if it is a wall skip to the next direction
    dec ebx
    jmp loop_label
skip_right: 

    mov edx , dword[esi + 4 * eax + 4] ; dereference the pointer to the next line
    movzx ecx , byte[edx + ebx] ; dereference the pointer to the current column
    cmp cl, '0' ; check if the next line is not a wall
    jnz skip_down ; if it is a wall skip to the next direction
    inc eax
    jmp loop_label
skip_left:

    mov edx , dword[esi + 4 * eax - 4] ; dereference the pointer to the previous line
    movzx ecx , byte[edx + ebx] ; dereference the pointer to the current column
    cmp cl, '0' ; check if the previous line is not a wall
    jnz skip_up ; if it is a wall skip to the next direction
    dec eax
    jmp loop_label
skip_up:
    ;; Freestyle ends here
terminate:
    ;; DO NOT MODIFY
    ; store the current line and column in the output variables
    lea edx, [ebp + 8]
    mov ecx, [edx] 
    mov [ecx], eax 
    lea edx, [ebp + 12] 
    mov edx, [edx] 
    mov [edx], ebx


    popa
    leave
    ret    
    
    ;; DO NOT MODIFY