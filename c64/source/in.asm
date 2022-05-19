#include "archdep.h"

l84db = $84db
VicSprite0XPos = $d000
VicSprite0YPos = $d001
VicSprite1XPos = $d002
VicSprite1YPos = $d003
VicSprite2XPos = $d004
VicSprite2YPos = $d005
VicSprite3XPos = $d006
VicSprite3YPos = $d007
VicSprite4XPos = $d008
VicSprite4YPos = $d009
VicSprite5XPos = $d00a
VicSprite5YPos = $d00b
VicSprite6XPos = $d00c
VicSprite6YPos = $d00d
VicSprite7XPos = $d00e
VicSprite7YPos = $d00f
VicSpritesXPosMsb = $d010
VicRasterValue = $d012
VicLightPenLatchX = $d013
VicLightPenLatchY = $d014
VicSpriteEnable = $d015
VicScreenCtrlReg2 = $d016
VicSpriteExpandY = $d017
VicMemCtrlReg = $d018
VicIrqStatusReg = $d019
VicIrqCtrlReg = $d01a
VicSpritePriority = $d01b
VicSpriteMulticolor = $d01c
VicSpriteExpandX = $d01d
VicSpriteToSpriteCol = $d01e
VicSpriteToBckgndCol = $d01f
VicBackgroundColor0 = $d021
VicBackgroundColor1 = $d022
VicBackgroundColor2 = $d023
VicBackgroundColor3 = $d024
VicSpriteMultiColor0 = $d025
VicSpriteMultiColor1 = $d026
VicSprite0Color = $d027
VicSprite1Color = $d028
VicSprite2Color = $d029
VicSprite3Color = $d02a
VicSprite4Color = $d02b
VicSprite5Color = $d02c
VicSprite6Color = $d02d
VicSprite7Color = $d02e
SidVoice1FreqLb = $d400
SidVoice1FreqHb = $d401
SidVoice1PulseWidthLb = $d402
SidVoice1PulseWidthHb = $d403
SidVoice1CtrlReg = $d404
SidVoice1AttackDecay = $d405
SidVoice1SustainRelease = $d406
SidVoice2FreqLb = $d407
SidVoice2FreqHb = $d408
SidVoice2PulseWidthLb = $d409
SidVoice2PulseWidthHb = $d40a
SidVoice2CtrlReg = $d40b
SidVoice2AttackDecay = $d40c
SidVoice2SustainRelease = $d40d
SidVoice3FreqLb = $d40e
SidVoice3FreqHb = $d40f
SidVoice3PulseWidthLb = $d410
SidVoice3PulseWidthHb = $d411
SidVoice3CtrlReg = $d412
SidVoice3AttackDecay = $d413
SidVoice3SustainRelease = $d414
SidFilterCutoffLb = $d415
SidFilterCutoffHb = $d416
SidFilterCtrlReg = $d417
SidFilterModeVolume = $d418
SidAdPaddle1 = $d419
SidAdPaddle2 = $d41a
SidVoice3Output = $d41b
SidVoice3AdsrOutput = $d41c
ColorRAM = $d800
Cia1PortA = $dc00
Cia1PortB = $dc01
Cia1PortADataDir = $dc02
Cia1PortBDataDir = $dc03
Cia1TimerALb = $dc04
Cia1TimerAHb = $dc05
Cia1TimerBLb = $dc06
Cia1TimerBHb = $dc07
Cia1TimeOfDayDseconds = $dc08
Cia1TimeOfDaySeconds = $dc09
Cia1TimeOfDayMinutes = $dc0a
Cia1TimeOfDayHours = $dc0b
Cia1SerialShiftReg = $dc0c
Cia1IrqCtrlReg = $dc0d
Cia1TimerACtrlReg = $dc0e
Cia1TimerBCtrlReg = $dc0f
Cia2PortA = $dd00
Cia2PortB = $dd01
Cia2PortADataDir = $dd02
Cia2PortBDataDir = $dd03
Cia2TimerALb = $dd04
Cia2TimerAHb = $dd05
Cia2TimerBLb = $dd06
Cia2TimerBHb = $dd07
Cia2TimeOfDayDseconds = $dd08
Cia2TimeOfDaySeconds = $dd09
Cia2TimeOfDayMinutes = $dd0a
Cia2TimeOfDayHours = $dd0b
Cia2SerialShiftReg = $dd0c
Cia2IrqCtrlReg = $dd0d
Cia2TimerACtrlReg = $dd0e
Cia2TimerBCtrlReg = $dd0f
CINT = $ff81
IOINIT = $ff84
RAMTAS = $ff87
RESTOR = $ff8a
VECTOR = $ff8d
SETMSG = $ff90
SECOND = $ff93
TKSA = $ff96
MEMTOP = $ff99
MEMBOT = $ff9c
SCNKEY = $ff9f
SETTMO = $ffa2
ACPTR = $ffa5
CIOUT = $ffa8
UNTLK = $ffab
UNLSN = $ffae
LISTEN = $ffb1
TALK = $ffb4
READST = $ffb7
OPEN = $ffc0
CLOSE = $ffc3
CHKIN = $ffc6
CHKOUT = $ffc9
CLRCHN = $ffcc
CHRIN = $ffcf
CHROUT = $ffd2
SAVE = $ffd8
SETTIM = $ffdb
RDTIM = $ffde
STOP = $ffe1
GETIN = $ffe4
CLALL = $ffe7
UDTIM = $ffea
SCREEN = $ffed
PLOT = $fff0
IOBASE = $fff3
        .word $6800
        * = $6800

l6800   jmp l6823
l6803   jsr _disableSprites
l6806   lda #$40
        sta $61
        lda #$00
        sta $60
        tay
        ldx #$24
l6811   sta ($60),y
        iny
        bne l6811
l6816   inc $61
        dex
        bne l6811
l681b   ldx #$0d
        jsr $c480               ; load "MI",$7400
l6820   jmp l7400


l6823   lda #<bitmap2RAM
        sta l6878
        lda #>bitmap2RAM
        sta l6879
        lda #<_introBmpRle
        sta l686c
        lda #>_introBmpRle
        sta l686d
_decodeRleL1
        jsr l686b               ; fetch byte
        cmp #$da
        beq l6883
        cmp #$00
        beq _decodeRleRun
        cmp #$10
        beq _decodeRleRun
        cmp #$ff
        beq _decodeRleRun
        cmp #$e6
        beq _decodeRleRun
        cmp #$16
        beq _decodeRleRun
        cmp #$50
        beq _decodeRleRun
        jsr l6877
        jmp _decodeRleL1

_decodeRleRun
        pha                     ; byte to be copied
        jsr l686b
        tax
        pla
_decodeRleL2
        jsr l6877
        dex
        bne _decodeRleL2
        jmp _decodeRleL1

l686b   l686c = * + 1
        l686d = * + 2
        lda _introBmpRle
        inc l686c
        bne l6876
        inc l686d
l6876
        rts

l6877   l6878 = * + 1
; Instruction parameter accessed.
        l6879 = * + 2
; Instruction parameter accessed.
        sta $4000
        inc l6878
        bne l6882
l687f   inc l6879
l6882   rts


l6883   lda #$00
        sta $1200
        lda #$20
        sta $12c0
        ldx #$00
l688f   lda $1200,x
        clc
        adc #$01
        inx
        sta $1200,x
        and #$07
        bne l68bb
l689d   dex
        lda $12c0,x
        clc
        adc #$01
        inx
        sta $12c0,x
        lda $1200,x
        and #$f0
        clc
        adc #$40
        sta $1200,x
        bcc l68c3
l68b5   inc $12c0,x
        jmp l68c3
l68bb   dex
        lda $12c0,x
        inx
        sta $12c0,x
l68c3   cpx #$bf
        bne l688f
l68c7   lda #$38
        sta $5e
        lda #$01
        sta $5f
        ldx #$27
l68d1   lda $5e
        sta $15b0,x
        sec
        sbc #$08
        sta $5e
        lda $5f
        sta $15d8,x
        sbc #$00
        sta $5f
        dex
        bpl l68d1

l68e7   inc l6a16
        jsr l6bed
        jsr l6f57
        jsr l6978
        jsr _enableSprites
        jsr _animateHorse
        jsr l6a57
l68fc   lda #$00
        jsr l6e37
l6901   jsr l6cce
l6904   jsr l6f57
l6907   lda #$01
        jsr l6e37
l690c   jsr l6c17
l690f   jsr l6cce
l6912   jsr l6f57
l6915   lda #$02
        jsr l6e37
l691a   jsr l6cce
l691d   jsr l6cce
l6920   jsr l6f57
l6923   jsr l6a96
l6926   jsr l6a37
l6929   jsr l6cce
l692c   jsr l6ae0
l692f   lda #$20
        sta $86
l6933   lda #$20
        sta l6d16
        jsr l6cd3
l693b   dec $86
        bne l6933
l693f   jsr _disableSprites
l6942   lda #$10
        sta $86
l6946   lda #$10
        sta l6d16
        jsr l6cf2
l694e   dec $86
        bpl l6946
l6952   jmp l68e7
        .asc ""
        .byt $4c
l6956   eor $69,x

