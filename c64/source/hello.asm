#include "archdep.h"

        .word $8000
        * = $8000

; hello
l8000   sei
        lda #$36
        sta $01
        lda #$7f
        sta Cia1IrqCtrlReg
        sta Cia2IrqCtrlReg
        lda Cia1IrqCtrlReg
        lda Cia2IrqCtrlReg
        lda #$18
        sta $1ffe
        lda #$60
        sta $1fff
        lda #$fe
        sta $0326
        lda #$1f
        sta $0327
        lda NMINV+1
        cmp #$ce
        beq l803d
        lda #$00
        sta NMINV               ; NMI vector
        lda #$ce
        sta NMINV+1
        lda #$40                ; opcode: RTI (exits NMI without acknowledging it)
        sta $ce00               ; store at new NMI location
l803d   lda #$00
        sta VicBorderColor
        sta VicBackgroundColor0
        jsr _clearScreen
        ldx #$00
l804a   lda #$01
        sta ColorRAM,x
        sta ColorRAM+$0100,x
        sta ColorRAM+$0200,x
        sta ColorRAM+$0300,x
        inx
        bne l804a
        lda #<_textSplashScreen
        sta _textPtr
        lda #>_textSplashScreen
        sta _textPtr+1
        lda #$18
        sta $fe
        lda #$05
        sta $ff
        jsr _printText
        lda #$17
        sta VicMemCtrlReg
        lda #$08
        sta VicScreenCtrlReg2
        lda #$17
        sta VicScreenCtrlReg1
        lda #$00
        tay
        sta $fe
        sta $fc
        lda #$84                ; source: $8400
        sta $ff
        lda #$c0                ; destination: $c000
        sta $fd
        ldx #$07
l8090   lda ($fe),y
        sta ($fc),y
        iny
        bne l8090
        inc $ff
        inc $fd
        dex
        bpl l8090
        ldx #$10
        jsr loadFile            ; load file "DD" (disk drive type)
        lda #$83                ; IMAIN = $a483 (default)
        sta IMAIN               ; Vector: BASIC Warm Start
        lda #$a4
        sta IMAIN+1
        lda #$48                ; KEYLOG = $eb48 (default)
        sta KEYLOG              ; Vector: Keyboard Table Setup
        lda #$eb
        sta KEYLOG+1
        lda #$a5                ; ILOAD = $f4a5 (default)
        sta ILOAD               ; KERNAL LOAD Routine
        lda #$f4
        sta ILOAD+1
        jsr SCNKEY              ; read keyboard
        jsr GETIN
        cmp #$20                ; user holds down space bar?
        beq l80d0               ; yes ->
        lda $b000               ; saved drive selection
        bne l80d3               ; if not 0, skip ->
_
l80d0   jsr _selectDriveType
l80d3   lda $b000               ; selected drive type
        cmp #$02                ; no fast loader requested ->
        beq l80e6
        sei
        lda #<_sizzleLoad       ; ILOAD = $c042 (Sizzle load routine)
        sta ILOAD               ; KERNAL LOAD Routine
        lda #>_sizzleLoad
        sta ILOAD+1
        cli
l80e6   ldx #<_fnUJ             ; execute: UJ (reset floppy drive)
        ldy #>_fnUJ
        lda #$02                ; file name length "UJ"
        jsr SETNAM
        lda #$0f
        tay
        ldx #$08
        jsr SETLFS              ; setlfs 15,8,15
        jsr OPEN                ; open
l80fa   lda #$0c
        sta $08
        ldx #$00
        ldy #$00
l8102   dex
        bne l8102
        dey
        bne l8102
        dec $08
        bpl l8102

        lda #$0f
        jsr CLOSE               ; close 15
        ldx #$0e
        jsr loadFile            ; load file "LO",$0800
        ldx #$00
        jsr saveFile            ; save file "DD"
l811b   jmp $0c00


_textSplashScreen
l811e   .aasc $90,$40,$40,$40,$40,$40,$40,$40,$40,$ff
        .aasc $90,"Ultima I",$ff
        .aasc $90,$40,$40,$40,$40,$40,$40,$40,$40,$ff
        .aasc $ff
        .aasc $87,"The First Age of Darkness",$ff
        .aasc $ff
        .aasc $ff
        .aasc $ff
        .aasc $ff
        .aasc $ff
        .aasc $ff
        .aasc $ff
        .aasc $ff
        .aasc $81,"Copyright 1986 by Origin Systems, Inc.",$00

