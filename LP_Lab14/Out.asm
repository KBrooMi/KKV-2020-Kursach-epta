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
	_DIVISION_BY_ZERO_ERROR BYTE '������ ����������: ������� �� ����', 0
	l0 DWORD 00000000000000000000000000000010y
	l1 DWORD 00000000000000000000000000000101y
	l2 DWORD 00000000000000000000000000001010y
	l3 DWORD 00000000000000000000000000000011y
	l4 BYTE 'Hello, ', 0
	l5 BYTE 'World!', 0
	l6 BYTE 'asd', 0
	l7 DWORD 00000000000000000000000000000000y
.data
	_Sumsum		DWORD 0 ;INT
	_maina		DWORD 0 ;INT
	_mainb		DWORD 0 ;INT
	_mainc		DWORD 0 ;INT
	_mainout		DWORD 0 ;INT
	_mainsa		DWORD 0 ;STR
	_mainsb		DWORD 0 ;STR
	_mainconcatenated		DWORD 0 ;STR
	_mainiterator		DWORD 0 ;INT

.code
_Sum PROC _b: DWORD, _a: DWORD
	push		_a
	push		_b
	;\/��������\/
	pop		eax
	pop		ebx
	add		eax, ebx
	push		eax
	;/\��������/\
	pop			_Sumsum

	mov		eax, _Sumsum
	ret		8
_Sum ENDP

main PROC
	push		l0
	push		l1
	;\/���������\/
	pop		eax
	pop		ebx
	mul		ebx
	push		eax
	;/\���������/\
	pop			_maina

	push		l2
	push		l0
	;\/�������\/
	pop		ebx
	mov		edx, 0
	pop		eax
	.if ebx == 0
	push offset _DIVISION_BY_ZERO_ERROR
	call _ConsoleWrite
	invoke		ExitProcess, -1
	.endif
	div		ebx
	push		eax
	;/\�������/\
	pop			_mainb

	push		l2
	push		l3
	;\/������� �� �������\/
	pop		ebx
	mov		edx, 0
	pop		eax
	.if ebx == 0
	push offset _DIVISION_BY_ZERO_ERROR
	call _ConsoleWrite
	invoke		ExitProcess, -1
	.endif
	div		ebx
	push		edx
	;/\������� �� �������/\
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
	;\/���� �����\/
	push		_mainiterator
	call		_ConsoleWriteInt

	dec			_mainiterator
	;/\���� �����/\
	.endw
	push		l7
	call		ExitProcess
main ENDP
end main
