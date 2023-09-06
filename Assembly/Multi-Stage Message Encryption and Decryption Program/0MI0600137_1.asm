MODEL small

stack 256

.data
command db ?
orMessage db 'The original file message is: ', '$'
erMessage db 'You cant decrypt the original message!', '$'
message db 'Enter command: ', '$'
filename db "message.txt"
handle DW ?
buffer DB 200 DUP(?)
oldMessage db 200 dup (?)
wcount dw 0
count dw 0
.code

main:
	mov ax, @data
	mov ds, ax
	
	mov ah,3dh
	mov dx,offset(filename)
	mov al,0
	int 21H
	mov handle,ax

	mov ah,3fh
	mov bx,handle
	mov dx,offset(buffer)
	mov cx,200
	int 21h
	
	mov ah, 09h
	mov dx, offset(orMessage)
	int 21h
	
	mov si,offset(buffer)
	xor bx,bx
extractFromFile:
	mov ah,2
	mov dl,[si]
	cmp dl,''
	je enterCommand
	mov oldMessage[bx], dl
	inc bx
	int 21h
	inc si
	inc wcount
	jnz extractFromFile


enterCommand:
	mov dl, 10
	mov ah, 02h
	int 21h
	
	mov ah, 09h
	mov dx, offset message
	int 21h

	mov ah, 01h
	int 21h
	
	mov command, al

	cmp al, '1'
	je crypt
	cmp al, '2'
	je flagDecrypt
	cmp al, 'e'
	jmp exit
	
crypt:
	mov dl, 10
	mov ah, 02h
	int 21h
	inc count
	mov cx, wcount
	xor bx,bx
	cmp count, 1
	jle crypt1
	cmp count, 2
	jle crypt2
	cmp count, 3
	jge flagCrypt3

crypt1:
	mov dl, oldMessage[bx]
	cmp dl, '}'
	je crypt1def1
	cmp dl, '~'
	je crypt1def2
	mov ah, 2h
	add dl, 2
	mov oldMessage[bx], dl
	inc bx
	int 21h
	loop crypt1
	
	jmp enterCommand

crypt1def1:
	mov ah, 02h
	mov dl, ' '
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop crypt1
	
	jmp enterCommand
	
crypt1def2:
	mov ah, 02h
	mov dl, '!'
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop crypt1

	jmp enterCommand
	
flagDecrypt:
	jmp decrypt	
	
flagCrypt3:
	jmp crypt3
	
crypt2:
	mov dl, oldMessage[bx]
	cmp dl, '{'
	je crypt2def1
	cmp dl, '|'
	je crypt2def2
	cmp dl, '}'
	je crypt2def3
	cmp dl, '~'
	je crypt2def4
	add dl, 4
	mov ah, 2h
	mov oldMessage[bx], dl
	inc bx
	int 21h
	loop crypt2

	jmp enterCommand
	
crypt2def1:
	mov ah, 02h
	mov dl, ' '
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop crypt2
	
	jmp enterCommand
	
crypt2def2:
	mov ah, 02h
	mov dl, '!'
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop crypt2

	jmp enterCommand
	
crypt2def3:
	mov ah, 02h
	mov dl, '"'
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop crypt2

	jmp enterCommand
	
crypt2def4:
	mov ah, 02h
	mov dl, '#'
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop crypt2

	jmp enterCommand
	
crypt3:
	mov dl, oldMessage[bx]
	cmp dl, ' '
	je crypt3def1
	cmp dl, '!'
	je crypt3def2
	cmp dl, '"'
	je crypt3def3
	cmp dl, '#'
	je crypt3def4
	cmp dl, '$'
	je crypt3def5
	sub dl, 5
	mov ah, 2h
	mov oldMessage[bx], dl
	inc bx
	int 21h
	loop crypt3

	jmp enterCommand
	
crypt3def1:
	mov ah, 02h
	mov dl, 'z'
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop crypt3

	jmp enterCommand
	
crypt3def2:
	mov ah, 02h
	mov dl, '{'
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop crypt3

	jmp enterCommand
	