_selectDriveType
        ldx #$ff                ; wait $10000 times
_selDriveTypeL1
        iny
        bne _selDriveTypeL1
        dex
        bne _selDriveTypeL1
        jsr _clearScreen
        lda #<screenRAM+80
        sta $fe
        lda #>screenRAM+80
        sta $ff
        lda #<_textDriveSelect
        sta _textPtr
        lda #>_textDriveSelect
        sta _textPtr+1
        jsr _printText
_selDriveTypeL2
        jsr SCNKEY
        jsr GETIN               ; read key
        cmp #$31                ; < '1'?
        bcc _selDriveTypeL2     ; yes ->
        cmp #$33                ; > '3'?
        bcs _selDriveTypeL2     ; yes ->
        sec
        sbc #$30                ; convert to 1 or 2
        sta $b000
        jsr _clearScreen
        rts


_textDriveSelect
l81c0
        .aasc "Please enter which type of disk drive",$ff
        .aasc "you will be using.  Your choice will",$ff
        .aasc "be saved to disk.  If you need to",$ff
        .aasc "change drives later, hold down the",$ff
        .aasc "space bar while Ultima I is loading to",$ff
        .aasc "return to this menu.",$ff
        .aasc $ff
        .aasc "     1. 1541 or 1571 drive",$ff
        .aasc "     2. Enhancer 2000 or MSD drive",$ff
        .aasc $ff
        .aasc "Note: With some 1571 drives, Ultima I",$ff
        .aasc "will not load correctly if you select",$ff
        .aasc "option 1.  If this happens to you,",$ff
        .aasc "just reboot and select option 2.",$00

_fnUJ
l835c
        .aasc "UJ"

_printText
        ldy #$00
_printTextL1
_textPtr = * + 1
        lda _textSplashScreen   ; read source byte
        beq _printTextEnd       ; end of text?
        bpl _printTextJ1
        cmp #$ff                ; end of line?
        beq _printTextNewline
        and #$7f                ; make printable char
        tay
        bne _printTextJ3
_printTextNewline
        ldy #$00
        lda $fe
        clc
        adc #CHAR_COLUMNS       ; move dest to next line
        sta $fe
        lda $ff
        adc #$00
        sta $ff
        bne _printTextJ3
_printTextJ1
        cmp #$60                ; < $60?
        bcc _printTextJ2        ; ->
        and #$1f
_printTextJ2
        sta ($fe),y
        iny
_printTextJ3
        inc _textPtr            ; inc source pointer
        bne _printTextL1
        inc _textPtr+1
        bne _printTextL1
_printTextEnd
        rts

_clearScreen
        lda #$00
        tax
_clearScreenL1
        lda #$20
        sta screenRAM,x
        sta screenRAM+$0100,x
        sta screenRAM+$0200,x
        sta screenRAM+$0300,x
        inx
        bne _clearScreenL1
        rts

        .asc "SYSTEM **********"
        .byt $00,$03,$80,$02,$00,$14,$01,$02,$01,$00,$00,$00,$04
l83c8   ora ($00,x)
        jsr $0000
        .byt $00,$00,$01,$00
        .asc ".S"
l83d3   cmp $d4d3,y
        cmp $cd
l83d8   sta $c008
        lda $42,x
        sta $c009
        sta $42,x
        dex
        bpl l83d8
l83e5   lda #$28
        sec
        sta $c008
        rts
        .asc ""
        .byt $3b
        .asc "}"
        .byt $00,$00,$00,$00,$59
        .asc "z"
l83f4   eor $5aff,y
        jmp $ff59
l83fa   jmp $ff59
l83fd   jmp $ff59

        * = $c000

lc000   clc
        bcc lc01b
lc003   lda #$a5                ; ILOAD = $f4a5 (default)
        sta ILOAD               ; KERNAL LOAD Routine
        lda #$f4
        sta ILOAD+1
        ldy #$00
