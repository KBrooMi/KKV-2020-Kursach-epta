.586
.model flat, stdcall
includelib libucrt.lib
includelib kernel32.lib
includelib ../LP_LIB/Debug/LP_Lib.lib
ExitProcess PROTO : DWORD
Concat PROTO : DWORD, :DWORD
Copy PROTO : DWORD, : DWORD
ConsoleWrite PROTO : DWORD
ConsoleWriteInt PROTO : DWORD


.stack 4096
.const
	l0 DWORD 00000000000000000000000111111111y
	l1 DWORD 00000000000000000000000000000001y
	l2 DWORD 00000000000000000000000000000010y
	l3 DWORD 00000000000000000000000000000101y
	l4 DWORD 00000000000000000000000000001010y
	l5 DWORD 00000000000000000000000000000011y
	l6 DWORD 11111111111111111111111111111111y
	l7 BYTE '�������������� ��������', 0
	l8 BYTE 'Hello, ', 0
	l9 BYTE 'World!', 0
	l10 BYTE '�������� �� ��������', 0
	l11 BYTE 'asd', 0
	l12 BYTE '������ � ���������', 0
	l13 BYTE '������ �����', 0
	l14 BYTE '����� �����', 0
	l15 DWORD 00000000000000000000000000000000y
.data
	Sumsum		DWORD 0 ;INT
	Raznsub		DWORD 0 ;INT
	Multimul		DWORD 0 ;INT
	Divisiondiv		DWORD 0 ;INT
	RemOfDivremofdiv		DWORD 0 ;INT
	maina		DWORD 0 ;INT
	mainb		DWORD 0 ;INT
	mainc		DWORD 0 ;INT
	maind		DWORD 0 ;INT
	maine		DWORD 0 ;INT
	mainf		DWORD 0 ;INT
	mainsa		DWORD 0 ;STR
	mainsb		DWORD 0 ;STR
	mainconcatenated		DWORD 0 ;STR
	mainr		DWORD 0 ;INT
	mainx		DWORD 0 ;INT
	mainy		DWORD 0 ;INT
	mainout		DWORD 0 ;INT
	mainiterator		DWORD 0 ;INT

.code
Sum PROC b: DWORD, a: DWORD
	push		a
	push		b
	;\/��������\/
	pop		eax
	pop		ebx
	add		eax, ebx
	push		eax
	;/\��������/\
	pop			Sumsum

	mov		eax, l0
	ret		8
Sum ENDP

Razn PROC b: DWORD, a: DWORD
	push		a
	push		b
	;\/���������\/
	pop		ebx
	pop		eax
	sub		eax, ebx
	push		eax
	;/\���������/\
	pop			Raznsub

	mov		eax, Raznsub
	ret		8
Razn ENDP

Multi PROC b: DWORD, a: DWORD
	push		a
	push		b
	;\/���������\/
	pop		eax
	pop		ebx
	mul		ebx
	push		eax
	;/\���������/\
	pop			Multimul

	mov		eax, Multimul
	ret		8
Multi ENDP

Division PROC b: DWORD, a: DWORD
	push		a
	push		b
	;\/�������\/
	pop		ebx
	mov		edx, 0
	pop		eax
	div		ebx
	push		eax
	;/\�������/\
	pop			Divisiondiv

	mov		eax, Divisiondiv
	ret		8
Division ENDP

RemOfDiv PROC b: DWORD, a: DWORD
	push		a
	push		b
	;\/������� �� �������\/
	pop		ebx
	mov		edx, 0
	pop		eax
	div		ebx
	push		edx
	;/\������� �� �������/\
	pop			RemOfDivremofdiv

	mov		eax, RemOfDivremofdiv
	ret		8
RemOfDiv ENDP

main PROC
	push		l1
	push		l2
	;\/��������\/
	pop		eax
	pop		ebx
	add		eax, ebx
	push		eax
	;/\��������/\
	push		l2
	push		l1
	;\/��������\/
	pop		eax
	pop		ebx
	add		eax, ebx
	push		eax
	;/\��������/\
	;\/���������\/
	pop		ebx
	pop		eax
	sub		eax, ebx
	push		eax
	;/\���������/\
	pop			maina

	push		l2
	push		l1
	;\/���������\/
	pop		ebx
	pop		eax
	sub		eax, ebx
	push		eax
	;/\���������/\
	pop			mainb

	push		l2
	push		l3
	;\/���������\/
	pop		eax
	pop		ebx
	mul		ebx
	push		eax
	;/\���������/\
	pop			mainc

	push		l4
	push		l2
	;\/�������\/
	pop		ebx
	mov		edx, 0
	pop		eax
	div		ebx
	push		eax
	;/\�������/\
	pop			maind

	push		l4
	push		l5
	;\/������� �� �������\/
	pop		ebx
	mov		edx, 0
	pop		eax
	div		ebx
	push		edx
	;/\������� �� �������/\
	pop			maine

	push		l6
	pop			mainf

	push		offset l7
	call		ConsoleWrite

	push		maina
	call		ConsoleWriteInt

	push		mainb
	call		ConsoleWriteInt

	push		mainc
	call		ConsoleWriteInt

	push		maind
	call		ConsoleWriteInt

	push		maine
	call		ConsoleWriteInt

	push		mainf
	call		ConsoleWriteInt

	push		offset l7
	call		ConsoleWrite

	push		offset l8
	pop			mainsa

	push		offset l9
	pop			mainsb

	push		offset l10
	call		ConsoleWrite

	push		mainsa
	call		ConsoleWrite

	push		mainsb
	call		ConsoleWrite

	push		offset l11
	push		offset l11
	;\/��������\/
	pop		eax
	pop		ebx
	add		eax, ebx
	push		eax
	;/\��������/\
	pop			mainconcatenated

	push		mainconcatenated
	call		ConsoleWrite

	push		offset mainsb
	push		mainsa
	call		Copy
	push		eax
	pop			mainr

	push		mainr
	call		ConsoleWriteInt

	push		mainsb
	call		ConsoleWrite

	push		offset l10
	call		ConsoleWrite

	push		l4
	pop			mainx

	push		l3
	pop			mainy

	push		offset l12
	call		ConsoleWrite

	push		mainx
	push		mainy
	call		Sum
	push		eax
	pop			mainout

	push		mainout
	call		ConsoleWriteInt

	push		mainx
	push		mainy
	call		Razn
	push		eax
	pop			mainout

	push		mainout
	call		ConsoleWriteInt

	push		mainx
	push		mainy
	call		Multi
	push		eax
	pop			mainout

	push		mainout
	call		ConsoleWriteInt

	push		mainx
	push		mainy
	call		Division
	push		eax
	pop			mainout

	push		mainout
	call		ConsoleWriteInt

	push		mainx
	push		mainy
	call		RemOfDiv
	push		eax
	pop			mainout

	push		mainout
	call		ConsoleWriteInt

	push		offset l12
	call		ConsoleWrite

	push		l4
	pop			mainiterator

	push		offset l13
	call		ConsoleWrite

	.while		mainiterator
	;\/���� �����\/
	push		mainiterator
	call		ConsoleWriteInt

	dec			mainiterator
	;/\���� �����/\
	.endw
	push		offset l14
	call		ConsoleWrite

	push		l15
	call		ExitProcess
main ENDP
end main
