#include "archdep.h"

        .word $02d7
        * = $02d7

_autoStart
l2d7    lda #COL_BLACK
        sta VicScreenCtrlReg1
        sta VicBorderColor
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
l302        
        .word _autoStart
        .byt $f1