_enableSprites
l6958   lda #$80                ; screen memory relative: $2000 (absolute: $6000)
        sta VicMemCtrlReg
        lda #$96                ; VIC bank: %10 ($4000-$7fff)
        sta Cia2PortA
        lda #$ff                ; enable all sprites
        sta VicSpriteEnable
        rts

_disableSprites
l6968   lda #$18
        sta VicMemCtrlReg
        lda #$97                ; VIC bank: %00 ($0000-$3fff)
        sta Cia2PortA
        lda #$00                ; disable all sprites
        sta VicSpriteEnable
        rts
l6978   lda #$00
        sta $7b
        sta $7a
        sta $79
        sta $7c
        sta $7e
        sta $82
        sta $83
        sta $84
        sta $87
        tax
l698d   sta $6400,x
        sta $6500,x
        inx
        bne l698d
l6996   ldx #$12
l6998   lda #$03
        sta $6540,x
        lda #$00
        sta $6582,x
        dex
        bpl l6998
l69a5   ldx #$07
l69a7   lda l6a2f,x
        sta $63f8,x
        dex
        bpl l69a7

        lda #$00
        sta VicSpritesXPosMsb
        lda #$1e
        sta VicSpritePriority
        ldx #$0f
_initSpritesL1
        lda _spritePositions,x
        sta VicSprite0XPos,x    ; set sprite positions
        cpx #$08
        bcs _initSpritesJ1
        lda _spriteColors,x
        sta VicSprite0Color,x   ; set sprite colors
_initSpritesJ1
        dex
        bpl _initSpritesL1

l69cf   ldx #$3f
        lda #$ff
l69d3   sta $6540,x
        sta $6580,x
        dex
        bpl l69d3
l69dc   lda l6a16
        and #$0f
        beq l69f9
l69e3   ldx #$26
l69e5   lda l765d,x
        sta $64c0,x
        lda l7684,x
        sta $6500,x
        dex
        bpl l69e5
l69f4   lda #$00
        sta $85
        rts
l69f9   ldx #$0e
l69fb   lda l7518,x
        sta $64c0,x
        sta $6500,x
        dex
        bpl l69fb
l6a07   lda #$ff
        sta $85
        lda #$b2
        sta VicSprite5YPos
        lda #$02
        sta VicSprite5Color
        rts

l6a16
        .byt $00

_spritePositions
l6a17
        .byt $44,$c4            ; sprite 0: X,Y
        .byt $00,$00            ; sprite 1: X,Y
        .byt $00,$00
        .byt $53,$a5
        .byt $60,$a5
        .byt $00,$a8
        .byt $00,$00
        .byt $00,$00

l6a27
_spriteColors
        .byt $01,$01,$0a,$00,$00,$01,$01,$01

l6a2f   bcc $69c2
        .byt $92,$95,$96,$93,$97,$97
l6a37   lda #$00
        sta $60
        sta $62
        tay
        lda #$40
        sta $61
        lda #$80
        sta $63
        ldx #$20
l6a48   lda ($60),y
        sta ($62),y
        iny
        bne l6a48
l6a4f   inc $61
        inc $63
        dex
        bne l6a48
l6a56   rts

l6a57   lda #$a8
        sta l6a7b
        lda #$6f
        sta l6a7c
        ldx #$38
l6a63   ldy #$13
        lda $1200,x
        clc
        adc $15b0,y
        sta $60
        lda $12c0,x
        adc $15d8,y
        adc #$20
        sta $61
        ldy #$00
l6a7a   l6a7b = * + 1
; Instruction parameter accessed.
        l6a7c = * + 2
        lda l6fa8
        sta ($60),y
        inc l6a7b
        bne l6a87
l6a84   inc l6a7c
l6a87   tya
        clc
        adc #$08
        tay
        cpy #$68
        bcc l6a7a
l6a90   inx
        cpx #$4d
        bcc l6a63
l6a95   rts
l6a96   ldx #$30
        ldy #$0b
        lda $1200,x
        clc
        adc $15b0,y
        sta $62
        lda $12c0,x
        adc $15d8,y
        adc #$20
        sta $63
        lda #$c0
        sta $60
        lda #$70
        sta $61
        ldx #$06
l6ab7   ldy #$00
l6ab9   lda ($60),y
        sta ($62),y
        iny
        cpy #$b8
        bcc l6ab9
l6ac2   lda $60
        clc
        adc #$b8
        sta $60
        lda $61
        adc #$00
        sta $61
        lda $62
        clc
        adc #$40
        sta $62
        lda $63
        adc #$01
        sta $63
        dex
        bne l6ab7
l6adf   rts
l6ae0   lda #$70
        sec
        sbc $7c
        tax
        lda #$b5
        sta l6b1d
        lda #$76
        sta l6b1e
        lda #$a0
        sta l6b1a
        lda #$78
        sta l6b1b
l6afa   ldy #$1e
        lda $1214,x
        clc
        adc $15b0,y
        sta $60
        sta $62
        lda $12d4,x
        adc $15d8,y
        adc #$20
        sta $61
        adc #$40
        sta $63
        ldy #$00
l6b17   lda ($62),y
        l6b1a = * + 1
; Instruction parameter accessed.
        l6b1b = * + 2
        and l78a0
        l6b1d = * + 1
; Instruction parameter accessed.
        l6b1e = * + 2
        ora l76b5
        sta ($60),y
        inc l6b1d
        bne l6b29
l6b26   inc l6b1e
l6b29   inc l6b1a
        bne l6b31
l6b2e   inc l6b1b
l6b31   tya
        clc
        adc #$08
        tay
        cpy #$18
        bcc l6b17
l6b3a   inx
        cpx #$71
        bcc l6afa
l6b3f   lda #$08
        sta l6d16
        jsr l6cd3
l6b47   inc $7c
        lda $7c
        cmp #$70
        bcs l6b52
l6b4f   jmp l6ae0
l6b52   ldx #$54
        lda #$0d
        sta l6b78
        lda #$78
        sta l6b79
l6b5e   ldy #$1e
        lda $1214,x
        clc
        adc $15b0,y
        sta $62
        lda $12d4,x
        adc $15d8,y
        adc #$60
        sta $63
        ldy #$00
l6b75   lda ($62),y
        l6b78 = * + 1
; Instruction parameter accessed.
        l6b79 = * + 2
        ora l780d
        sta ($62),y
        inc l6b78
        bne l6b84
l6b81   inc l6b79
l6b84   tya
        clc
        adc #$08
        tay
        cpy #$18
        bcc l6b75
l6b8d   inx
        cpx #$5f
        bcc l6b5e
l6b92   lda #$ff
        sta $83
l6b96   lda #$35
        sta l6bc2
        lda #$78
        sta l6bc3
        ldx $7e
l6ba2   ldy #$1e
        lda $1268,x
        clc
        adc $15b0,y
        sta $60
        sta $62
        lda $1328,x
        adc $15d8,y
        adc #$20
        sta $61
        adc #$40
        sta $63
        ldy #$00
l6bbf   lda ($62),y
        l6bc2 = * + 1
; Instruction parameter accessed.
        l6bc3 = * + 2
        ora l7835
        sta ($60),y
        inc l6bc2
        bne l6bce
l6bcb   inc l6bc3
l6bce   tya
        clc
        adc #$08
        tay
        cpy #$18
        bcc l6bbf
l6bd7   inx
        cpx #$1d
        bcc l6ba2
l6bdc   lda #$10
        sta l6d16
        jsr l6cd3
l6be4   inc $7e
        lda $7e
        cmp #$1d
        bcc l6b96
l6bec   rts
l6bed   ldx #$60
l6bef   ldy #$1e
        lda $1214,x
        clc
        adc $15b0,y
        sta $60
        lda $12d4,x
        adc $15d8,y
        adc #$20
        sta $61
        ldy #$00
l6c06   lda #$00
        sta ($60),y
        tya
        clc
        adc #$08
        tay
        cpy #$18
        bne l6c06
l6c13   dex
        bpl l6bef
l6c16   rts

_animateBird
l6c17   lda #$fe
        sta $7f
        lda #$7c
        sta $80
        lda #$00
        sta $81
        lda #$1e
        sta VicSpritePriority
l6c28   lda #$0a
        sta l6d16
        jsr l6cd3
l6c30   ldx $81
        inx
        cpx #$03
        bcc l6c39
l6c37   ldx #$00
l6c39   stx $81
        lda l6ccb,x
        tax
        ldy #$2f
l6c41   lda l7aa3,x             ; sprite data: bird head
        sta $6440,y             ; sprite pointer 1
        lda l7a0b,x             ; sprite data: bird body
        sta $6480,y             ; sprite pointer 2
        dex
        dey
        bpl l6c41
l6c51   lda $80
        sta VicSprite1YPos
        sta VicSprite2YPos
        lda $7f
        clc
        adc #$40
        sta VicSprite1XPos
l6c61; Instruction opcode accessed.
; Instruction opcode accessed.
        lda VicSpritesXPosMsb
        and #$fd
        bcc l6c6a
l6c68   ora #$02
l6c6a   sta VicSpritesXPosMsb
        lda $7f
        clc
        adc #$44
        sta VicSprite2XPos
        lda VicSpritesXPosMsb
        and #$fb
        bcc l6c7e
