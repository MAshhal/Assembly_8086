[org 0x0100]             ; Set origin for COM program (starts at 0x0100)

jmp start                ; Jump over data section to start of code execution

data: dw 6, 4, 5, 2      ; Define an array of 4 unsigned 16-bit numbers (word-sized)

start:
    xor ax, ax           ; Clear AX register (not strictly necessary here)
    mov cx, 4            ; Outer loop counter – number of passes (n elements)

    outerloop:
        mov bx, 0            ; Inner loop index (used as byte offset in data)

        innerloop:
            mov ax, [data + bx]         ; Load current element into AX
            cmp ax, [data + bx + 2]     ; Compare with next element

            ; If current <= next (AX <= [data + BX + 2]), no need to swap
            jbe noswap

            ; Swap current and next elements
            mov dx, [data + bx + 2]     ; Load next element into DX
            mov [data + bx + 2], ax     ; Store current element in next position
            mov [data + bx], dx         ; Store next element in current position

            noswap:
                add bx, 2            ; Move to next pair (2 bytes forward since each element is a word)
                cmp bx, 6            ; Compare index to 6 (stop before last element in data array)
                jne innerloop        ; If not done, continue inner loop

        sub cx, 1            ; Decrease outer loop counter (one less pass needed)
        jne outerloop        ; Repeat outer loop if more passes remain

    ; Exit program (DOS interrupt)
    mov ax, 0x4c00       ; Terminate program with return code 0
    int 21h              ; DOS interrupt to exit