crypt3def3:
	mov ah, 02h
	mov dl, '|'
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop crypt3

	jmp enterCommand
	
crypt3def4:
	mov ah, 02h
	mov dl, '}'
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop crypt3

	jmp enterCommand
	
crypt3def5:
	mov ah, 02h
	mov dl, '~'
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop crypt3

	jmp enterCommand

decrypt:
	mov dl, 10
	mov ah, 02h
	int 21h
	mov cx, wcount
	xor bx,bx
	cmp count, 0
	jle flagNoMoreDecrypt
	cmp count, 1
	jle decrypt1
	cmp count, 2
	jle decrypt2
	cmp count, 3
	jge flagDecrypt3

decrypt1:
	mov dl, oldMessage[bx]
	cmp dl, ' '
	je decrypt1def1
	cmp dl, '!'
	je decrypt1def2
	sub dl, 2
	mov ah, 2h
	mov oldMessage[bx], dl
	inc bx
	int 21h
	loop decrypt1
	
	dec count
	jmp enterCommand

decrypt1def1:
	mov ah, 02h
	mov dl, '}'
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop decrypt1

	dec count
	jmp enterCommand
	
decrypt1def2:
	mov ah, 02h
	mov dl, '~'
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop decrypt1

	dec count
	jmp enterCommand

flagNoMoreDecrypt:
	jmp noMoreDecrypt	
	
flagDecrypt3:
	jmp decrypt3

decrypt2:
	mov dl, oldMessage[bx]
	cmp dl, ' '
	je decrypt2def1
	cmp dl, '!'
	je decrypt2def2
	cmp dl, '"'
	je decrypt2def3
	cmp dl, '#'
	je decrypt2def4
	sub dl, 4
	mov ah, 2h
	mov oldMessage[bx], dl
	inc bx
	int 21h
	loop decrypt2
	
	dec count
	jmp enterCommand
	
decrypt2def1:
	mov ah, 02h
	mov dl, '{'
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop decrypt2
	
	dec count
	jmp enterCommand
	
decrypt2def2:
	mov ah, 02h
	mov dl, '|'
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop decrypt2
	
	dec count
	jmp enterCommand
	
decrypt2def3:
	mov ah, 02h
	mov dl, '}'
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop decrypt2
	
	dec count
	jmp enterCommand
	
decrypt2def4:
	mov ah, 02h
	mov dl, '~'
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop decrypt2
	
	dec count
	jmp enterCommand
	
decrypt3:
	mov dl, oldMessage[bx]
	cmp dl, 'z'
	je decrypt3def1
	cmp dl, '{'
	je decrypt3def2
	cmp dl, '|'
	je decrypt3def3
	cmp dl, '}'
	je decrypt3def4
	cmp dl, '~'
	je decrypt3def5
	add dl, 5
	mov ah, 2h
	mov oldMessage[bx], dl
	inc bx
	int 21h
	loop decrypt3
	
	dec count
	jmp enterCommand
	
decrypt3def1:
	mov ah, 02h
	mov dl, ' '
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop decrypt3
	
	dec count
	jmp enterCommand
	
decrypt3def2:
	mov ah, 02h
	mov dl, '!'
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop decrypt3
	
	dec count
	jmp enterCommand
	
decrypt3def3:
	mov ah, 02h
	mov dl, '"'
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop decrypt3
	
	dec count
	jmp enterCommand

jmpToLoop:
	loop decrypt3
	
decrypt3def4:
	mov ah, 02h
	mov dl, '#'
	mov oldmessage[bx], dl
	inc bx
	int 21h
	loop decrypt3

	dec count
	jmp enterCommand
	

	
decrypt3def5:
	mov ah, 02h
	mov dl, '$'
	mov oldmessage[bx], dl
	inc bx
	int 21h
	jmp jmpToLoop

	dec count
	jmp enterCommand
	
noMoreDecrypt:
	mov ah, 09h
	mov dx, offset(erMessage)
	int 21h
	jmp enterCommand
	
exit:
	mov ax, 4c00h
	int 21h
end main