l6c7c   ora #$04
l6c7e   sta VicSpritesXPosMsb
        lda $81
        bne l6c91
l6c85   dec $80
        lda $7f
        cmp #$48
        bcs l6c91
l6c8d   inc $80
        inc $80
l6c91   lda $7f
        cmp #$10
        bne l6c9c
l6c97   lda #$18
        sta VicSpritePriority
l6c9c   dec $7f
        dec $7f
        bne l6c28
l6ca2   ldx #$2f
l6ca4   lda l7b6b,x
        sta $6440,x             ; sprite pointer 1
        lda l7b3b,x
        sta $6480,x             ; sprite pointer 2
        dex
        bpl l6ca4
l6cb3   lda #$40
        sta VicSprite2XPos
        lda #$47
        sta VicSprite1XPos
        lda #$6e
        sta VicSprite1YPos
        sta VicSprite2YPos
        lda #$ff
        sta $82
        rts
        .byt $60
l6ccb
        .byt $2f
        .byt $5f
        .byt $8f
l6cce   lda #$f0
        sta l6d16
l6cd3   lda VicScreenCtrlReg1
        bpl l6cd3
l6cd8   lda VicRasterValue
        bne l6cd8
l6cdd   inc $79
        jsr l6d2b
l6ce2   jsr _animateHorse
l6ce5   jsr l6d17
l6ce8   jsr l6da9
l6ceb   dec l6d16
        bne l6cd3
l6cf0   beq l6d08
l6cf2   lda VicScreenCtrlReg1
        bpl l6cf2
l6cf7   lda VicRasterValue
        bne l6cf7
l6cfc   ldx #$00
l6cfe   pha
        pla
        inx
        bne l6cfe
l6d03   dec l6d16
        bne l6cf2
l6d08   jsr SCNKEY
l6d0b   jsr GETIN
l6d0e   cmp #$00
        beq l6d15
l6d12   jmp l6803
l6d15   rts
l6d16   .asc ""
        .byt $40

l6d17   lda $82
        beq l6d2a
l6d1b   ldx #$07
        lda $79
l6d1f   lsr
        lsr
        cmp #$08
        bcc l6d27
l6d25   ldx #$06
l6d27   stx $6444
l6d2a   rts
l6d2b   lda $79
        and #$03
        beq l6d32
l6d31   rts
l6d32   inc $7d
        lda $7d
        cmp #$09
        bcc l6d3e
l6d3a   lda #$00
        sta $7d
l6d3e   tax
        inc $7b
        lda $7b
        and #$07
        sta $7b
        tay
        lda l6d67,y
        tay
        lda l6d6f,x
        sta $6000,y
        lda $79
        and #$1f
        bne l6d66
l6d58   lda $51cd
        pha
        lda $51ce
        sta $51cd
        pla
        sta $51ce
l6d66   rts
l6d67   .byt $04,$0c
l6d69   jsr $4831
        .asc ""
        .byt $64
l6d6d   pla
        l6d6f = * + 1
        ror $3010,x
        bpl l6dd3
l6d73   bmi l6de5
        .byt $00
l6d76   ldy #$10
        bmi l6d7a
l6d7a   rts

l6d7b   bmi l6ded
l6d7d   bpl l6d1f

_animateHorse
l6d7f   lda $79
        and #$3f
        bne l6da8
l6d85   inc $7a
        ldx $7a
        lda l6f90,x
        bpl l6d92
l6d8e   lda #$00
        sta $7a
l6d92   asl                     ; sprite id
        tax                     ; make index into 16 bit ptr table
        lda _spriteHorsePtrs,x
        sta $60
        lda _spriteHorsePtrs+1,x
        sta $61
        ldy #$29
l6da0   lda ($60),y             ; copy sprite data
        sta $6400,y             ; sprite pointer 0
        dey
        bpl l6da0
l6da8   rts

l6da9   lda $83
        beq l6da8
l6dad   lda l6a16
        and #$03
        bne l6da8
l6db4   lda $79
        and #$07
        bne l6da8
l6dba   lda $84
        and #$01
        clc
        adc #$93
        sta $63fd
        lda $84
        clc
        adc #$20
        sta VicSprite5XPos
        bcc l6dd6
l6dce   lda VicSpritesXPosMsb
        ora #$20
l6dd3   sta VicSpritesXPosMsb
l6dd6   inc $84
        lda $84
        cmp #$48
        bcc l6de4
l6dde   lda $85
        bpl l6de4
l6de2   dec $84
l6de4   l6de5 = * + 1
; Instruction parameter jumped to.
        lda $85
l6de6   bpl l6e0f
l6de8   lda $84
        cmp #$10
        l6ded = * + 1
; Instruction parameter jumped to.
        bcc l6e0f
l6dee   cmp #$1a
        bcc l6e03
l6df2   cmp #$30
        bcc l6e0f
l6df6   cmp #$3a
        bcs l6e0f
l6dfa   jsr l6e10
l6dfd   ora #$40
        sta ($60),y
        bne l6e0f
l6e03   lda #$19
        sec
        sbc $84
        jsr l6e10
l6e0b   and #$bf
        sta ($60),y
l6e0f   rts

l6e10   and #$0f
        asl
        tax
        lda l6e23,x
        sta $60
        lda l6e24,x
        sta $61
        ldy #$00
        lda ($60),y
        rts

l6e23   l6e24 = * + 1
        .asc "z"
        .byt $52
        .asc "{"
        .byt $52
        .asc "|"
        .byt $52
        .asc "}"
        .byt $52
        .asc "~"
        .byt $52,$ff,$52,$38,$54,$39,$54
        .asc ""
        .byt $3a,$54,$3b,$54

l6e37   asl
        tax
        lda #$0b
        sta $32
        lda #$07
        sta $33
        lda l6e6c,x
        sta l6e4e
        lda l6e6d,x
        sta l6e4f
l6e4d   l6e4e = * + 1
        l6e4f = * + 2
        lda l6e72
        bne l6e53
l6e52   rts
l6e53   bpl l6e5d
l6e55   lda #$0b
        sta $32
        inc $33
        bne l6e62
l6e5d   jsr l6f17
l6e60   inc $32
l6e62   inc l6e4e
        bne l6e4d
l6e67   l6e69 = * + 2
; Instruction parameter accessed.
        inc l6e4f
l6e6a; Instruction opcode accessed.
        bne l6e4d
l6e6c   l6e6d = * + 1
        .word $6e72
        .word $6e8a
        .word $6ee2
l6e72
        .aasc $ff
        .aasc $ff
        .aasc $ff
        .aasc "         presents...",$00
l6e8a
        .aasc "...a new release of the best-",$ff
        .aasc "   selling personal computer",$ff
        .aasc "   role-playing adventure...",$00
l6ee2
        .aasc "...Lord British's original",$ff
        .aasc "   fantasy masterpiece...",$00

l6f17   sta $5e
        lda $33
        asl
        asl
        asl
        tax
        ldy $32
        lda $1200,x
        clc
        adc $15b0,y
        sta l6f51
        lda $12c0,x
        adc $15d8,y
        adc #$20
        sta l6f52
l6f36   lda $5e
        asl
        asl
        asl
l6f3b   sta l6f4e
        lda $5e
        lsr
        lsr
        lsr
        lsr
        lsr
        clc
        adc #$08
        sta l6f4f
        ldx #$07
l6f4d   l6f4e = * + 1
        l6f4f = * + 2
        lda $0800,x
        l6f51 = * + 1
        l6f52 = * + 2
        sta $2000,x
        dex
        bpl l6f4d
l6f56   rts
l6f57   lda #$06
        asl
        asl
        asl
        tax
        ldy #$0b
        lda $1200,x
        clc
l6f63   adc $15b0,y
        sta $60
        lda $12c0,x
        adc $15d8,y
        adc #$20
        sta $61
        ldx #$07
l6f74   ldy #$e7
        lda #$00
l6f78   l6f79 = * + 1
; Instruction parameter jumped to.
        sta ($60),y
        dey
        cpy #$ff
        bne l6f78
l6f7f   lda $60
        clc
        adc #$40
        sta $60
        lda $61
        adc #$01
        sta $61
        dex
        bne l6f74
l6f8f   rts
l6f90   .byt $00,$01,$00,$01,$02,$01,$00,$01,$02,$03,$04,$03,$04,$03,$02,$01
        l6fa8 = * + 8
        .byt $00,$05,$06,$05,$06,$05,$06,$ff,$00,$3f,$ff,$ff,$ff,$ff,$ff,$ff
        .byt $ff,$ff,$ff,$ff
        .asc "@"
        .byt $00,$7f,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byt $ff
        .asc "@"
        .byt $00
        .asc "`"
        .byt $00,$00,$38,$00,$00,$00,$00,$00,$00,$00
        .asc "@"
        .byt $00
        .asc "@"
l6fd1   asl $00
        bmi l6fd5
l6fd5   .byt $00,$00,$00,$00,$00,$00
        .asc "@"
        .byt $01,$80,$1e,$00
l6fe0   bmi l705a
        .byt $1f,$03,$0f,$06
l6fe6   bmi l7019
        .byt $80,$01,$80,$0c,$00,$60
        .asc "|"
        .byt $3f,$86,$3f,$86
l6ff3   bmi l7026
        .byt $80,$03,$00,$18,$00
