.586
.model flat, stdcall
includelib libucrt.lib
includelib kernel32.lib
includelib ../LP_LIB/Debug/LP_Lib.lib
ExitProcess PROTO : DWORD
Concat PROTO : DWORD, :DWORD
ConvertToChar PROTO : DWORD
Copy PROTO : DWORD, : DWORD
ConsoleWrite PROTO : DWORD
ConsoleWriteInt PROTO : DWORD


.stack 4096
.const
	l0 DWORD 00000000000000000000000000000001y
	l1 DWORD 00000000000000000000000000000010y
	l2 DWORD 00000000000000000000000000000101y
	l3 DWORD 00000000000000000000000000001010y
	l4 DWORD 00000000000000000000000000000011y
	l5 DWORD 11111111111111111111111111111111y
	l6 BYTE 'Арифметические операции', 0
	l7 BYTE 'Hello, ', 0
	l8 BYTE 'World!', 0
	l9 BYTE 'Операции со строками', 0
	l10 BYTE 'Работа с функциями', 0
	l11 BYTE 'Начало цикла', 0
	l12 BYTE 'Конец цикла', 0
	l13 DWORD 00000000000000000000000000000000y
.data
	Sumsum			DWORD 0
	Raznsub			DWORD 0
	Multimul			DWORD 0
	Divisiondiv			DWORD 0
	RemOfDivremofdiv			DWORD 0
	maina			DWORD 0
	mainb			DWORD 0
	mainc			DWORD 0
	maind			DWORD 0
	maine			DWORD 0
	mainf			DWORD 0
	mainsa			DWORD 0
	mainsb			DWORD 0
	mainconcatenated			DWORD 0
	mainx			DWORD 0
	mainy			DWORD 0
	mainout			DWORD 0
	mainiterator			DWORD 0

.code
Sum PROC b: DWORD, a: DWORD
	push		a
	push		b
	;\/Сложение\/
	pop		eax
	pop		ebx
	add		eax, ebx
	push		eax
	;/\Сложение/\
	pop			Sumsum

	mov		eax, Sumsum
	ret		8
Sum ENDP

Razn PROC b: DWORD, a: DWORD
	push		a
	push		b
	;\/Вычитание\/
	pop		ebx
	pop		eax
	sub		eax, ebx
	push		eax
	;/\Вычитание/\
	pop			Raznsub

	mov		eax, Raznsub
	ret		8
Razn ENDP

Multi PROC b: DWORD, a: DWORD
	push		a
	push		b
	;\/Умножение\/
	pop		eax
	pop		ebx
	mul		ebx
	push		eax
	;/\Умножение/\
	pop			Multimul

	mov		eax, Multimul
	ret		8
Multi ENDP

Division PROC b: DWORD, a: DWORD
	push		a
	push		b
	;\/Деление\/
	pop		ebx
	mov		edx, 0
	pop		eax
	div		ebx
	push		eax
	;/\Деление/\
	pop			Divisiondiv

	mov		eax, Divisiondiv
	ret		8
Division ENDP

RemOfDiv PROC b: DWORD, a: DWORD
	push		a
	push		b
	;\/Остаток от деления\/
	pop		ebx
	mov		edx, 0
	pop		eax
	div		ebx
	push		edx
	;/\Остаток от деления/\
	pop			RemOfDivremofdiv

	mov		eax, RemOfDivremofdiv
	ret		8
RemOfDiv ENDP

main PROC
	push		l0
	push		l1
	;\/Сложение\/
	pop		eax
	pop		ebx
	add		eax, ebx
	push		eax
	;/\Сложение/\
	push		l1
	push		l0
	;\/Сложение\/
	pop		eax
	pop		ebx
	add		eax, ebx
	push		eax
	;/\Сложение/\
	;\/Вычитание\/
	pop		ebx
	pop		eax
	sub		eax, ebx
	push		eax
	;/\Вычитание/\
	pop			maina

	push		l1
	push		l0
	;\/Вычитание\/
	pop		ebx
	pop		eax
	sub		eax, ebx
	push		eax
	;/\Вычитание/\
	pop			mainb

	push		l1
	push		l2
	;\/Умножение\/
	pop		eax
	pop		ebx
	mul		ebx
	push		eax
	;/\Умножение/\
	pop			mainc

	push		l3
	push		l1
	;\/Деление\/
	pop		ebx
	mov		edx, 0
	pop		eax
	div		ebx
	push		eax
	;/\Деление/\
	pop			maind

	push		l3
	push		l4
	;\/Остаток от деления\/
	pop		ebx
	mov		edx, 0
	pop		eax
	div		ebx
	push		edx
	;/\Остаток от деления/\
	pop			maine

	push		l5
	pop			mainf

	push		offset l6
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

	push		offset l6
	call		ConsoleWrite

	push		offset l7
	pop			mainsa

	push		offset l8
	pop			mainsb

	push		offset l9
	call		ConsoleWrite

	push		mainsa
	call		ConsoleWrite

	push		mainsb
	call		ConsoleWrite

	push		mainsa
	push		mainsb
	call		Concat
	push		eax
	pop			mainconcatenated

	push		mainconcatenated
	call		ConsoleWrite

	push		offset mainsb
	push		mainsa
	call		Copy
	push		mainsb
	call		ConsoleWrite

	push		offset l9
	call		ConsoleWrite

	push		l3
	pop			mainx

	push		l2
	pop			mainy

	push		offset l10
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

	push		offset l10
	call		ConsoleWrite

	push		l3
	pop			mainiterator

	push		offset l11
	call		ConsoleWrite

	.while		mainiterator
	;\/Тело цикла\/
	push		mainiterator
	call		ConsoleWriteInt

	dec			mainiterator
	;/\Тело цикла/\
	.endw
	push		offset l12
	call		ConsoleWrite

	push		l13
	call		ExitProcess
main ENDP
end main
