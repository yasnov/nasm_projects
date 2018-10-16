%include "stud_io.inc"

%define SYMBOL '*'
%define MAX 5

global _start

section .bss
array	resb 5 ;указатель 


section .text

_start:		mov edi, array 		; Загрузить адрес указателя
		mov byte [array+MAX], SYMBOL 	; поместить ограничитель
		PRINT "Введите строку: "
			
again:		GETCHAR 			
		cmp eax, 10 	; равен ли символ '\n'
		je in_out 
		cmp eax, SYMBOL 	; равен ли символ ограничителю?
		je input_err 
					

push:		mov [edi], al 	; записать элемент в стек
		inc edi			; переход к след. элементу

		cmp byte [array+MAX], SYMBOL	 ; достигнута ли граница?
		jne over_err 
		jmp again 
		
in_out:		
			
			
; Вывод стека

out:		PUTCHAR 10
		PRINT "Содеримое стека: "
		mov edi, array

prepare:	inc edi
		cmp byte [edi], SYMBOL	 ; достигнут ли ограничитель?
		jne prepare
						
pop:		dec edi
		PUTCHAR [edi]
		cmp edi,array 
		jne pop
		PUTCHAR 10
		FINISH

; Метки для ошибок

input_err:	PUTCHAR 10
		PRINT "Недопустимый символ!"
		FINISH	
			
over_err: 	PUTCHAR 10
		PRINT "Переполнение стека!"
		FINISH		