l6ffa   adc ($86,x)
        and ($86),y
        and ($8c),y
        bvs l7065
        .byt $00,$03,$00,$18,$00
        .asc "C"
        .byt $0c,$63,$0c,$60,$0c,$78,$63,$00
l7010   asl $10
        bmi l7034
        .asc "C"
        .byt $0c
l7016   ror $600c
l7019   clc
        cld
        dec $00
        asl $3f
        l7026 = * + 7
        .byt $ff
        .asc "q"
        .byt $86,$18
        .asc "\"
        .byt $18
        .asc "N"
        .byt $18
        .asc "LF"
        .byt $00,$0c,$7f,$ff
l702d   sbc ($86),y
        clc
        dec $18
        l7034 = * + 2
; Instruction parameter jumped to.
        dec $8d31,x
l7035   sty $0c00
        jsr $4360
        .byt $0c,$31,$86,$31,$86,$31,$87,$8c,$00,$18,$00
        .asc "@"
        .byt $03,$0c,$31,$86
        l705a = * + 15
        .asc ""
        .byt $31,$8c,$63,$07,$18,$00,$18,$00
        .asc "@"
        .byt $06,$0f
        .asc "c"
        .byt $0c,$63
        .asc "|"
        .byt $63
        .byt $03,$18,$00
l705e   bmi l7061
        .byt $80
l7061   asl $07
        .asc "C"
        .byt $0c
l7065   adc ($f0,x)
        dec $06
        bmi l706b
l706b   bmi l706e
        l706e = * + 1
        .byt $80,$0c,$00,$00,$00,$00,$00,$00,$00
l7076   bmi l7078
l7078   rts
        .byt $07,$80,$0c,$7f,$ff,$ff,$ff,$ff,$ff
l7082   inc !$0060,x
        rts
        .byt $03,$00,$18,$ff,$ff,$ff,$ff,$ff,$ff
        .asc "|"
        .byt $60,$00
        .asc "`"
        .byt $00,$00,$38
        .byt $00,$00,$00,$00,$00,$00,$00
        .asc "@"
        .byt $00,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byt $ff,$ff,$ff,$ff
        .asc "@"
        .byt $00,$7f,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byt $ff,$80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0c
        .byt $0f,$07,$00,$00,$00,$00,$00,$03,$0f
        .asc "~"
        .byt $00,$00,$00,$00,$00,$06
        .byt $07,$03,$00,$00,$00,$00,$00,$06,$9e
        .asc "|"
        .byt $00,$00,$00,$00,$00,$00
        .byt $01,$03,$00,$00,$00,$00,$00
        .asc "@@@"
        .byt $00,$00,$00,$00,$00,$00
        .byt $00,$01,$00,$00,$00,$00,$00,$00,$00,$80,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$03,$00,$00,$00,$00,$00,$00,$00
        .asc "`"
        .byt $00,$00,$00,$00,$00,$00
        .byt $01,$03,$00,$00,$00,$00,$0f,$7f,$ff,$ff,$00,$00,$00,$00
        .asc "x"
        .byt $ff
        .byt $ff,$ff,$00,$00,$00,$01,$0f,$ff,$ff,$ff,$00
l7171   bmi l71e3
l7173   cpx #$e0
        cpy #$80
        .byt $00,$07,$03,$01,$01,$01,$01,$01,$01
        .asc "~|xxxxx"
        .asc "x"
        .byt $03,$01,$00,$00,$00,$00,$00,$00
        .asc "|xppppp"
l7197   beq l71a8
        .asc ""
        .byt $3f,$0f,$0f,$0f,$0f,$0f,$0f
l71a0   cpy #$c0
        cpy #$c0
        cpy #$c0
        cmp ($c1,x)
l71a8   ora ($03,x)
        .byt $03,$07,$0f,$7f,$ff,$ff,$80,$80,$80,$80,$80
        .asc "|||"
        .byt $00,$01
        .byt $03,$03,$01,$00,$00,$00,$00,$80
        .asc "@@"
        .byt $80,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$00,$00
l71da   l71e3 = * + 9
        l71e7 = * + 13
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$06,$0d
        .byt $0d,$0d,$0d,$06,$03,$00
l7200   bmi l71da
l7202   cli
        tya
        cli
        bmi l71e7
        .byt $00,$07,$07,$0f,$1c,$18,$00,$00,$00
        .asc "~`"
        .byt $00,$00,$00,$00,$00
        .byt $00,$00,$ff,$7e
l721b   ror $7e7e,x
        ror $7c7e,x
        rts
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01
        .byt $01,$01,$01,$01,$01,$01
        .asc "xxxxxxxx"
        .byt $00,$00
l7242   .byt $00,$00,$00,$00,$00,$00
        .asc "ppppppp"
l724f   beq l7260
        l7260 = * + 15
        .byt $0f,$0f,$0f,$0f,$0f,$0f,$0f
        .asc "@@@@@@@@"
        .byt $1f
        l726f = * + 14
        .byt $1f,$1f,$1f,$1f,$1f,$1f,$1f,$80,$80,$80,$80,$80,$80,$80,$80,$00
        .byt $01,$03,$0f,$3f,$07,$07,$07
        .asc "@@@@@@@@"
        .byt $01
        .byt $03,$0f,$1f,$3f,$1f,$1f,$1f,$9f,$ff,$ff,$ff,$ff
        .asc "AA"
        .byt $80,$87
        .asc "O"
        .byt $ff,$ff,$ff
        .asc "~~|x~"
        .byt $ff,$ff,$ff,$0f,$0f,$07,$01
        .byt $01,$01,$80
        .asc "@@``G"
        .byt $ff,$ff
l72ab   beq l731d
l72ad   sec
        .byt $00,$00
        .asc "x~"
        .byt $ff,$7f,$3f,$3f,$3f,$1f,$00,$00,$00,$00,$00,$00
        .byt $00,$80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00
  .word $7e7e,$7e7e,$7e7e,$7e7e
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $01,$01,$01,$01,$01,$01,$01,$00
        .asc "xxx||~"
        .byt $ff,$ff
        .byt $00,$00,$00,$01,$01,$03,$07,$ff
        .asc "x||||||x"
        .byt $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
        .asc "@@@@@@@@"
        l731d = * + 5
        l7320 = * + 8
        .byt $1f,$1f,$1f,$1f,$1f,$1f,$1f,$1f,$80,$80,$80,$80,$80,$80,$82,$86
        .byt $07,$07,$07,$07,$07,$07,$07,$07
        .asc "@@@@@@@@"
        .byt $1f,$1f,$1f,$1f,$1f,$1f,$1f,$1f,$80,$80,$80,$80,$80,$80,$80,$80
        .asc "||||||||"
        .byt $07,$07,$07,$07,$07,$07,$07,$07
        .asc "`````aaa"
        .byt $1e,$7f,$ff
        .asc "qppp"
l7367   beq l7388
        .byt $1f,$9f,$9f,$1f,$1f,$1f,$3f,$80,$80,$80,$80,$80,$80
        .asc "@@"
        .byt $00
        l737b = * + 2
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
l7388   ror $7e7e,x
        ror $7e7e,x
        ror !$007e,x
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$ff,$7f,$1f,$03,$00,$00,$00,$00,$ff
        .byt $ff,$ff
        .asc "~"
        .byt $00,$00,$00,$00
l73b8   sed
        beq l737b
        .byt $00,$00,$00,$00,$00,$0f,$0f,$1f,$3f,$00,$00,$00,$00
        .asc "@"
l73c9   cpy #$e0
        beq l73cd
l73cd   .byt $00,$00,$00,$0f,$0f,$07,$03,$00,$00,$00,$00
l73d8   dec $f8fc
        beq l73dd
l73dd   .byt $00,$00,$00,$07,$07,$07,$1f,$00,$00,$00,$00
        .asc "@"
l73e9   cpy #$c0
        beq l73ed
l73ed   .byt $00,$00,$00,$1f,$1f,$1f,$7f,$00,$00,$00,$00,$80,$80,$80
        .asc "c"
        .byt $00
        l7400 = * + 3
        .byt $00,$00,$00
        .asc "|||"
        .byt $ff,$00,$00,$00,$00,$07,$07,$07,$0f,$0f
        .byt $0f,$1f,$1e
        .asc "@@@"
        .byt $80,$80,$00,$00,$00
        .asc "x"
        .byt $ff,$ff,$7f,$00
        .byt $00,$00,$00,$7f
        .asc "oO"
        .byt $87,$00,$00,$00,$00
        .asc "@"
l7429   cpy #$e0
        beq l742d
l742d   .byt $00,$00,$00,$00,$00,$00,$00,$00,$01,$03,$07,$00,$00,$00,$0e,$7e
        .byt $ff,$ff,$ff,$7e,$7e,$7e,$ff,$00,$ff,$ff,$ff,$00,$00,$01,$0f,$7f
        .byt $ff,$ff
        .asc "|"
l7450   bmi l74c2
l7452   cpx #$e0
        cpy #$80
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3c
l74c1   sei
l74c2   rts
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$07,$0f,$1c,$00,$00,$00,$00,$00
        .asc "`"
        .byt $00,$00
        .byt $00,$00,$00,$00,$00,$3f,$00,$00,$00,$00,$00,$00,$00
        .asc "`"
        .byt $00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .asc "FFF"
        l7518 = * + 5
        .asc "1"
        .byt $8d
        .asc " HE`@"
        .byt $00,$7c
