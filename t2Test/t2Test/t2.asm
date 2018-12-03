includelib legacy_stdio_definitions.lib
extrn printf:near
.data

option casemap:none

public g
g QWORD 4 
.code

public min
min:
		mov r11, r8		;v (r11) = a
		cmp rdx, r11	;if(b < V)
		jge min1
		mov r11, rdx	;v = b
min1:
		cmp rcx, r11	; if (c < v)
		jge min2
		mov r11, rcx	;v = c
min2:
		mov rax, r11	;return v
		ret 

public p
p:		sub rsp, 32		; allocate shadow space

		mov r10, r9		;r10 = i
		mov r11, r8		;r11 = j

		push rcx		;save l
		push rdx		;save k


		mov rcx, r10	;min param 3 in rcx(j)
		mov rdx, r11	;min param 2 in rdx(i)
		mov r8, g		;min param 1 in r8(g)

		call min		; min(g,i,j)

		pop rdx			;restore k (min param 2 in rdx)
		pop rcx			;restore l (min param 3 in rcx)

		mov r8,	 rax	;min param 1 in r8 (min(g,i,j))


		call min		;min(min(g,i,j),k,l)

		add rsp, 32		;deallocate shadow space
		ret

public gcd
gcd:	sub rsp, 32		;allocate shadow space
		cmp rdx, 0		;if(b==0)
		je gcd0	

		mov r10, rdx	; r10 = b

		mov rax, rcx	; rax = a
		mov rbx, rdx	; (divisor) rbx = b
		mov rdx, 0		; remainder = 0
		idiv rbx		; a%b

		mov rcx, r10	; rcx = r10 {b}

		call gcd		; gcd(b, a%b)
		jmp gcd1

gcd0:	mov rax, rcx	; rax = a	

gcd1:	add rsp, 32		;deallocate shadow space
		ret				; return 
	
public q

fxp2	db 'a = %I64d b = %I64d c = %I64d d = %I64d e = %I64d sum = %I64d', 0AH, 00H ; ASCII format string

q:		
		mov r10,[rsp+40]; r10 = q param 5 {e}

		mov r11, 0		;sum = 0
		add r11, rcx	;sum+= a
		add r11, rdx	;sum+= b
		add r11, r8		;sum+= c
		add r11, r9		;sum+= d
		add r11, r10	;sum+= e

		sub rsp, 56		;allocate shadow space

		mov [rsp+48], r11 ; printf param 7 = sum
		mov [rsp+40], r10 ; printf param 6 = e
		mov [rsp+32], r9  ; printf param 5 = d


		mov r12, rdx	;temp = b
		mov rdx, rcx	;param 2 = a
		mov rbx, r8		;temp2  = c
		mov r8, r12		;param 3 = b
		mov r9, rbx		;param 4 = c

		
		lea rcx, fxp2		; printf param 1 = fxp2
		call printf
		
		mov rax, [rsp+48]
		add rsp, 56		;deallocate shadow space
		ret 

public qns
fxp3 db 'qns\n', 0AH, 00H		;ASCII format string

qns:	
	;	sub rsp, 32				;allocate shadow space

		lea rcx, fxp3			;param a = fxp2
	
		call printf

		mov rax, 0
	;	add rsp, 32				;deallocate shadow space
		ret
end