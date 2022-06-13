#include "archdep.h"

        .word $1001
        * = $1001

        .word _basicEol         ; next
        .word $000a             ; line number: 10
        .byt $9e                ; token: SYS
        .aasc " 4112"           ; SYS 4112 -> jump to $100e (_asmStart)
        .byt $00                ; EOL (end of line)
_basicEol
        .byt $00,$00            ; EOP (End of program)
        .byt $00,$00

_asmStart
        lda #COL_BLACK
;        sta VicScreenCtrlReg1
        sta TedBorderColor
        lda #$02
        ldx #$08
        ldy #$00
        jsr SETLFS              ; setlfs 2,8,0
        lda #$05                ; file name length
        ldx #<_fnHello
        ldy #>_fnHello
        jsr SETNAM
        lda #$00
        ldx #<hello             ; load address
        ldy #>hello
        jsr LOAD
        jmp $8000
_fnHello
        .aasc "HELLO"