l751c   bvs l751e
l751e   .byt $ff
        .asc "|"
        .byt $00,$ff,$ff,$00,$6f
        .asc "m"
        .byt $80

_spriteHorse0
l7527
        .byt $18,$00,$00        ; ...##...................
        .byt $7c,$00,$00        ; .#####..................
        .byt $7e,$00,$00        ; .######.................
        .byt $0e,$00,$00        ; ....###.................
        .byt $0f,$00,$00        ; ....####................
        .byt $0f,$c0,$00        ; ....######..............
        .byt $3f,$e0,$00        ; ..#########.............
        .byt $6f,$f0,$00        ; .##.########............
        .byt $6d,$f8,$00        ; .##.##.######...........
        .byt $18,$f8,$00        ; ...##...#####...........
        .byt $18,$dc,$00        ; ...##...##.###..........
        .byt $00,$6c,$00        ; .........##.##..........
        .byt $00,$6c,$00        ; .........##.##..........
        .byt $00,$d8,$00        ; ........##.##...........

_spriteHorse1
l7551
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $18,$00,$00        ; ...##...................
        .byt $7c,$00,$00        ; .#####..................
        .byt $7e,$00,$00        ; .######.................
        .byt $0f,$f8,$00        ; ....#########...........
        .byt $0f,$fc,$00        ; ....##########..........
        .byt $1f,$fc,$00        ; ...###########..........
        .byt $7f,$f8,$00        ; .############...........
        .byt $cc,$dc,$00        ; ##..##..##.###..........
        .byt $cc,$6c,$00        ; ##..##...##.##..........
        .byt $0c,$6c,$00        ; ....##...##.##..........
        .byt $18,$d8,$00        ; ...##...##.##...........

_spriteHorse2
l757b
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $30,$00,$00        ; ..##....................
        .byt $78,$00,$00        ; .####...................
        .byt $fc,$00,$00        ; ######..................
        .byt $5f,$f8,$00        ; .#.##########...........
        .byt $0f,$fc,$00        ; ....##########..........
        .byt $1f,$fc,$00        ; ...###########..........
        .byt $7f,$f8,$00        ; .############...........
        .byt $cc,$dc,$00        ; ##..##..##.###..........
        .byt $cc,$6c,$00        ; ##..##...##.##..........
        .byt $0c,$6c,$00        ; ....##...##.##..........
        .byt $18,$d8,$00        ; ...##...##.##...........

_spriteHorse3
l75a5
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $30,$00,$00        ; ..##....................
        .byt $78,$00,$00        ; .####...................
        .byt $fc,$00,$00        ; ######..................
        .byt $5f,$f8,$00        ; .#.##########...........
        .byt $0f,$fc,$00        ; ....##########..........
        .byt $1f,$fc,$00        ; ...###########..........
        .byt $3f,$f8,$00        ; ..###########...........
        .byt $6c,$dc,$00        ; .##.##..##.###..........
        .byt $cc,$6c,$00        ; ##..##...##.##..........
        .byt $cc,$6c,$00        ; ##..##...##.##..........
        .byt $18,$d8,$00        ; ...##...##.##...........

_spriteHorse4
l75cf
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $0f,$f8,$00        ; ....#########...........
        .byt $3f,$fc,$00        ; ..############..........
        .byt $7f,$fc,$00        ; .#############..........
        .byt $ef,$f8,$00        ; ###.#########...........
        .byt $ec,$dc,$00        ; ###.##..##.###..........
        .byt $ec,$6c,$00        ; ###.##...##.##..........
        .byt $cc,$6c,$00        ; ##..##...##.##..........
        .byt $18,$d8,$00        ; ...##...##.##...........

_spriteHorse5
l75f9
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $07,$fc,$00        ; .....#########..........
        .byt $1f,$fe,$00        ; ...############.........
        .byt $3f,$fe,$00        ; ..#############.........
        .byt $67,$fc,$00        ; .##..#########..........
        .byt $76,$6e,$00        ; .###.##..##.###.........
        .byt $76,$36,$00        ; .###.##...##.##.........
        .byt $36,$36,$00        ; ..##.##...##.##.........
        .byt $0c,$6c,$00        ; ....##...##.##..........

_spriteHorse6
l7623
        .byt $18,$00,$00        ; ...##...................
        .byt $3c,$00,$00        ; ..####..................
        .byt $7e,$00,$00        ; .######.................
        .byt $2e,$00,$00        ; ..#.###.................
        .byt $0f,$00,$00        ; ....####................
        .byt $0f,$c0,$00        ; ....######..............
        .byt $7f,$e0,$00        ; .##########.............
        .byt $6f,$f0,$00        ; .##.########............
        .byt $0d,$f8,$00        ; ....##.######...........
        .byt $0c,$f8,$00        ; ....##..#####...........
        .byt $18,$dc,$00        ; ...##...##.###..........
        .byt $00,$6c,$00        ; .........##.##..........
        .byt $00,$6c,$00        ; .........##.##..........
        .byt $00,$d8,$00        ; ........##.##...........

        .byt $b0,$b0

_spriteHorsePtrs
l764f
        .word _spriteHorse0
        .word _spriteHorse1
        .word _spriteHorse2
        .word _spriteHorse3
        .word _spriteHorse4
        .word _spriteHorse5
        .word _spriteHorse6

l765d
        .byt $1b,$00
        .byt $00,$0f,$00,$00,$03,$00,$00,$03,$00,$00,$1b,$00,$00,$1b,$00,$00
        .asc ""
        .byt $3e
        .asc "@"
        .byt $00,$39
        .asc "`"
        .byt $00,$3b,$40,$00
        .asc "k"
        .byt $00,$00,$7f,$80,$00
        .byt $a2
        l7684 = * + 5
        .byt $80,$00,$24,$80,$00,$01,$80,$00,$07,$80,$00,$0d,$80,$00,$01,$80
        .byt $00,$0d,$80,$00,$0d,$80,$00,$1f,$60,$00,$1c
l769a   beq l769c
l769c   ora !$00a0,x
        adc $80,x
        .byt $00
        .asc "?@"
        .byt $00,$49
l76a6   jsr $5100
l76a9   rti
        l76b5 = * + 11
        .byt $00,$00,$00,$00,$18
        .asc "X"
        .byt $00,$00,$00,$00,$00,$00,$04,$00,$00,$0c
        .byt $00,$00,$1c,$00,$00,$1c,$00,$00,$3c,$00,$00,$3c,$00,$00,$3c,$00
        .byt $00,$7c,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00
        .asc ""
        .byt $74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74
        .byt $00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00
        .byt $00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00
        .asc ""
        .byt $74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74
        .byt $00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00
        .byt $00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00
        .asc ""
        .byt $74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74
        .byt $00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00
        l7765 = * + 11
        .byt $00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00
        .asc ""
        .byt $74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74
        .byt $00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00
        .byt $00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$00,$74,$00,$07
        .byt $ff
        .asc "@"
        .byt $0f
        .asc "W`"
        .byt $19,$93
l77a1   bmi l77be
        .byt $ff
l77a4   bcs l77c5
l77a6   and $0ff0,y
        .asc ";`"
        .byt $00,$7c,$00,$00
l77af   bpl l77b1
l77b1   .byt $00
        .asc "h"
        .byt $00,$00
        .asc "X"
        .byt $00,$01
l77b8   bcs l77ba
l77ba   ora ($1c,x)
        .byt $00,$01
l77be   ldx $0100
        rol !$0000,x
        l77c5 = * + 1
        .byt $7f,$00,$00,$7f,$00,$00,$7b,$00,$00,$37,$00,$00,$0f,$00,$00,$0f
        .byt $80,$00,$0f,$80,$00,$0f,$80,$00,$0f,$80,$00,$0f,$80,$00,$0f,$80
        .byt $00,$1f,$80,$00,$1f,$80,$00,$1f,$80,$00,$1f,$80,$00,$1f,$80,$00
        .byt $1f,$80,$00,$1f,$80,$00,$1f,$80,$00,$1f,$80,$00,$1f,$80,$00,$1f
        l780d = * + 9
        .byt $80,$00,$1f,$80,$00,$00,$00,$00,$00,$00,$7c,$00,$00
l7811   bpl l7813
l7813   .byt $00,$28,$00,$00,$18,$00,$00
l781a   bmi l781c
l781c   .byt $00,$18,$00,$00,$38,$00,$00,$7c,$00,$00,$7c,$00,$00,$7c,$00,$00
        l7835 = * + 9
        .asc ""
        .byt $38,$00,$00,$0f,$00,$00,$0f,$00,$00,$00,$00,$00,$01
