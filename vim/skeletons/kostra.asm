%include "asm_io.inc"


segment .data

   message db  "Hello world!", '10', 0

segment .bss   ;uninitialized data


segment .text

   global asm_main
asm_main:
   enter 0,0               ; setup routine
   pusha

   mov eax, message
   call print_string

   popa
   mov   eax, 3            ; return back to C
   leave
   ret
