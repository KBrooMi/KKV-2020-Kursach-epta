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
	_DIVISION_BY_ZERO_ERROR BYTE 'Ошибка выполнения: деление на ноль', 0
	l0 SDWORD 00000000000000000000000000000010y
	l1 SDWORD 00000000000000000000000000000101y
	l2 SDWORD 00000000000000000000000000001010y
	l3 SDWORD 00000000000000000000000000000011y
	l4 BYTE 'Hello, ', 0
	l5 BYTE 'World!', 0
	l6 BYTE 'KypcoBou!', 0
	l7 SDWORD 00000000000000000000000000000000y
.data
	_Sumsum		SDWORD 0 ;INT
	_maina		SDWORD 0 ;INT
	_mainb		SDWORD 0 ;INT
	_mainc		SDWORD 0 ;INT
	_mainout		SDWORD 0 ;INT
	_mainsa		SDWORD 0 ;STR
	_mainsb		SDWORD 0 ;STR
	_mainconcatenated		SDWORD 0 ;STR
	_mainiterator		SDWORD 0 ;INT

.code
_Sum PROC _Sumb: DWORD, _Suma: DWORD
	push		_Suma
	push		_Sumb
	;\/Сложение\/
	pop		eax
	pop		ebx
	add		eax, ebx
	push		eax
	;/\Сложение/\
	pop			_Sumsum

	mov		eax, _Sumsum
	ret		8
_Sum ENDP

main PROC
	push		l0
	push		l1
	;\/Умножение\/
	pop		eax
	pop		ebx
	mul		ebx
	push		eax
	;/\Умножение/\
	pop			_maina

	push		l2
	push		l0
	;\/Деление\/
	pop		ebx
	mov		edx, 0
	pop		eax
	.if ebx == 0
	push offset _DIVISION_BY_ZERO_ERROR
	call _ConsoleWrite
	invoke		ExitProcess, -1
	.endif
	idiv		ebx
	push		eax
	;/\Деление/\
	pop			_mainb

	push		l2
	push		l3
	;\/Остаток от деления\/
	pop		ebx
	mov		edx, 0
	pop		eax
	.if ebx == 0
	push offset _DIVISION_BY_ZERO_ERROR
	call _ConsoleWrite
	invoke		ExitProcess, -1
	.endif
	idiv		ebx
	push		edx
	;/\Остаток от деления/\
	pop			_mainc

	push		_mainb
	push		_mainc
	call		_Sum
	push		eax
	pop			_mainout

	push		_maina
	call		_ConsoleWriteInt

	push		_mainb
	call		_ConsoleWriteInt

	push		_mainc
	call		_ConsoleWriteInt

	push		_mainout
	call		_ConsoleWriteInt

	push		offset l4
	pop			_mainsa

	push		offset l5
	pop			_mainsb

	push		_mainsa
	push		_mainsb
	call		_Concat
	push		eax
	pop			_mainconcatenated

	push		_mainconcatenated
	call		_ConsoleWrite

	push		offset _mainsb
	push		offset l6
	call		_Copy
	push		_mainsb
	call		_ConsoleWrite

	push		l2
	pop			_mainiterator

	.while		_mainiterator
	;\/Тело цикла\/
	push		_mainiterator
	call		_ConsoleWriteInt

	dec			_mainiterator
	;/\Тело цикла/\
	.endw
	push		l7
	call		ExitProcess
main ENDP
end main