l7839   jsr $0300
l783c   beq l783e
l783e   .byt $03
        .asc "x"
        .byt $00,$01
        .asc "y"
        .byt $80,$03,$ff,$80,$01,$ff,$00,$00
        .asc "~"
        .byt $00,$00
        .asc ""
        .byt $7e,$00,$00,$3e,$00,$00,$1f,$00,$00,$1f,$00,$00,$0f,$00,$00,$0f
        .byt $00,$00,$0f,$00,$00,$0f,$80,$00,$0f,$80,$00,$0f,$80,$00,$0f,$80
        .byt $00,$0f,$80,$00,$1f,$80,$00,$1f,$80,$00,$1f,$80,$00,$1f,$80,$00
        .byt $1f,$80,$00,$1f,$80,$00,$1f,$80,$00,$1f,$80,$00,$1f,$80,$00,$1f
        .byt $80,$00,$1f,$80,$00,$1f,$80,$00,$1f,$80,$78,$00,$00
        .asc "|"
        .byt $00,$00
        l78a0 = * + 2
        .asc ""
        .byt $5f
        .asc "x"
        .byt $ff
        .asc "y"
        .byt $ff,$ff
        .asc "q"
        .byt $ff,$ff
        .asc "a"
        .byt $ff,$ff
        .asc "A"
        .byt $ff,$ff
        .asc "A"
        .byt $ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff
        .byt $ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff
        .byt $81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81
        .byt $ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff
        .byt $ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff
        .byt $81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81
        .byt $ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff
        .byt $ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff
        .byt $81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81
        .byt $ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff
        .byt $ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff
        .byt $81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81
        .byt $ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff
        .byt $ff,$81,$ff,$ff,$81,$ff,$ff,$81,$ff
        .asc "x"
        .byt $00,$3f
l798a   beq l798c
l798c   .byt $1f
        .asc "`"
        .byt $00,$0f
        .asc "`"
        .byt $00,$0f
        .asc "`"
        .byt $00,$0f
l7996   beq l7998
l7998   .byt $1f,$ff,$83,$ff,$ff
        .asc "o"
        .byt $ff,$ff,$07,$ff,$ff,$07,$ff
        .asc "~"
        .byt $0f,$ff
        .asc "~"
        .byt $03,$ff
        .asc "~"
        .byt $01,$ff
        .asc "~"
        .byt $01,$ff,$ff,$80,$ff,$ff
        .asc "`"
        .byt $ff,$ff
l79b8   l79b9 = * + 1
        beq l79b9
        .byt $ff
l79bb   l79bc = * + 1
        beq l79bc
        .byt $ff
l79be   l79bf = * + 1
        beq l79bf
        .byt $ff
l79c1   beq l7a42
        .byt $ff
l79c4   beq l7a45
        .byt $ff
l79c7   beq l7a48
        .byt $ff
l79ca   beq l7a4b
        .byt $ff
l79cd   beq l7a4e
        .byt $ff
l79d0   beq l7a51
        .byt $ff
        .asc "`"
        .byt $7f,$ff
        .asc "`"
        .byt $7f,$ff
        .asc "`"
        .byt $7f,$ff
        .asc "`"
        .byt $7f,$ff
        .asc "`"
        .byt $7f,$ff
        .asc "`"
        .byt $7f,$ff
        .asc "`"
        .byt $7f,$ff
        .asc "`"
        .byt $7f,$ff
        .asc "`"
        .byt $7f,$ff
        .asc "`"
        .byt $7f,$ff
        .asc "`"
        .byt $7f,$ff
        .asc "`"
        .byt $7f,$ff
        .asc "`"
        .byt $7f,$ff
l79fa   beq l7a3b
        .byt $ff
l79fd   beq l7a3e
        .byt $ff
l7a00   beq l7a41
        .byt $ff
l7a03   beq l7a44
        .byt $ff
l7a06   beq l7a47
        .byt $ff,$ff,$ff
l7a0b   jsr $f801
        .asc "x"
        .byt $0f
        .asc "x"
        .byt $ff,$3f
l7a13   beq l7a53
        .byt $ff
        .asc "`"
        .byt $0d,$ff
        .asc "X"
        .byt $0f,$ff
        .asc ">"
        .byt $0f
        .asc "~"
        .byt $7f,$0f,$ff
        .asc "x"
        .byt $07,$ff
        .asc "@"
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        l7a3b = * + 6
        l7a3e = * + 9
        l7a41 = * + 12
        l7a42 = * + 13
        l7a44 = * + 15
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
l7a45   l7a47 = * + 2
        .byt $00,$00,$00
l7a48   sed
        l7a4b = * + 2
        l7a4e = * + 5
        l7a51 = * + 8
        .byt $00,$07,$ff
        .asc "`"
        .byt $07
        .asc "|"
        .byt $7c,$07,$ff
        .asc "?"
l7a53   asl $ff
        .asc "\"
        .byt $07,$7f
        .asc "`"
l7a59   ora ($7f,x)
        beq l7a69
        l7a69 = * + 12
        .byt $7f
        .asc "@"
        .byt $07,$7f
        .asc "@"
        .byt $00,$7f,$00,$00,$1c,$00,$00
        .asc "|"
        .byt $00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$7c,$00,$07,$ff,$80,$0f,$ff
l7a7c   beq l7a8d
        l7a8d = * + 15
        .byt $ff,$ff,$0f,$ff
        .asc "|"
        .byt $0f,$ff
        .asc "h"
        .byt $07
        .asc "x"
        .byt $00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00

_spriteBirdHead0
l7aa3
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $06,$00,$00        ; .....##.................
        .byt $3e,$00,$00        ; ..#####.................
        .byt $fe,$00,$00        ; #######.................
        .byt $06,$00,$00        ; .....##.................
        .byt $00,$13,$00        ; ...........#..##........
        .byt $00,$1a,$00        ; ...........##.#.........
        .byt $00,$11,$00        ; ...........#...#........
        .byt $00,$08,$00        ; ............#...........
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................

l7ad3
_spriteBirdHead1
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $06,$00,$00        ; .....##.................
        .byt $3e,$00,$00        ; ..#####.................
        .asc $fe,$00,$00        ; #######.................
        .byt $06,$00,$00        ; .....##.................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
l7b03
_spriteBirdHead2
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................
        .byt $06,$00,$00        ; .....##.................
        .byt $3e,$00,$00        ; ..#####.................
        .asc $fe,$00,$00        ; #######.................
        .byt $06,$00,$00        ; .....##.................
        .byt $00,$00,$00        ; ........................
        .byt $00,$09,$80        ; ............#..##.......
        .byt $00,$0d,$00        ; ............##.#........
        .byt $00,$08,$80        ; ............#...#.......
        .byt $00,$04,$00        ; .............#..........
        .byt $00,$00,$00        ; ........................
        .byt $00,$00,$00        ; ........................

        .byt $00,$00,$00
        .byt $00,$00,$00
        .byt $00,$00
l7b3b
        .byt $00,$01
l7b3d   beq l7b3f
l7b3f   .asc ""
        .byt $3f
l7b40   beq l7b42
l7b42   .byt $ff
l7b43   beq l7b46
        .byt $ff
l7b46   beq l7b4f
        .byt $ff
l7b49   beq l7b5a
        l7b4f = * + 4
        l7b5a = * + 15
        .byt $ff
        .asc "@"
        .byt $1f
        .asc "~"
        .byt $00,$7f
        .asc "~"
        .byt $00,$00,$7c,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
l7b6b   .byt $00,$07,$80,$00,$07
        .asc "`"
        .byt $00,$07
l7b73   beq l7b75
l7b75   .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$28,$00
        l7b87 = * + 2
        .byt $00,$24,$00,$00,$28,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00