lc00f   lda _textSizzleOn,y
        beq lc01a
        jsr SCNPNT              ; print character to screen
        iny
        bne lc00f
lc01a   rts

lc01b   
        lda #<_sizzleLoad       ; ILOAD = $c042 (Sizzle load routine)
        sta ILOAD               ; KERNAL LOAD Routine
        lda #>_sizzleLoad
        sta ILOAD+1
        ldy #(_textSizzleOff-_textSizzleOn)
;        ldy #$0d
        bne lc00f

_textSizzleOn
        .aasc $0d,"SIZZLE OFF",$0d,$00
_textSizzleOff
        .aasc $0d,"SIZZLE ON",$0d,$00

_sizzleLoad
lc042
        sta $93
        lda $93
        beq lc04d
lc048   lda $93
        jmp $f4a5
lc04d   ldy #$00
        lda (FNADR),y
        cmp #$24
        beq lc048
lc055   lda #$00
        sta $90
        jsr lc195
lc05c   jsr UNLSN
lc05f   bit $90
        beq lc064
lc063   rts
lc064   ldx #$10
        lda #$a0
lc068   sta lc46e,x
        dex
        bpl lc068
lc06e   lda (FNADR),y
        sta lc46e,y
        iny
        cpy $b7
        bcc lc06e
lc078   lda VicScreenCtrlReg1
        and #$07
        clc
        adc #$2f
        sta $fb
        lda Cia2PortA
        and #$07
        sta $fc
        ora #$20
        sta $fe
        lda #$ff
        ldx #$04
lc091   eor $fc
        rol
        rol
        dex
        bne lc091
lc098   rol
        sta $fd
        lda #$02
        sta $ff
        lda #$2c
        sta lc168
        lda #$c2
        sta lc169
        lda #$46
        sta lc1a2
        lda #$01
        sta lc1a3
        jsr lc155
lc0b6   jsr lc195
lc0b9   ldy #$00
lc0bb   lda _textME,y
        jsr CIOUT               ; output: "M-E",$46,$01
        iny
        cpy #$05
        bne lc0bb
        jsr UNLSN
lc0c9   jsr lc1aa
lc0cc   sei
        ldx #$b2
        ldy #$c2
        stx lc1dd
        sty lc1de
        lda #$02
        sta $ff
lc0db   jsr lc1da
lc0de   inc lc1de
        dec $ff
        bne lc0db
lc0e5   jsr lc26c
lc0e8   bit $c600
        bmi lc140
lc0ed   ldy $c3
        ldx $c4
        lda $b9
        beq lc0fb
lc0f5   ldy $c602
        ldx $c603
lc0fb   sty $ae
        stx $af
        ldx #$04
        lda $c600
        beq lc120
lc106   ldy #$00
lc108   lda $c600,x
        sta ($ae),y
        iny
        inx
        bne lc108
lc111   jsr lc148
lc114   jsr lc26c
lc117   lc118 = * + 1
        ldx #$02
        lda $c600
        bmi lc143
lc11e   bne lc106
lc120   ldy #$00
lc122   lda $c600,x
        sta ($ae),y
        iny
        inx
        cpx $c601
        bcc lc122
lc12e   lda $c600,x
        sta ($ae),y
        iny
        jsr lc148
lc137   clc
lc138   pha
        pla
        ldx $ae
        ldy $af
        cli
        rts
lc140   lda #$04
        lc143 = * + 1
; Instruction parameter jumped to.
        bit !$00a9
        sec
        bcs lc138
lc148   clc
        tya
        adc $ae
        sta $ae
        lda $af
        adc #$00
        sta $af
        rts
lc155   jsr lc195
lc158   ldy #$00
lc15a   lda _textMW,y
        jsr CIOUT
lc160   iny
        cpy #$06
        bne lc15a
lc165   ldy #$00
lc167   lc168 = * + 1
; Instruction parameter accessed.
        lc169 = * + 2
; Instruction parameter accessed.
        lda $ffff,y
        jsr CIOUT
lc16d   iny
        cpy #$20
        bcc lc167
lc172   lda lc168
        adc #$1f
        sta lc168
        bcc lc17f
