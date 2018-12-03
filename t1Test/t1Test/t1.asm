.686                                ; create 32 bit code
.model flat, C                      ; 32 bit memory model
 option casemap:none                ; case sensitive

.data				;start of the data section
public	g			;export variable g
g		DWORD	4	;declare global variable g initialised to 4



.code				;start of a code section

public		min
min:	push	ebp				;push frame pointer
		mov		ebp, esp		;update ebp
		sub		esp, 4			;space for local variable g

		mov		eax,[ebp+8]			;eax=a
		mov		[esp-4], eax		;v=eax (a)

		;if(b<v) v=b

		mov		eax,[ebp+12]		;eax = b
		cmp		eax,[esp-4]			;if(b<v)
		jge		min0

		mov		[esp-4], eax		;v=b

min0:	mov		eax,[ebp+16]		;eax = c
		cmp		eax,[esp-4]
		jge		min1
			
		mov		[esp-4], eax		;v=c


min1:	mov		eax, [esp-4]		;eax = v
		mov		esp,ebp				;restore esp
		pop		ebp					;restore previous ebp
		ret		0					;return from function


public		p

p:		push	ebp					;push frame pointer
		mov		ebp, esp			;update ebp

		push	[ebp+20]			;push l
		push	[ebp+16]			;push k

		push	[ebp+12]			;push j
		push	[ebp+8]				;push i
		push	g					;push g

		call	min					;min(g,i,j)
		add		esp, 12				;remove params from stack
		push	eax					;push result of min(g,i,j)

		call	min					;min(min(g,i,j),k,l)
		add		esp, 8				;remove params from stack

		mov		esp,ebp				;restore esp
		pop		ebp					;restore previous ebp
		ret		0

public		gcd

gcd:	push	ebp					;push frame pointer
		mov		ebp, esp			;update epb

		mov		eax, [ebp+12]		;eax = b
		cmp		eax,0				;if(b==0)
		je		gcd0		
			
		mov		eax, [ebp+8]		; eax = a		
		mov		edx, 0				; edx = 0
		mov		ebx, [ebp+12]		; (divisor) ebx = b
		div		ebx

		mov		eax, edx			; eax = remainder

		push	eax					; push a%b
		push	ebx					; push b

		call	gcd					; gcd(b, a%b)
		add		esp, 8				; remove params from stack
		jmp		gcd1

gcd0:
		mov		eax,[ebp+8]			; eax = a
gcd1:
		mov		esp, ebp			;restore esp
		pop		ebp					;restore previous ebp
		ret		0					; return
end		