_introBmpRle
l7b9b                           ; title screen data (packed)

	.byt                                             $00,$0c,$03,$07,$0f
	.byt $0f,$00,$03,$fc,$fe,$f0,$e0,$c0,$00,$08,$02,$07,$02,$00,$40,$02
	.byt $07,$02,$00,$e2,$1f,$1f,$1f,$1e,$1e,$0e,$0e,$06,$80,$00,$37,$40
	.byt $e0,$40,$00,$b5,$08,$1c,$08,$00,$45,$03,$00,$9c,$08,$1c,$08,$00
	.byt $18,$02,$07,$02,$00,$ad,$08,$1c,$08,$00,$00,$00,$12,$c4,$b5,$e7
	.byt $00,$06,$70,$ed,$00,$00,$00,$30,$f7,$9c,$9f,$cf,$ff,$05,$7f,$ed
	.byt $fc,$7f,$ff,$03,$d0,$ff,$02,$bf,$ff,$02,$fc,$fd,$00,$01,$60,$f4
	.byt $ff,$03,$1f,$fc,$00,$02,$40,$00,$01,$d0,$ec,$7d,$d7,$00,$07,$40
	.byt $00,$00,$00,$10,$ff,$01,$fc,$ff,$01,$bf,$9c,$ff,$01,$f1,$cf,$ff
	.byt $01,$77,$e7,$cf,$1f,$ff,$01,$fe,$f0,$fe,$ff,$01,$1f,$ff,$02,$fd
	.byt $f9,$f5,$1d,$f7,$1f,$f7,$fd,$f4,$db,$a8,$b8,$5a,$a5,$7e,$75,$d8
	.byt $10,$01,$00,$01,$d0,$e0,$40,$40,$00,$00,$00,$14,$b1,$ce,$bf,$ef
	.byt $f9,$e6,$01,$b1,$ce,$ff,$01,$7e,$fd,$d6,$bd,$6e,$99,$44,$77,$e4
	.byt $3b,$c4,$90,$00,$03,$50,$01,$40,$00,$14,$0e,$fc,$00,$06,$70,$f8
	.byt $00,$00,$00,$08,$ff,$03,$fc,$fc,$fc,$fc,$fe,$90,$40,$00,$0c,$03
	.byt $7f,$01,$07,$1f,$7f,$7f,$27,$7f,$4f,$df,$ff,$01,$fe,$f0,$c7,$cf
	.byt $fc,$f4,$f1,$c3,$1f,$7d,$d0,$c0,$00,$02,$df,$c3,$fd,$50,$01,$00
	.byt $05,$80,$50,$01,$00,$00,$00,$05,$ff,$08,$1f,$ff,$02,$fc,$f0,$c0
	.byt $80,$00,$01,$ff,$01,$fc,$f0,$00,$05,$31,$40,$00,$03,$1f,$7f,$bf
	.byt $00,$06,$fc,$f1,$00,$00,$00,$18,$ff,$01,$fe,$fc,$fc,$fc,$fc,$fc
	.byt $fc,$00,$01,$01,$02,$06,$03,$06,$01,$00,$01,$7f,$ff,$03,$1f,$e4
	.byt $39,$16,$01,$d7,$c0,$8d,$3f,$3f,$66,$b9,$44,$c7,$1f,$7f,$ff,$01
	.byt $bd,$ea,$11,$40,$a0,$54,$f2,$ee,$11,$44,$00,$04,$90,$44,$00,$00
	.byt $00,$0c,$fc,$fc,$fe,$fe,$fe,$fe,$ff,$02,$00,$02,$03,$0f,$1f,$7f
	.byt $ff,$01,$fc,$1f,$7c,$f0,$c0,$80,$00,$00,$00,$2b,$ff,$08,$f8,$f0
	.byt $f0,$e0,$e0,$c0,$c0,$c0,$00,$00,$00,$30,$ff,$08,$80,$80,$00,$38
	.byt $0c,$1e,$3f,$7f,$33,$33,$00,$05,$80,$00,$04,$0c,$1e,$3f,$7f,$33
	.byt $33,$00,$05,$80,$00,$e2,$ff,$08,$00,$03,$01,$00,$02,$01,$00,$05
	.byt $10,$01,$01,$04,$40,$00,$06,$44,$01,$00,$04,$04,$40,$00,$01,$04
	.byt $00,$03,$10,$01,$41,$04,$40,$00,$06,$11,$40,$04,$00,$04,$18,$3d
	.byt $7e,$ff,$01,$3f,$3f,$1e,$5e,$de,$de,$de,$5e,$6d,$6d,$ff,$01,$c7
	.byt $d3,$d6,$dd,$d1,$bf,$bf,$de,$de,$de,$de,$de,$de,$00,$03,$80,$c6
	.byt $ef,$df,$bf,$00,$05,$11,$80,$c4,$00,$03,$01,$44,$10,$01,$01,$40
	.byt $00,$02,$10,$01,$01,$40,$00,$01,$04,$00,$03,$04,$11,$00,$01,$40
	.byt $04,$40,$00,$02,$40,$00,$01,$10,$01,$01,$04,$40,$00,$06,$40,$04
	.byt $00,$07,$44,$00,$a8,$ff,$08,$00,$01,$10,$01,$01,$00,$01,$01,$00
	.byt $02,$04,$00,$02,$11,$04,$00,$02,$01,$00,$02,$11,$04,$00,$02,$10
	.byt $01,$00,$01,$40,$01,$00,$02,$41,$04,$10,$01,$00,$02,$04,$00,$01
	.byt $01,$10,$01,$40,$00,$04,$01,$10,$01,$44,$00,$02,$10,$01,$04,$66
	.byt $66,$7e,$7e,$7d,$7d,$7d,$7d,$d8,$03,$db,$db,$fd,$fd,$dd,$8d,$10
	.byt $01,$6d,$6d,$ff,$04,$f3,$06,$b0,$b6,$f6,$ef,$ef,$ee,$ec,$d9,$19
	.byt $df,$df,$ef,$ef,$ef,$6f,$80,$81,$80,$90,$81,$80,$84,$80,$00,$01
	.byt $11,$00,$01,$40,$00,$01,$01,$10,$01,$04,$10,$02,$40,$04,$00,$01
	.byt $01,$00,$02,$10,$01,$00,$02,$11,$44,$00,$05,$11,$04,$00,$02,$01
	.byt $00,$02,$11,$04,$00,$02,$10,$01,$00,$01,$40,$11,$00,$02,$41,$04
	.byt $10,$01,$00,$03,$40,$05,$10,$01,$40,$01,$00,$01,$40,$00,$02,$10
	.byt $01,$41,$04,$00,$01,$04,$01,$00,$04,$11,$00,$01,$44,$00,$06,$11
	.byt $44,$00,$06,$11,$40,$01,$00,$06,$10,$01,$41,$00,$07,$3f,$00,$06
	.byt $7f,$ff,$01,$00,$06,$ff,$02,$00,$06,$f8,$ff,$01,$00,$07,$ff,$01
	.byt $00,$27,$7f,$00,$06,$0f,$ff,$01,$00,$06,$ff,$02,$00,$05,$07,$ff
	.byt $02,$00,$05,$ff,$03,$00,$05,$ff,$0b,$00,$01,$01,$00,$03,$04,$00
	.byt $02,$40,$00,$01,$10,$01,$01,$04,$00,$02,$40,$00,$02,$44,$10,$01
	.byt $00,$03,$11,$00,$01,$44,$10,$01,$00,$02,$04,$01,$00,$01,$44,$10
	.byt $01,$01,$00,$01,$41,$00,$05,$10,$01,$00,$01,$02,$00,$02,$04,$7d
	.byt $7d,$7d,$7d,$00,$04,$dd,$fd,$fd,$fd,$00,$04,$e1,$e1,$e1,$e1,$3e
	.byt $3e,$3e,$3e,$ee,$ef,$ef,$ef,$00,$04,$ef,$ef,$ef,$ef,$00,$04,$81
	.byt $84,$80,$a0,$08,$20,$00,$03,$40,$04,$01,$00,$02,$44,$11,$00,$01
	.byt $04,$41,$00,$04,$10,$01,$04,$41,$00,$02,$04,$40,$10,$01,$00,$01
	.byt $40,$00,$01,$10,$01,$01,$04,$00,$05,$44,$10,$01,$00,$01,$04,$01
	.byt $00,$02,$44,$10,$01,$01,$00,$01,$40,$00,$01,$01,$04,$01,$00,$01
	.byt $10,$01,$40,$12,$00,$05,$01,$0f,$3f,$7f,$ff,$01,$00,$01,$0f,$3f
	.byt $ff,$05,$00,$0f,$3f,$00,$07,$f8,$00,$07,$03,$00,$05,$03,$7f,$fe
	.byt $00,$04,$7f,$fb,$e0,$00,$05,$c0,$f0,$ff,$01,$0f,$00,$06,$c0,$ff
	.byt $01,$00,$2f,$01,$00,$06,$03,$f0,$00,$05,$3f,$fc,$00,$06,$fe,$00
	.byt $0a,$ff,$08,$00,$01,$11,$00,$03,$11,$00,$02,$11,$04,$00,$02,$01
	.byt $00,$01,$40,$00,$01,$04,$00,$03,$10,$01,$40,$00,$03,$41,$04,$10
	.byt $01,$00,$03,$44,$01,$10,$01,$40,$00,$03,$44,$10,$02,$40,$00,$01
	.byt $01,$10,$01,$04,$00,$02,$40,$04,$00,$01,$01,$00,$03,$04,$00,$01
	.byt $11,$44,$00,$03,$04,$41,$00,$04,$01,$00,$01,$40,$00,$01,$04,$00
	.byt $02,$10,$01,$00,$01,$40,$00,$03,$40,$04,$10,$01,$00,$03,$44,$00
	.byt $01,$11,$04,$00,$03,$44,$10,$01,$00,$03,$01,$10,$01,$04,$00,$02
	.byt $40,$04,$00,$01,$01,$00,$03,$04,$00,$01,$11,$44,$00,$02,$01,$00
	.byt $01,$40,$11,$04,$00,$02,$10,$01,$04,$20,$00,$05,$03,$0f,$3f,$ff
	.byt $01,$00,$02,$03,$3f,$ff,$04,$03,$ff,$07,$00,$0c,$1f,$00,$04,$03
	.byt $78,$00,$01,$80,$00,$04,$e0,$00,$06,$07,$00,$07,$fe,$00,$1f,$07
	.byt $00,$07,$ff,$01,$07,$00,$06,$80,$fc,$00,$17,$0f,$00,$06,$1f,$e0
	.byt $00,$06,$c0,$00,$1f,$ff,$08,$00,$01,$04,$00,$03,$10,$01,$00,$01
	.byt $01,$10,$01,$01,$04,$00,$01,$40,$00,$01,$11,$04,$44,$10,$01,$00
	.byt $03,$11,$04,$00,$01,$10,$01,$00,$02,$04,$01,$00,$02,$41,$01,$00
	.byt $01,$40,$00,$03,$01,$10,$01,$04,$11,$40,$00,$02,$01,$10,$01,$40
	.byt $41,$00,$04,$10,$01,$40,$04,$00,$02,$04,$40,$10,$01,$00,$02,$11
	.byt $10,$01,$01,$04,$00,$03,$11,$04,$44,$10,$01,$00,$03,$11,$04,$00
	.byt $01,$10,$01,$00,$02,$04,$01,$00,$02,$41,$01,$00,$01,$40,$00,$03
	.byt $01,$10,$01,$04,$11,$40,$00,$01,$01,$00,$01,$10,$01,$40,$40,$00
	.byt $01,$01,$00,$01,$10,$01,$40,$04,$00,$02,$01,$0f,$1f,$3f,$ff,$03
	.byt $00,$04,$03,$07,$0f,$0e,$00,$01,$03,$3e,$f8,$e0,$80,$80,$00,$02
	.byt $80,$00,$ae,$ff,$08,$00,$03,$04,$00,$01,$10,$01,$00,$03,$40,$01
	.byt $00,$01,$40,$00,$01,$10,$01,$01,$00,$01,$10,$01,$00,$01,$40,$00
	.byt $02,$44,$10,$01,$04,$10,$01,$00,$03,$44,$10,$01,$00,$01,$40,$00
	.byt $03,$44,$10,$01,$01,$00,$02,$01,$10,$01,$04,$00,$02,$04,$11,$00
	.byt $01,$01,$00,$03,$04,$41,$00,$01,$44,$00,$03,$04,$41,$00,$04,$01
	.byt $00,$01,$40,$00,$01,$10,$01,$01,$00,$01,$10,$01,$00,$01,$40,$00
	.byt $02,$44,$10,$01,$04,$10,$01,$00,$03,$44,$10,$01,$00,$01,$40,$00
	.byt $02,$11,$04,$00,$02,$44,$00,$04,$10,$01,$00,$02,$02,$07,$1f,$3f
	.byt $7f,$7f,$7f,$7f,$7f,$00,$03,$01,$03,$03,$03,$00,$01,$7e,$f8,$f8
	.byt $f0,$e0,$e0,$e0,$f8,$00,$b8,$ff,$08,$00,$01,$80,$80,$80,$c0,$c0
	.byt $c0,$c0,$04,$00,$03,$41,$04,$00,$05,$11,$04,$00,$02,$10,$01,$00
	.byt $01,$04,$01,$00,$02,$41,$04,$10,$01,$40,$00,$03,$01,$10,$01,$40
	.byt $00,$01,$40,$00,$02,$01,$10,$01,$40,$00,$01,$01,$00,$03,$10,$01
	.byt $40,$04,$00,$01,$01,$04,$40,$10,$01,$00,$02,$11,$44,$00,$01,$04
	.byt $00,$03,$11,$04,$00,$05,$11,$04,$00,$02,$10,$01,$00,$02,$04,$01
	.byt $00,$01,$40,$04,$11,$10,$01,$00,$01,$40,$00,$01,$04,$01,$00,$01
	.byt $10,$02,$00,$01,$10,$01,$00,$01,$40,$00,$02,$40,$3f,$1f,$07,$07
	.byt $0f,$0f,$3f,$ff,$01,$00,$07,$80,$fe,$3f,$0f,$03,$00,$02,$03,$0f
	.byt $00,$01,$80,$e0,$f8,$f8,$f0,$e0,$80,$00,$b0,$ff,$08,$c0,$c0,$c0
	.byt $e0,$e0,$e0,$e0,$e0,$41,$04,$00,$02,$10,$01,$00,$01,$04,$00,$02
	.byt $40,$00,$02,$44,$10,$01,$01,$40,$00,$03,$44,$10,$01,$00,$02,$04
	.byt $00,$02,$44,$10,$01,$01,$00,$01,$40,$00,$01,$10,$01,$04,$00,$02
	.byt $04,$11,$40,$00,$04,$04,$41,$00,$05,$04,$41,$00,$02,$04,$40,$01
	.byt $00,$01,$40,$00,$01,$10,$01,$01,$04,$00,$02,$40,$00,$02,$44,$10
	.byt $01,$00,$05,$44,$10,$01,$01,$00,$02,$40,$00,$03,$01,$10,$01,$40
	.byt $00,$01,$01,$01,$07,$0f,$1f,$1f,$3f,$3f,$00,$01,$01,$03,$02,$1e
	.byt $38,$60,$78,$c0,$c0,$80,$00,$05,$3e,$3e,$3e,$1c,$0c,$06,$00,$ba
	.byt $ff,$08,$e0,$e0,$e0,$e0,$e0,$f0,$f8,$f8,$00,$01,$04,$01,$00,$01
	.byt $40,$01,$00,$02,$10,$01,$00,$01,$01,$00,$01,$10,$01,$00,$01,$44
	.byt $00,$01,$41,$00,$01,$10,$01,$41,$00,$02,$44,$10,$01,$00,$02,$01
	.byt $10,$01,$40,$10,$01,$00,$01,$11,$00,$01,$01,$10,$01,$40,$00,$01
	.byt $01,$10,$01,$04,$00,$01,$10,$01,$40,$04,$00,$01,$01,$00,$02,$10
	.byt $01,$00,$02,$11,$44,$00,$02,$01,$00,$02,$11,$04,$00,$02,$01,$10
	.byt $01,$00,$01,$11,$04,$00,$02,$10,$01,$00,$01,$40,$00,$03,$40,$04
	.byt $10,$01,$01,$00,$01,$01,$44,$10,$01,$01,$00,$02,$10,$01,$40,$3f
	.byt $3f,$1f,$0f,$07,$07,$07,$00,$01,$3e,$03,$00,$07,$80,$80,$f0,$00
	.byt $01,$07,$00,$07,$80,$0f,$00,$07,$80,$fb,$00,$07,$80,$00,$07,$0f
	.byt $00,$07,$e0,$00,$07,$fe,$00,$90,$ff,$06,$fe,$e0,$fe,$ff,$04,$bf
	.byt $0f,$01,$18,$e0,$c0,$00,$02,$c0,$f0,$fc,$01,$10,$01,$00,$01,$10
	.byt $01,$01,$40,$00,$01,$10,$01,$01,$00,$01,$10,$01,$41,$04,$00,$01
	.byt $01,$40,$00,$03,$01,$00,$01,$10,$01,$01,$00,$03,$04,$11,$40,$00
	.byt $04,$04,$41,$00,$02,$04,$00,$01,$40,$00,$01,$40,$00,$02,$44,$10
	.byt $01,$00,$02,$40,$00,$02,$11,$04,$00,$02,$04,$00,$02,$44,$10,$01
	.byt $00,$02,$01,$04,$00,$01,$44,$10,$01,$00,$02,$41,$00,$01,$40,$00
	.byt $02,$04,$01,$00,$01,$10,$01,$40,$00,$01,$01,$00,$01,$40,$00,$01
	.byt $01,$00,$03,$10,$01,$01,$10,$01,$00,$01,$10,$01,$40,$00,$02,$ff
	.byt $01,$3f,$03,$00,$05,$ff,$04,$7f,$1f,$01,$00,$01,$ff,$07,$07,$ff
	.byt $08,$00,$04,$3e,$00,$09,$ff,$01,$03,$0f,$00,$05,$f8,$ff,$01,$ee
	.byt $00,$06,$ff,$01,$20,$00,$06,$fe,$00,$14,$7f,$00,$07,$e0,$7f,$00
	.byt $07,$ff,$01,$00,$07,$80,$00,$00,$00,$00,$00,$52,$10,$a0,$50,$02
	.byt $10,$26,$50,$06,$10,$22,$50,$07,$10,$21,$50,$08,$10,$20,$90,$50
	.byt $01,$90,$50,$05,$10,$20,$90,$90,$90,$50,$02,$10,$23,$90,$50,$06
	.byt $10,$21,$90,$90,$90,$50,$01,$10,$08,$50,$01,$10,$1b,$90,$90,$a0
	.byt $10,$09,$50,$01,$10,$1a,$60,$90,$90,$10,$0a,$50,$01,$10,$03,$50
	.byt $01,$10,$16,$60,$90,$50,$06,$10,$05,$50,$08,$10,$13,$60,$90,$50
	.byt $06,$10,$05,$50,$0d,$60,$60,$60,$60,$60,$10,$03,$50,$01,$60,$60
	.byt $60,$60,$60,$60,$90,$50,$06,$10,$05,$50,$08,$60,$60,$16,$01,$e6
	.byt $07,$16,$04,$e6,$05,$16,$01,$90,$50,$10,$60,$60,$60,$16,$01,$e6
	.byt $11,$16,$02,$90,$50,$0e,$60,$e6,$06,$16,$12,$90,$50,$0d,$60,$e6
	.byt $03,$16,$16,$90,$90,$50,$0c,$60,$e6,$0a,$16,$0f,$90,$90,$50,$0b
	.byt $60,$e6,$04,$16,$03,$e6,$02,$16,$11,$90,$90,$50,$0b,$60,$e6,$10
	.byt $16,$0a,$90,$90,$90,$50,$0c,$60,$60,$60,$60,$e6,$0b,$16,$0a,$90
	.byt $10,$02,$a0,$10,$0d,$60,$10,$2e,$da

l84d9:
        .byt $b0