lc17c   inc lc169
lc17f   clc
        lda lc1a2
        adc #$20
        sta lc1a2
        bcc lc18d
lc18a   inc lc1a3
lc18d   jsr UNLSN
lc190   dec $ff
        bne lc155
lc194   rts

lc195   lda FA                  ; current device number
        jsr LISTEN
        lda #$6f
        jmp SECOND

_textMW
lc19f   lc1a2 = * + 3
        lc1a3 = * + 4
        .aasc "M-W",$00,$00,$20

_textME
lc1a5
        .aasc "M-E",$46,$01

lc1aa   ldy #$1f
lc1ac   lda lc1ba,y
        and #$30
        ora $fc
        sta lc1ba,y
        dey
        bpl lc1ac
lc1b9   rts
lc1ba   .byt $07,$07,$27,$27,$07,$07,$27,$27,$17,$17,$37,$37,$17,$17,$37,$37
lc1ca   .byt $07,$27,$07,$27,$17,$37,$17,$37,$07,$27,$07,$27,$17,$37,$17,$37
lc1da   ldy #$00
lc1dc   lc1dd = * + 1
        lc1de = * + 2
        lda $ffff,y
        sta $c600,y
        iny
        bne lc1dc
lc1e5   bit Cia2PortA
        bvs lc1e5
lc1ea   lda $c600,y
        lsr
        lsr
        lsr
        lsr
        tax
lc1f2   sec
        lda VicRasterValue
        sbc $fb
        bcc lc1fe
lc1fa   and #$07
        beq lc1f2
lc1fe   lda $fe
        sta Cia2PortA
        nop
        lda lc1ba,x
        sta Cia2PortA
        lda lc1ca,x
        sta Cia2PortA
        lda $c600,y
        and #$0f
        tax
        lda lc1ba,x
        sta Cia2PortA
        lda lc1ca,x
        sta Cia2PortA
        nop
        lda $fc
        sta Cia2PortA
        iny
        bne lc1ea
lc22b   rts
lc22c   ldx #$00
lc22e   dex
        bne lc22e
lc231   sei
        jsr $0152
lc235   jmp $0500
lc238   ldy #$00
        lda #$08
        sta $1800
lc23f   ldx #$00
        lda #$01
lc243   bit $1800
        beq lc243
lc248   stx $1800
        lda $1800
        asl
        nop
        eor $1800
        asl
        asl
        asl
        asl
        sta $0103
        lda $1800
        asl
        nop
        eor $1800
        eor $0103
        sta $0500,y
        iny
        bne lc23f
lc26b   rts
lc26c   ldy #$00
lc26e   lda $fe
        sta Cia2PortA
lc273   bit Cia2PortA
        bvs lc273
lc278   sec
        lda VicRasterValue
        sbc $fb
        bcc lc284
lc280   and #$07
        beq lc278
lc284   lda $fc
        sta Cia2PortA
        nop
        nop
        nop
        nop
        nop
        lda $fd
        eor Cia2PortA
        rol
        rol
        nop
        eor Cia2PortA
        rol
        rol
        nop
        nop
        nop
        nop
        eor Cia2PortA
        rol
        rol
        nop
        eor Cia2PortA
        rol
        rol
        rol
        sta $c600,y
        iny
        bne lc26e
lc2b1   rts
lc2b2   inc $0181
        jsr $0152
lc2b8   cli
        jsr lc118
lc2bc   jsr $d042
lc2bf   sei
        lda #$15
        sta $1c07
        lda #$03
        sta $3c
        lda #$12
        ldx #$01
lc2cd   jsr $05e7
lc2d0   ldx #$07
lc2d2   lda $0561,x
        sta $3b
        ldy #$00
        lda ($3b),y
        cmp #$82
        bne lc2f7
lc2df   ldy #$03
lc2e1   lda $06b9,y
        cmp #$2a
        beq lc31b
lc2e8   cmp #$3f
        beq lc2f0
lc2ec   cmp ($3b),y
        bne lc2f7
lc2f0   iny
        cpy #$12
        bne lc2e1
lc2f5   beq lc31b
lc2f7   dex
        bpl lc2d2
lc2fa   ldx $0301
        lda $0300
        bne lc2cd
