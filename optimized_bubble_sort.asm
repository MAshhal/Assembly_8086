[org 0x0100]

jmp start

data: dw 6, 2, 4, 5
swap: db 0 ; flag (did a swap occur in one pass)

start:
    outerloop:
        mov byte [swap], 0
        mov bx, 0

        innerloop:
            mov ax, [data + bx]
            cmp ax, [data + bx + 2]
            jbe noswap

            mov dx, [data + bx + 2]
            mov [data + bx + 2], ax
            mov [data + bx], dx
            mov byte [swap], 1

        noswap:
            add bx, 2
            cmp bx, 6
            jne innerloop

        cmp byte [swap], 1
        je outerloop


    mov ax, 4c00h
    int 21h
