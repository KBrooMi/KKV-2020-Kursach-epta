.586
.model flat, stdcall
includelib libucrt.lib
includelib kernel32.lib
includelib ../LP_LIB/Debug/LP_Lib.lib
ExitProcess PROTO : DWORD
_Concat PROTO : DWORD, :DWORD
_Copy PROTO : DWORD, : DWORD
_ConsoleWrite PROTO : DWORD
_ConsoleWriteInt PROTO : DWORD


.stack 4096
.const
	l0 DWORD 00000000000000000000000111111111y
	l1 DWORD 00000000000000000000000000000001y
	l2 DWORD 00000000000000000000000000000010y
	l3 DWORD 00000000000000000000000000000101y
	l4 DWORD 00000000000000000000000000001010y
	l5 DWORD 00000000000000000000000000000011y
	l6 DWORD 11111111111111111111111111111111y
	l7 BYTE 'Арифметические операции', 0
	l8 BYTE 'Hello, ', 0
	l9 BYTE 'World!', 0
	l10 BYTE 'Операции со строками', 0
	l11 BYTE 'dsa', 0
	l12 BYTE 'asd', 0
	l13 BYTE 'Работа с функциями', 0
	l14 BYTE 'Начало цикла', 0
	l15 BYTE 'Конец цикла', 0
	l16 DWORD 00000000000000000000000000000000y
.data
	_Sumf		DWORD 0 ;INT
	_Sumsb		DWORD 0 ;STR
	_Sumsa		DWORD 0 ;STR
	_Sumsum		DWORD 0 ;INT
	_Raznsub		DWORD 0 ;INT
	_Multimul		DWORD 0 ;INT
	_Divisiondiv		DWORD 0 ;INT
	_RemOfDivremofdiv		DWORD 0 ;INT
	_maina		DWORD 0 ;INT
	_mainb		DWORD 0 ;INT
	_mainc		DWORD 0 ;INT
	_maind		DWORD 0 ;INT
	_maine		DWORD 0 ;INT
	_mainf		DWORD 0 ;INT
	_mainsa		DWORD 0 ;STR
	_mainsb		DWORD 0 ;STR
	_mainconcatenated		DWORD 0 ;STR
	_mainx		DWORD 0 ;INT
	_mainy		DWORD 0 ;INT
	_mainout		DWORD 0 ;INT
	_mainiterator		DWORD 0 ;INT

.code
_Sum PROC _b: DWORD, _a: DWORD
	push		offset _Sumsb
	push		_Sumsa
	call		_Copy
	push		eax
	pop			_Sumf

	push		_a
	push		_b
	;\/Сложение\/
	pop		eax
	pop		ebx
	add		eax, ebx
	push		eax
	;/\Сложение/\
	pop			_Sumsum

	mov		eax, l0
	ret		8
_Sum ENDP

_Razn PROC _b: DWORD, _a: DWORD
	push		_a
	push		_b
	;\/Вычитание\/
	pop		ebx
	pop		eax
	sub		eax, ebx
	push		eax
	;/\Вычитание/\
	pop			_Raznsub

	mov		eax, _Raznsub
	ret		8
_Razn ENDP

_Multi PROC _b: DWORD, _a: DWORD
	push		_a
	push		_b
	;\/Умножение\/
	pop		eax
	pop		ebx
	mul		ebx
	push		eax
	;/\Умножение/\
	pop			_Multimul

	mov		eax, _Multimul
	ret		8
_Multi ENDP

_Division PROC _b: DWORD, _a: DWORD
	push		_a
	push		_b
	;\/Деление\/
	pop		ebx
	mov		edx, 0
	pop		eax
	div		ebx
	push		eax
	;/\Деление/\
	pop			_Divisiondiv

	mov		eax, _Divisiondiv
	ret		8
_Division ENDP

_RemOfDiv PROC _b: DWORD, _a: DWORD
	push		_a
	push		_b
	;\/Остаток от деления\/
	pop		ebx
	mov		edx, 0
	pop		eax
	div		ebx
	push		edx
	;/\Остаток от деления/\
	pop			_RemOfDivremofdiv

	mov		eax, _RemOfDivremofdiv
	ret		8
_RemOfDiv ENDP

main PROC
	push		l1
	push		l2
	;\/Сложение\/
	pop		eax
	pop		ebx
	add		eax, ebx
	push		eax
	;/\Сложение/\
	push		l2
	push		l1
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
	pop			_maina

	push		l2
	push		l1
	;\/Вычитание\/
	pop		ebx
	pop		eax
	sub		eax, ebx
	push		eax
	;/\Вычитание/\
	pop			_mainb

	push		l2
	push		l3
	;\/Умножение\/
	pop		eax
	pop		ebx
	mul		ebx
	push		eax
	;/\Умножение/\
	pop			_mainc

	push		l4
	push		l2
	;\/Деление\/
	pop		ebx
	mov		edx, 0
	pop		eax
	div		ebx
	push		eax
	;/\Деление/\
	pop			_maind

	push		l4
	push		l5
	;\/Остаток от деления\/
	pop		ebx
	mov		edx, 0
	pop		eax
	div		ebx
	push		edx
	;/\Остаток от деления/\
	pop			_maine

	push		l6
	pop			_mainf

	push		offset l7
	call		_ConsoleWrite

	push		_maina
	call		_ConsoleWriteInt

	push		_mainb
	call		_ConsoleWriteInt

	push		_mainc
	call		_ConsoleWriteInt

	push		_maind
	call		_ConsoleWriteInt

	push		_maine
	call		_ConsoleWriteInt

	push		_mainf
	call		_ConsoleWriteInt

	push		offset l7
	call		_ConsoleWrite

	push		offset l8
	pop			_mainsa

	push		offset l9
	pop			_mainsb

	push		offset l10
	call		_ConsoleWrite

	push		_mainsa
	call		_ConsoleWrite

	push		_mainsb
	call		_ConsoleWrite

	push		offset l11
	push		offset l12
	call		_Concat
	push		eax
	pop			_mainconcatenated

	push		_mainconcatenated
	call		_ConsoleWrite

	push		offset _mainsb
	push		offset l12
	call		_Copy
	push		_mainsb
	call		_ConsoleWrite

	push		offset l10
	call		_ConsoleWrite

	push		l4
	pop			_mainx

	push		l3
	pop			_mainy

	push		offset l13
	call		_ConsoleWrite

	push		_mainx
	push		_mainy
	call		_Sum
	push		eax
	pop			_mainout

	push		_mainout
	call		_ConsoleWriteInt

	push		_mainx
	push		_mainy
	call		_Razn
	push		eax
	pop			_mainout

	push		_mainout
	call		_ConsoleWriteInt

	push		_mainx
	push		_mainy
	call		_Multi
	push		eax
	pop			_mainout

	push		_mainout
	call		_ConsoleWriteInt

	push		_mainx
	push		_mainy
	call		_Division
	push		eax
	pop			_mainout

	push		_mainout
	call		_ConsoleWriteInt

	push		_mainx
	push		_mainy
	call		_RemOfDiv
	push		eax
	pop			_mainout

	push		_mainout
	call		_ConsoleWriteInt

	push		offset l13
	call		_ConsoleWrite

	push		l4
	pop			_mainiterator

	push		offset l14
	call		_ConsoleWrite

	.while		_mainiterator
	;\/Тело цикла\/
	push		_mainiterator
	call		_ConsoleWriteInt

	dec			_mainiterator
	;/\Тело цикла/\
	.endw
	push		offset l15
	call		_ConsoleWrite

	push		l16
	call		ExitProcess
main ENDP
end main