lc302   lda #$ff
        sta $0300
        jsr $058d
lc30a   lda #$3a
        sta $1c07
        cli
        jmp $d945
        .asc "bB"
        .byt $a2,$82,$62,$42,$22,$02
lc31b   ldy #$02
        lda ($3b),y
        tax
        dey
        lda ($3b),y
lc323   jsr $05e7
lc326   jsr $058d
lc329   ldx $0301
        lda $0300
        bne lc323
lc331   lda #$f7
        and $1c00
        sta $1c00
        lda #$3a
        sta $1c07
        rts
lc33f   ldy #$00
lc341   lda $0300,y
        lsr
        lsr
        lsr
        lsr
        tax
        lda $05d7,x
        tax
        lda #$01
lc34f   bit $1800
        beq lc34f
lc354   lda #$08
        sta $1800
        lda #$01
lc35b   bit $1800
        bne lc35b
lc360   stx $1800
        txa
        asl
        and #$0f
        sta $1800
        lda $0300,y
        and #$0f
        tax
        lda $05d7,x
        sta $1800
        asl
        and #$0f
        nop
        sta $1800
        nop
        nop
        nop
        lda #$00
        sta $1800
        iny
        bne lc341
lc388   rts
        .byt $00,$04,$01,$05,$08,$0c,$09,$0d,$02,$06,$03,$07
lc395   asl
        asl $0f0b
        stx $07
        sta $0300
        cmp $06
        php
        sta $06
        plp
        beq lc3b6
lc3a6   lda #$b0
        sta $00
        cli
lc3ab   bit $00
        bmi lc3ab
lc3af   sei
        lda $00
        cmp #$01
        bne lc404
lc3b6   lda #$ee
        sta $1c0c
        lda #$06
        sta $32
        lda #$00
        sta $33
        sta $30
        lda #$03
        sta $31
        jsr $0669
lc3cc   bvc lc3cc
lc3ce   clv
        lda $1c01
        sta $0300,y
        iny
        bne lc3cc
lc3d8   ldy #$ba
lc3da   bvc lc3da
lc3dc   clv
        lda $1c01
        sta $0100,y
        iny
        bne lc3da
lc3e6   jsr $f8e0
lc3e9   lda $38
        cmp $47
        beq lc3f3
lc3ef   lda #$22
        bne lc407
lc3f3   jsr $f5e9
lc3f6   cmp $3a
        beq lc3fe
lc3fa   lda #$23
        bne lc407
lc3fe   lda #$ec
        sta $1c0c
        rts
lc404   clc
        adc #$18
lc407   sta $44
        lda #$ff
        sta $0300
        jsr $058d
        .asc ")"
        .byt $3a,$8d,$07,$1c
        .asc "%"
        .byt $44,$4c
        .asc "HA"
lc41b   lda $12
        sta $16
        lda $13
        sta $17
        lda $06
        sta $18
        lda $07
        sta $19
        lda #$00
        eor $16
        eor $17
        eor $18
        eor $19
        sta $1a
        jsr $f934
lc43a   ldx #$5a
lc43c   jsr $06a4
lc43f   bvc lc43f
lc441   clv
        lda $1c01
        cmp !$0024,y
        beq lc451
lc44a   dex
        bne lc43c
lc44d   lda #$20
        bne lc407
lc451   iny
        cpy #$08
        bne lc43f
lc456   lda #$d0
        sta $1805
        lda #$21
lc45d   bit $1805
        bpl lc407
lc462   bit $1c00
        bmi lc45d
lc467   lda $1c01
        clv
        ldy #$00
        rts
lc46e   .asc "                "
        .byt $00,$00

; loadFile
lc480   jmp lc4f9
; saveFile
lc483   jmp _saveFile
lc486   jmp _loadFile
lc489   ldx lc4f8
        inx
        inx

_saveFile
lc48e   txa
        asl
        tax
        lda _fnTableSave,x
        sta _filename
        lda _fnTableSave+1,x
        sta _filename+1
        lda lc5e3,x
        sta lc58f
        lda lc5e3+1,x
        sta lc590
        lda lc5ef,x
        sta lc591
        lda lc5ef+1,x
        sta lc592
        lda #$04
        ldx #<_fnScratch
        ldy #>_fnScratch
        jsr SETNAM              ; setnam "S:GM"
        lda #$0f
        tay
        ldx #$08                ; setlfs 15,8,15
        jsr SETLFS
        jsr OPEN                ; open
        lda #$0f
        jsr CLOSE               ; close 15

        lda #$02
        ldx #$08
        ldy #$ff
        jsr SETLFS              ; setlfs 2,8,255
        lda #$02
        ldx #<_filename
        ldy #>_filename
        jsr SETNAM              ; setnam <filename>
        lda lc58f
        sta $60
        lda lc590
        sta $61
        lda #$60
        ldx lc591
        ldy lc592
        jsr SAVE
lc4f5   jmp _readDriveStatus

lc4f8   .byt $00

lc4f9   cpx #$05
        bne _loadFile
lc4fd   lda $01
        and #$fd
        sta $01
        lda #$00
        tay
        sta $60
        lda #$e0                ; source: $e000
        sta $61
        lda #$9e                ; destination: $8c9e
        sta $62
        lda #$8c
        sta $63
        ldx #$18
lc516   lda ($60),y
        sta ($62),y
        iny
        bne lc516
lc51d   inc $61
        inc $63
        dex
        bne lc516
lc524   lda $01
        ora #$02
        sta $01
        clc
        rts

_loadFile
lc52c   txa
        asl
        tax
        lda _fnTableLoad,x
        sta _filename
        lda _fnTableLoad+1,x
        sta _filename+1
        lda lc5c3,x
        sta lc58f
        lda lc5c3+1,x
        sta lc590
        lda #$02
        ldx #$08
        ldy #$00
        jsr SETLFS              ; setlfs 2,8,0
lc550   lda #$02
        ldx #<_filename
        ldy #>_filename
        jsr SETNAM
lc559   lda #$00
        ldx lc58f
        ldy lc590
        jsr LOAD

_readDriveStatus
lc564   lda #$00
        jsr SETNAM              ; setnam ""
        lda #$0f
        tay
        ldx #$08
        jsr SETLFS              ; setlfs 15,8,15
        jsr OPEN                ; open 15,8,15,""

        ldx #$0f
        jsr CHKIN               ; chkin 15
        jsr CHRIN               ; read character from channel 15 (status)
        pha                     ; store status
        lda #$0f
        jsr CLOSE               ; close 15
        jsr CLRCHN              ; clrchn
        pla                     ; restore status
        cmp #$30                ; status == "0"?
        beq lc58c               ; yes -> OK
        sec
        rts
lc58c   clc
        rts

        lc58f = * + 1
        lc590 = * + 2
        lc591 = * + 3
        lc592 = * + 4
        lc598 = * + 10
        .byt $60,$00,$00,$00,$00
_fnScratch
        .aasc "S:"

_filename
lc595
        .aasc "GM"

_fnTableLoad
lc597
        .aasc "TC"
        .aasc "MA"
        .aasc "PL"
        .aasc "FI"
        .aasc "GE"
        .aasc "OU"
        .aasc "DN"
        .aasc "TW"
        .aasc "CA"
        .aasc "SP"
        .aasc "TM"
        .aasc "ST"
        .aasc "IN"
        .aasc "MI"
        .aasc "LO"
        .aasc "PR"

_fnTableSave
lc5b7
        .aasc "DD"              ; Disk Drive type (0: no selection)
        .aasc "RO"
        .aasc "P0"
        .aasc "P1"
        .aasc "P2"
        .aasc "P3"

lc5c3
        .word $4000             ; load address for file x
        .word $c700
        .word $6400
        .word $6420
        .word $8c9e
        .word $e000
        .word $8c9e
        .word $8c9e
        .word $8c9e
        .word $8c9e
        .word $8c9e
        .word $0c00
        .word $6800
        .word $7400
        .word $0800
        .word $12c0

lc5e3
        .word $b000             ; load/save address for file x
        .word $b000
        .word $81e2
        .word $81e2
        .word $81e2
        .word $81e2

lc5ef
        .word $b001             ; save address end
        .word $b040
        .word $83ac
        .word $83ac
        .word $83ac
        .word $83ac

        .byt $00
