#define _ST_
#include "archdep.h"
#include "constants.h"

        .word $0c00
        * = $0c00

tileset
l0c00
        .byt $00,$f0,$0f,$00,$00,$f0,$0f,$00,$0f,$00,$00,$f0,$0f,$00,$00,$f0    ; water
        .byt $00,$f0,$0f,$00,$00,$f0,$0f,$00,$0f,$00,$00,$f0,$0f,$00,$00,$f0

        .byt $0c,$00,$c0,$00,$30,$00,$00,$00,$00,$30,$00,$00,$00,$0c,$00,$00    ; grass
        .byt $0c,$00,$00,$00,$00,$00,$30,$00,$00,$0c,$00,$c0,$00,$03,$00,$00

        .byt $1c,$7f,$7f,$1c,$00,$00,$00,$00,$00,$00,$00,$1c,$7f,$7f,$1c,$00    ; forest
        .byt $1c,$7f,$7f,$1c,$00,$00,$00,$00,$00,$00,$00,$00,$1c,$7f,$7f,$1c

        .byt $18,$fc,$e7,$c3,$86,$0c,$99,$f3,$18,$fc,$e7,$03,$01,$c0,$e1,$33    ; mountains
        .byt $66,$3c,$98,$f0,$61,$33,$1e,$0c,$1e,$0c,$07,$03,$86,$cc,$78,$30

        .byt $00,$00,$00,$00,$6d,$6d,$7f,$3f,$80,$e0,$b0,$80,$b6,$b6,$fe,$fc    ; castle
        .byt $3f,$3e,$3e,$3e,$29,$29,$09,$00,$7c,$3c,$3c,$3c,$ca,$ca,$c8,$00

        .byt $00,$01,$01,$0f,$0f,$0f,$0f,$0f,$00,$80,$80,$f0,$f0,$f0,$f0,$f0    ; sign
        .byt $01,$01,$01,$01,$01,$1f,$7f,$00,$80,$80,$80,$80,$80,$f8,$fe,$00

        .byt $04,$00,$48,$0e,$0b,$08,$38,$39,$00,$40,$00,$00,$00,$00,$00,$ce    ; town
        .byt $7f,$7e,$7e,$7e,$00,$00,$10,$00,$7e,$3e,$3e,$3e,$00,$04,$00,$00

        .byt $18,$fc,$e7,$c3,$86,$0c,$99,$f0,$18,$fc,$e7,$03,$01,$c0,$e1,$03    ; dungeon
        .byt $67,$2f,$9c,$d8,$58,$18,$98,$d8,$e6,$f0,$39,$1b,$1a,$18,$19,$1b

        .byt $00,$03,$03,$03,$00,$1f,$1f,$1f,$00,$80,$80,$84,$04,$64,$74,$4e    ; player
        .byt $1f,$0e,$05,$02,$0c,$0c,$1c,$00,$44,$80,$80,$c0,$60,$60,$70,$00

        .byt $00,$00,$00,$00,$18,$3c,$7e,$2f,$00,$00,$00,$00,$00,$00,$00,$fc    ; horse
        .byt $07,$0f,$0f,$14,$24,$24,$08,$00,$fe,$fe,$fc,$36,$12,$12,$24,$00

        .byt $00,$00,$00,$00,$00,$00,$60,$38,$00,$00,$00,$00,$00,$00,$00,$00    ; cart
        .byt $0f,$0f,$0f,$07,$01,$01,$00,$00,$fe,$fe,$8e,$06,$24,$04,$88,$70

        .byt $00,$00,$02,$03,$03,$02,$02,$02,$00,$00,$00,$00,$80,$c0,$c0,$c0    ; raft
        .byt $03,$03,$02,$3f,$1f,$00,$00,$00,$80,$00,$00,$f0,$f8,$00,$00,$00

        .byt $00,$02,$03,$02,$02,$23,$33,$3b,$00,$00,$80,$c0,$00,$20,$b0,$b8    ; frigate
        .byt $3b,$33,$22,$7f,$76,$7f,$3f,$00,$b8,$30,$20,$fe,$d8,$f0,$e0,$00

        .byt $00,$00,$00,$00,$00,$00,$7e,$0c,$00,$00,$00,$00,$00,$00,$00,$00    ; hovercar
        .byt $1f,$3f,$3f,$00,$00,$00,$00,$00,$30,$fc,$fc,$00,$00,$00,$00,$00

        .byt $00,$01,$02,$02,$03,$03,$03,$03,$80,$c0,$20,$a0,$e0,$e0,$e0,$e0    ; shuttle
        .byt $03,$07,$07,$0f,$1f,$3f,$3f,$03,$e0,$f0,$f0,$f8,$fc,$fe,$fe,$e0

        .byt $00,$00,$03,$06,$0a,$12,$12,$22,$80,$80,$e0,$30,$28,$24,$24,$22    ; time capsule
        .byt $23,$3a,$1b,$1b,$0b,$06,$03,$00,$e2,$2e,$ec,$ec,$e8,$30,$e0,$00

        .byt $00,$00,$00,$03,$0f,$01,$07,$00,$00,$00,$00,$80,$e0,$f0,$98,$0c    ; sea serpent 1
        .byt $00,$00,$1f,$3f,$79,$70,$00,$00,$0c,$06,$86,$c6,$ee,$ec,$00,$00

        .byt $00,$00,$00,$01,$03,$00,$00,$00,$00,$00,$e0,$f0,$38,$78,$cc,$0c    ; sea serpent 2
        .byt $00,$00,$1f,$3f,$79,$70,$00,$00,$0c,$0c,$8c,$ce,$e6,$e6,$00,$00

        .byt $00,$01,$03,$05,$07,$03,$0d,$11,$00,$80,$c0,$a0,$e0,$c0,$b0,$88    ; squid 1
        .byt $22,$44,$44,$22,$22,$44,$48,$00,$44,$44,$22,$22,$44,$44,$22,$00

        .byt $00,$01,$03,$05,$07,$03,$0d,$11,$00,$80,$c0,$a0,$e0,$c0,$b0,$88    ; squid 2
        .byt $12,$24,$44,$44,$22,$22,$14,$00,$48,$44,$84,$82,$42,$24,$28,$00

        .byt $00,$00,$03,$06,$00,$01,$00,$00,$00,$f0,$f8,$78,$7c,$dc,$1c,$1c    ; dragon 1
        .byt $00,$00,$00,$0f,$3f,$7f,$7f,$00,$1e,$1e,$1e,$9e,$fe,$fe,$fe,$00

        .byt $00,$01,$07,$0c,$00,$15,$43,$10,$00,$e0,$f0,$f0,$f8,$b8,$3c,$1c    ; dragon 2
        .byt $00,$00,$00,$0f,$3f,$7f,$7f,$00,$1c,$1c,$1e,$9e,$fe,$fe,$fe,$00

        .byt $00,$03,$02,$02,$12,$1f,$79,$49,$00,$00,$80,$00,$40,$c0,$f0,$10    ; pirates 1
        .byt $49,$7f,$12,$7f,$76,$7f,$3f,$00,$10,$f0,$40,$fe,$d8,$f0,$e0,$00

        .byt $00,$02,$03,$02,$12,$1f,$79,$49,$00,$80,$00,$00,$40,$c0,$f0,$10    ; pirates 2
        .byt $49,$7f,$12,$7f,$76,$7f,$3f,$00,$10,$f0,$40,$fe,$d8,$f0,$e0,$00

        .byt $00,$01,$79,$11,$10,$1f,$03,$01,$00,$c0,$c0,$c0,$80,$f0,$e8,$c4    ; thief 1
        .byt $00,$01,$01,$03,$02,$02,$06,$00,$84,$c4,$c0,$60,$20,$20,$30,$00

        .byt $00,$01,$01,$01,$00,$07,$0b,$11,$00,$c0,$c0,$c0,$80,$f0,$e8,$c4    ; thief2
        .byt $60,$21,$11,$03,$02,$02,$06,$00,$88,$d0,$c0,$60,$20,$20,$30,$00

        .byt $00,$06,$07,$33,$73,$61,$3f,$0f,$00,$60,$e0,$cc,$ce,$86,$fc,$f0    ; bear 1
        .byt $03,$03,$07,$06,$06,$0e,$1e,$00,$c0,$e0,$e0,$60,$70,$78,$00,$00

        .byt $00,$06,$37,$63,$33,$31,$1f,$0f,$00,$60,$ec,$c6,$cc,$8c,$f8,$f0    ; bear 2
        .byt $03,$07,$07,$06,$0e,$1e,$00,$00,$c0,$c0,$e0,$60,$60,$70,$78,$00

        .byt $1c,$7f,$7f,$1c,$00,$00,$00,$00,$00,$00,$00,$1c,$7f,$7f,$1c,$00    ; forest
        .byt $1c,$7f,$7f,$1c,$00,$00,$00,$00,$00,$00,$00,$00,$1c,$7f,$7f,$1c

        .byt $1c,$7f,$7f,$1c,$00,$00,$00,$00,$00,$00,$00,$1c,$6f,$7f,$1c,$00    ; forest
        .byt $1c,$7f,$7f,$1c,$00,$00,$00,$00,$00,$00,$00,$00,$1c,$7f,$7f,$1c

        .byt $00,$0f,$0f,$0f,$06,$3f,$7f,$6f,$00,$00,$00,$04,$04,$c4,$e4,$6e    ; fighter 1
        .byt $66,$6f,$0f,$19,$19,$19,$38,$00,$3c,$00,$00,$80,$80,$c0,$00,$00

        .byt $00,$0f,$0f,$0f,$06,$3f,$7f,$6f,$00,$00,$00,$00,$00,$c0,$e2,$64    ; fighter 2
        .byt $66,$3f,$0f,$1b,$1b,$1b,$3b,$00,$68,$30,$28,$00,$00,$00,$80,$00

        .byt $1c,$7f,$7f,$1c,$00,$00,$00,$00,$00,$00,$00,$1c,$7f,$7f,$1c,$00    ; forest
        .byt $1c,$7f,$7f,$1c,$00,$00,$00,$00,$00,$00,$00,$00,$1c,$7f,$7f,$1c

        .byt $1c,$7f,$7f,$1c,$00,$00,$00,$00,$00,$00,$00,$1c,$6f,$7b,$1c,$00    ; forest
        .byt $1c,$7f,$7f,$1c,$00,$00,$00,$00,$00,$00,$00,$00,$1c,$7f,$7f,$1c

        .byt $00,$07,$07,$07,$02,$1f,$2f,$47,$00,$00,$00,$00,$02,$c4,$a8,$10    ; fighter 1
        .byt $22,$17,$07,$0d,$08,$08,$18,$00,$28,$00,$00,$80,$80,$80,$c0,$00

        .byt $00,$07,$07,$07,$02,$1f,$2f,$47,$00,$00,$00,$00,$00,$c0,$a0,$20    ; fighter 2
        .byt $42,$47,$07,$0d,$10,$20,$60,$00,$7e,$20,$00,$80,$80,$80,$c0,$00

        .byt $00,$04,$07,$03,$03,$01,$0f,$1f,$00,$20,$e0,$cc,$cc,$8c,$f8,$f0    ; orc 1
        .byt $33,$37,$37,$06,$06,$0e,$00,$00,$c0,$c0,$e0,$60,$60,$60,$70,$00

        .byt $00,$04,$07,$33,$33,$31,$1f,$0f,$00,$20,$e0,$c0,$c0,$80,$f0,$f8    ; orc 2
        .byt $03,$03,$07,$06,$06,$06,$0e,$00,$cc,$ec,$ec,$60,$60,$70,$00,$00

        .byt $00,$01,$01,$01,$00,$0f,$1b,$31,$00,$c0,$c0,$c0,$80,$f8,$ec,$c6    ; guard 1
        .byt $30,$31,$03,$06,$06,$0e,$00,$00,$8c,$d8,$c0,$60,$30,$30,$38,$00

        .byt $00,$01,$01,$01,$00,$0f,$1b,$31,$00,$c0,$c0,$c0,$80,$f8,$ec,$c6    ; guard 2
        .byt $18,$0d,$01,$03,$06,$06,$0e,$00,$86,$c6,$e0,$30,$30,$38,$00,$00

        .byt $02,$09,$01,$09,$00,$27,$2b,$11,$a0,$c8,$c0,$c8,$80,$f2,$ea,$c4    ; mage 1
        .byt $00,$01,$03,$03,$07,$02,$06,$00,$80,$c0,$e0,$e0,$f0,$20,$30,$00

        .byt $00,$01,$01,$01,$00,$07,$0b,$11,$00,$c0,$c0,$c0,$80,$f0,$e8,$c4    ; mage 2
        .byt $08,$05,$03,$03,$07,$02,$06,$00,$88,$d0,$e0,$e0,$f0,$20,$30,$00

        .byt $00,$01,$01,$01,$20,$27,$2b,$71,$00,$c0,$c0,$c0,$80,$f0,$e8,$c8    ; ranger 1
        .byt $20,$01,$01,$03,$02,$02,$06,$00,$9e,$c8,$c0,$60,$20,$20,$30,$00

        .byt $00,$01,$01,$01,$00,$07,$0b,$09,$00,$c0,$c0,$c0,$80,$f4,$f4,$ce    ; ranger 2
        .byt $7c,$09,$01,$03,$02,$02,$06,$00,$84,$c0,$c0,$60,$20,$20,$30,$00

        .byt $00,$01,$01,$01,$20,$27,$2b,$31,$00,$c0,$c0,$c0,$80,$f0,$e8,$c4    ; cleric 1
        .byt $20,$21,$21,$23,$22,$22,$26,$00,$88,$d0,$c0,$60,$20,$20,$30,$00

        .byt $20,$21,$21,$31,$28,$27,$23,$21,$00,$c0,$c0,$c0,$80,$f0,$e8,$c4    ; cleric 2
        .byt $20,$21,$21,$03,$02,$02,$06,$00,$88,$d0,$c0,$60,$20,$20,$30,$00

        .byt $07,$1f,$3f,$7f,$fc,$f8,$f1,$f3,$e0,$f8,$fc,$fe,$3f,$1f,$8f,$cf    ; hit 1
        .byt $f1,$f8,$fc,$7f,$3f,$1f,$07,$00,$8f,$1f,$3f,$fe,$fc,$f8,$e0,$00

        .byt $07,$1f,$3f,$7f,$fc,$f8,$f1,$f3,$e0,$f8,$fc,$fe,$3f,$1f,$8f,$cf    ; hit 2
        .byt $f1,$f8,$fc,$7f,$3f,$1f,$07,$00,$8f,$1f,$3f,$fe,$fc,$f8,$e0,$00

bmpLinePtrLb
l1200
        .byt $00,$01,$02,$03,$04,$05,$06,$07,$40,$41,$42,$43,$44,$45,$46,$47
        .byt $80,$81,$82,$83,$84,$85,$86,$87,$c0,$c1,$c2,$c3,$c4,$c5,$c6,$c7
        .byt $00,$01,$02,$03,$04,$05,$06,$07,$40,$41,$42,$43,$44,$45,$46,$47
        .byt $80,$81,$82,$83,$84,$85,$86,$87,$c0,$c1,$c2,$c3,$c4,$c5,$c6,$c7
        .byt $00,$01,$02,$03,$04,$05,$06,$07,$40,$41,$42,$43,$44,$45,$46,$47
        .byt $80,$81,$82,$83,$84,$85,$86,$87,$c0,$c1,$c2,$c3,$c4,$c5,$c6,$c7
        .byt $00,$01,$02,$03,$04,$05,$06,$07,$40,$41,$42,$43,$44,$45,$46,$47
        .byt $80,$81,$82,$83,$84,$85,$86,$87,$c0,$c1,$c2,$c3,$c4,$c5,$c6,$c7
        .byt $00,$01,$02,$03,$04,$05,$06,$07,$40,$41,$42,$43,$44,$45,$46,$47
        .byt $80,$81,$82,$83,$84,$85,$86,$87,$c0,$c1,$c2,$c3,$c4,$c5,$c6,$c7
        .byt $00,$01,$02,$03,$04,$05,$06,$07,$40,$41,$42,$43,$44,$45,$46,$47
        .byt $80,$81,$82,$83,$84,$85,$86,$87,$c0,$c1,$c2,$c3,$c4,$c5,$c6,$c7

bmpLinePtrHb
l12c0
        .byt $20,$20,$20,$20,$20,$20,$20,$20,$21,$21,$21,$21,$21,$21,$21,$21
        .byt $22,$22,$22,$22,$22,$22,$22,$22,$23,$23,$23,$23,$23,$23,$23,$23
        .byt $25,$25,$25,$25,$25,$25,$25,$25,$26,$26,$26,$26,$26,$26,$26,$26
        .byt $27,$27,$27,$27,$27,$27,$27,$27,$28,$28,$28,$28,$28,$28,$28,$28
        .byt $2a,$2a,$2a,$2a,$2a,$2a,$2a,$2a,$2b,$2b,$2b,$2b,$2b,$2b,$2b,$2b
        .byt $2c,$2c,$2c,$2c,$2c,$2c,$2c,$2c,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d
        .byt $2f,$2f,$2f,$2f,$2f,$2f,$2f,$2f,$30,$30,$30,$30,$30,$30,$30,$30
        .byt $31,$31,$31,$31,$31,$31,$31,$31,$32,$32,$32,$32,$32,$32,$32,$32
        .byt $34,$34,$34,$34,$34,$34,$34,$34,$35,$35,$35,$35,$35,$35,$35,$35
        .byt $36,$36,$36,$36,$36,$36,$36,$36,$37,$37,$37,$37,$37,$37,$37,$37
        .byt $39,$39,$39,$39,$39,$39,$39,$39,$3a,$3a,$3a,$3a,$3a,$3a,$3a,$3a
        .byt $3b,$3b,$3b,$3b,$3b,$3b,$3b,$3b,$3c,$3c,$3c,$3c,$3c,$3c,$3c,$3c

l1380
        .byt $c0,$60,$30,$18,$0c,$06,$03,$01,$c0,$60,$30,$18,$0c,$06,$03,$01
        .byt $c0,$60,$30,$18,$0c,$06,$03,$01,$c0,$60,$30,$18,$0c,$06,$03,$01
        .byt $c0,$60,$30,$18,$0c,$06,$03,$01,$c0,$60,$30,$18,$0c,$06,$03,$01
        .byt $c0,$60,$30,$18,$0c,$06,$03,$01,$c0,$60,$30,$18,$0c,$06,$03,$01
        .byt $c0,$60,$30,$18,$0c,$06,$03,$01,$c0,$60,$30,$18,$0c,$06,$03,$01
        .byt $c0,$60,$30,$18,$0c,$06,$03,$01,$c0,$60,$30,$18,$0c,$06,$03,$01
        .byt $c0,$60,$30,$18,$0c,$06,$03,$01,$c0,$60,$30,$18,$0c,$06,$03,$01
        .byt $c0,$60,$30,$18,$0c,$06,$03,$01,$c0,$60,$30,$18,$0c,$06,$03,$01
        .byt $c0,$60,$30,$18,$0c,$06,$03,$01,$c0,$60,$30,$18,$0c,$06,$03,$01
        .byt $c0,$60,$30,$18,$0c,$06,$03,$01,$c0,$60,$30,$18,$0c,$06,$03,$01
        .byt $c0,$60,$30,$18,$0c,$06,$03,$01,$c0,$60,$30,$18,$0c,$06,$03,$01
        .byt $c0,$60,$30,$18,$0c,$06,$03,$01,$c0,$60,$30,$18,$0c,$06,$03,$01
        .byt $c0,$60,$30,$18,$0c,$06,$03,$01,$c0,$60,$30,$18,$0c,$06,$03,$01
        .byt $c0,$60,$30,$18,$0c,$06,$03,$01,$c0,$60,$30,$18,$0c,$06,$03,$01
        .byt $c0,$60,$30,$18,$0c,$06,$03,$01,$c0,$60,$30,$18,$0c,$06,$03,$01
        .byt $c0,$60,$30,$18,$0c,$06,$03,$01,$c0,$60,$30,$18,$0c,$06,$03,$01

tilePtrLb
l1480
        .byt $00,$20,$40,$60,$80,$a0,$c0,$e0,$00,$20,$40,$60,$80,$a0,$c0,$e0
        .byt $00,$20,$40,$60,$80,$a0,$c0,$e0,$00,$20,$40,$60,$80,$a0,$c0,$e0
        .byt $00,$20,$40,$60,$80,$a0,$c0,$e0,$00,$20,$40,$60,$80,$a0,$c0,$e0
        .byt $00,$20,$40,$60,$80,$a0,$c0,$e0,$00,$20,$40,$60,$80,$a0,$c0,$e0

tilePtrHb
l14c0
        .byt $0c,$0c,$0c,$0c,$0c,$0c,$0c,$0c,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d
        .byt $0e,$0e,$0e,$0e,$0e,$0e,$0e,$0e,$0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
        .byt $10,$10,$10,$10,$10,$10,$10,$10,$11,$11,$11,$11,$11,$11,$11,$11
        .byt $12,$12,$12,$12,$12,$12,$12,$12,$13,$13,$13,$13,$13,$13,$13,$13

tileColors
l1500   
        .byt $60,$50,$50,$f0,$10,$10,$10,$f0,$10,$10,$10,$10,$10,$10,$10,$10
        .byt $10,$10,$50,$50,$10,$10,$10,$10,$10,$10,$10,$10,$50,$50,$10,$10
        .byt $50,$50,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$30,$a0
charColors
l1530
        .byt $60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60
        .byt $60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$10,$10,$10,$10,$10,$b0
        .byt $10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10
        .byt $10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10
        .byt $10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10
        .byt $10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10
        .byt $10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10
        .byt $10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10

bmpColOffLb
l15b0 
        .byt $00,$08,$10,$18,$20,$28,$30,$38
        .byt $40,$48,$50,$58,$60,$68,$70,$78
        .byt $80,$88,$90,$98,$a0,$a8,$b0,$b8
        .byt $c0,$c8,$d0,$d8,$e0,$e8,$f0,$f8
        .byt $00,$08,$10,$18,$20,$28,$30,$38

bmpColOffHb
l15d8
        .byt $00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00
        .byt $01,$01,$01,$01,$01,$01,$01,$01

videoMemRowPtrLb
l1600
        .byt $00,$28,$50,$78,$a0,$c8,$f0,$18
        .byt $40,$68,$90,$b8,$e0,$08,$30,$58
        .byt $80,$a8,$d0,$f8,$20,$48,$70,$98
        .byt $c0

videoMemRowPtrHb
l1619
        .byt $04,$04,$04,$04,$04,$04,$04,$05
        .byt $05,$05,$05,$05,$05,$06,$06,$06
        .byt $06,$06,$06,$06,$07,$07,$07,$07
        .byt $07

_directionToKey
l1632
        .asc " ;:/@"
l1637
        .byt $02
l1638
        .byt $ff
l1639
        .byt $10
l163a   jmp l178f
l163d   jmp l17ec
l1640   jmp l171f
l1643   jmp l1722
l1646   jmp l1723
scrollTextWindow
l1649   jmp _scrollTextWindow
l164c   jmp l199e
l164f   jmp l19a6
l1652   jmp l1a48
setTextFull
l1655   jmp _setTextFull
setTextStatus
l1658   jmp _setTextStatus
l165b   jmp l1a0d
l165e   jmp l1a3a
l1661   jmp l16ad
l1664   jmp l1700
drawChar
l1667
        jmp _drawChar
l166a   jmp l1c8a
l166d   jmp l1e2c

randomNumber
l1670   jmp _randomNumber
l1673   jmp l1e08
readKey
l1676   jmp _readKey
getKey
l1679   jmp _getKey
l167c   jmp l1e50
l167f   jmp l1e8c
playSoundEffect
l1682   jmp _playSoundEffect
l1685   jmp l1b89
l1688   jmp l1b72
l168b   jmp l1773
l168e   jmp l17ed
l1691   jmp l1866
l1694   jmp l186a
l1697   jmp l16ac
l169a   jmp l16ac
l169d   jmp l1c81
l16a0   sec
l16a1   pha
l16a2   sbc #$01
        bne l16a2
l16a6   pla
        sbc #$01
        bne l16a1
l16ab   rts

l16ac   rts

l16ad   lda #$21
        eor $5c
        sta $61
        lda #$48
        sta $60
        ldx #$11
l16b9   ldy #$00
        tya
l16bc   sta ($60),y
        iny
        bne l16bc
l16c1   inc $61
        ldy #$2f
l16c5   sta ($60),y
        dey
        bpl l16c5
l16ca   lda $60
        clc
        adc #$40
        sta $60
        bcc l16d5
l16d3   inc $61
l16d5   dex
        bpl l16b9
l16d8   lda #$29
        sta $60
        lda #>screenRAM0
        ldx $5c
        beq l16e4
l16e2   lda #>screenRAM1
l16e4   ldx #$11
        sta $61
l16e8   ldy #$25
        lda #$10
l16ec   sta ($60),y
        dey
        bpl l16ec
l16f1   lda $60
        clc
        adc #$28
        sta $60
        bcc l16fc
l16fa   inc $61
l16fc   dex
        bpl l16e8
l16ff   rts

l1700   jsr l1c81
l1703   lda $5c
        tax
        beq l170a
l1708   ldx #$01
l170a   eor $5d
        sta $5c
        lda l1e28,x
        sta Cia2PortA
        lda l1e2a,x
        sta VicMemCtrlReg
l171a   jsr l1b72
l171d   bne l171a

l171f   rts

        .asc ""
        .byt $60,$60
l1722   rts

l1723   lda #>bitmapRAM0
        tax
        eor $5c
        sta l1737
        eor $5d
        sta l1734
        ldy #$00
l1732   l1734 = * + 2
        lda bitmapRAM1,y
        l1737 = * + 2
        sta bitmapRAM0,y
        iny
        bne l1732
l173b   inc l1734
        inc l1737
        dex
        bne l1732
l1744   lda #$00
        sta $60
        sta $62
        lda l1734
        cmp #$60
        beq l1753
        lda #$04
l1753   sta $61
        lda l1737
        cmp #$60
        beq l175e
        lda #$04
l175e   sta $63
        ldx #$04
        ldy #$00
l1764   lda ($60),y
        sta ($62),y
        iny
        bne l1764
l176b   inc $61
        inc $63
        dex
        bne l1764
l1772   rts
l1773   sta l1788
        ldx #$ff
        cmp #$00
        bne l1782
l177c   tax
        lda #$10
        sta l1788
l1782   stx l1786
        rts
l1786   l1788 = * + 2
        l1789 = * + 3
        l178a = * + 4
        l178e = * + 8
        .byt $ff
        .byt $60
        .byt $06
        .byt $00
        .byt $00
_waterTimer
        .byt $01
_castleFlagTimer
        .byt $03
_townFlagTimer
        .byt $02
        .byt $01

l178f   lda #$01
        sta SidVoice3FreqLb
        lda #$0f
        sta SidVoice3AttackDecay
        lda #$41
        sta SidVoice3CtrlReg
        lda #$8f
        sta _speakerValue
        sta l1c7e
        lda #$ff
        sta SidVoice3SustainRelease
        lda #$00
        sta $56
        sta $5b
        sta zpInverse
        sta Cia1TimeOfDayDseconds
        lda #$18
        sta VicMemCtrlReg
        lda #$08
        sta VicScreenCtrlReg2
        lda #$37
        sta VicScreenCtrlReg1
        lda #$00
        sta VicBorderColor
        tax
        lda #COL_BLACK + COL_WHITE << 4
l17cd   sta screenRAM0,x
        sta screenRAM0+$0100,x
        sta screenRAM0+$0200,x
        sta screenRAM0+$0300,x
        sta screenRAM1,x
        sta screenRAM1+$0100,x
        sta screenRAM1+$0200,x
        sta screenRAM1+$0300,x
        inx
        bne l17cd
        cli
        rts
        clc
        rts

l17ec   rts

l17ed   ldy $27
        bmi l1864
l17f1   ldx $26
        lda bmpLinePtrHb+$10,y
        eor $5c
        sta $63
        lda bmpLinePtrLb+$10,y
        sta $62
l17ff   sty $5e
        tya
        lsr
        lsr
        lsr
        tay
        lda videoMemRowPtrLb+2,y
        sta $60
        lda videoMemRowPtrHb+2,y
        ldy $5c
        beq l1815
l1812   clc
        adc #$5c
l1815   sta $61
        txa
        lsr
        lsr
        lsr
        clc
        adc #$04
        tay
        sta l1865
        lda l1788
        sta ($60),y
        lda $62
        clc
        adc bmpColOffLb,y
        sta $34
        lda $63
        adc bmpColOffHb,y
        sta $35
        ldy #$00
        lda l1786
        eor ($34),y
        and l1380,x
        eor ($34),y
        sta ($34),y
        inx
        beq l1862
l1847   txa
        and #$07
        bne l1862
l184c   ldy #$08
        lda l1786
        eor ($34),y
        and #$80
        eor ($34),y
        sta ($34),y
        ldy l1865
        iny
        lda l1788
        sta ($60),y
l1862   ldy $5e
l1864   rts
l1865   .byt $00
l1866   stx $28
        sty $29
l186a   jsr l17ed
l186d   lda $28
        cmp $26
        bne l1879
l1873   lda $29
        cmp $27
        beq l1864
l1879   lda #$01
        sta $2a
        sta $2b
        ldx #$ff
        sec
        lda $28
        sbc $26
        bcs l188f
l1888   sec
        lda $26
        sbc $28
        stx $2a
l188f   sta $24
        sec
        lda $29
        sbc $27
        bcs l189f
l1898   sec
        lda $27
        sbc $29
        stx $2b
l189f   sta $25
        cmp $24
        bcc l18ce
l18a5   sta $3a
        lsr
        sta $3b
l18aa   clc
        lda $3b
        adc $24
        sta $3b
        sec
        sbc $25
        bcc l18bf
l18b6   sta $3b
        clc
        lda $26
        adc $2a
        sta $26
l18bf   clc
        lda $27
        adc $2b
        sta $27
l18c6; Instruction opcode accessed.
; Instruction opcode accessed.
        jsr l17ed
l18c9   dec $3a
        bne l18aa
l18cd   rts
l18ce   lda $24
        sta $3a
        lsr
        sta $3b
l18d5   clc
        lda $26
        adc $2a
        sta $26
        tax
        clc
        lda $3b
        adc $25
        sta $3b
        bcc l18eb
l18e6   sbc $24
        jmp l18f0
l18eb   sec
        sbc $24
        bcc l1908
l18f0   sta $3b
        clc
        lda $27
        adc $2b
        sta $27
        tay
        bmi l190b
l18fc   lda bmpLinePtrLb+$10,y
        sta $62
        lda bmpLinePtrHb+$10,y
        eor $5c
        sta $63
l1908   jsr l17ff
l190b   dec $3a
        bne l18d5
l190f   rts

_scrollTextWindow
l1910   ldx zpWndBtm
        dex
        txa
        sta zpCursorRow
        sec
        sbc zpWndTop
        sta $43
        lda zpWndTop
        asl
        asl
        asl
        tax
        lda #$60
        sta $0720
        sta $0748
        sta $0770
        sta $6320
        sta $6348
        sta $6370
_scrollTextWinL1
l1935   lda bmpLinePtrLb,x
        ldy zpWndLeft
        clc
        adc bmpColOffLb,y
        sta l197f
        sta l1982
        lda bmpLinePtrHb,x
        adc bmpColOffHb,y
        sta l1980
        eor $5d
        sta l1983
        lda l197f
        adc #$40
        sta l197c
        lda l1980
        adc #$01
        sta l197d
        lda #$00
        sta $5f
        lda zpWndWdth
        sec
        sbc #$01
        asl
        asl
        asl
        rol $5f
        ora #$07
        tay
        sta $5e
        lda $5f
        beq l197b
        ldy #$ff
l197b   l197c = * + 1
        l197d = * + 2
        lda $2100,y
        l197f = * + 1
        l1980 = * + 2
        sta $2000,y
        l1982 = * + 1
        l1983 = * + 2
        sta $4000,y
        dey
        cpy #$ff
        bne l197b
        ldy $5e                 ; # of bytes in text line, lb
        inc l1980
        inc l1983
        dec $5f                 ; # of bytes in text line, hb
        bpl l197b
        txa
        clc
        adc #$08
        tax
        dec $43
        bne _scrollTextWinL1

l199e   lda zpCursorRow
l19a0   ldx #$00
        stx zpCursorCol
        beq l19ae
l19a6   ldx zpCursorCol
        cpx zpWndWdth
        bcs l1a0a
l19ac   lda zpCursorRow
l19ae   asl
        asl
        asl
        tax
        lda zpWndLeft
        clc
        adc zpCursorCol
        tay
        lda bmpLinePtrLb,x
        clc
        adc bmpColOffLb,y
        sta l19f4
        sta l19f7
        lda bmpLinePtrHb,x
        adc bmpColOffHb,y
        eor $5c
        sta l19f5
        eor $5d
        sta l19f8
        lda #$00
        sta $5f
        lda zpWndWdth
        sec
        sbc zpCursorCol
        sec
        sbc #$01
        asl
        asl
        asl
        rol $5f
        ora #$07
        tay
        sta $5e
        lda $5f
        beq l19f1
l19ef   ldy #$ff
l19f1   lda zpInverse
l19f3   l19f4 = * + 1
        l19f5 = * + 2
        sta $2000,y
        l19f7 = * + 1
        l19f8 = * + 2
        sta $4000,y
        dey
        cpy #$ff
        bne l19f3
l19fe   ldy $5e
        inc l19f5
        inc l19f8
        dec $5f
        bpl l19f3
l1a0a   jmp l1e08
l1a0d   lda #$1e
        sta zpWndWdth
        lda #$00
        beq l1a1b

_setTextStatus
l1a15   lda #10
        sta zpWndWdth
        lda #31
l1a1b   sta zpWndLeft
        lda #24
        sta zpWndBtm
        lda #20
l1a23   sta zpWndTop
        sta zpCursorRow
        lda #$00
        sta zpCursorCol
        rts

_setTextFull
l1a2c   lda #40
        sta zpWndWdth
        lda #24
        sta zpWndBtm
        lda #0
        sta zpWndLeft
        beq l1a23

l1a3a   lda #$26
        sta zpWndWdth
        lda #$13
        sta zpWndBtm
        lda #$01
        sta zpWndLeft
        bne l1a23

l1a48   ldy zpWndTop
        sty zpCursorRow
l1a4c   tya
        pha
        lda videoMemRowPtrLb,y
        sta $60
        lda videoMemRowPtrHb,y
        ldx $5c
        beq l1a5d
l1a5a   clc
        adc #$5c
l1a5d   sta $61
        ldx zpWndWdth
        ldy zpWndLeft
        lda #$10
l1a65   sta ($60),y
        iny
        dex
        bne l1a65
l1a6b   pla
        pha
        jsr l19a0
l1a70   pla
        tay
        iny
        cpy zpWndBtm
        bcc l1a4c
l1a77   rts

_drawChar
l1a78   pha                     ; store A (character to be drawn)
        stx _drawCharStoreX     ; store X
        ldx zpCursorCol
        cpx zpWndWdth
        bcs l1b00
        and #$7f
        sta $5e
        lda zpCursorRow
        asl                     ; calc raster line for cursor pos
        asl
        asl
        tax
        lda zpWndLeft
        clc
        adc zpCursorCol
        tay
        lda bmpLinePtrLb,x      ; get bitmap pointer for raster line
        clc
        adc bmpColOffLb,y       ; add column offset
        sta l1acc
        sta l1acf
        lda bmpLinePtrHb,x
        adc bmpColOffHb,y
        eor $5c
        sta l1acd
        eor $5d
        sta l1ad0
        lda $5e
        asl
        asl
        asl
        sta l1ac7
        lda $5e
        lsr
        lsr
        lsr
        lsr
        lsr
        clc
        adc #$08
        sta l1ac8
        ldx #$07
_drawCharL1
        l1ac7 = * + 1
        l1ac8 = * + 2
        lda $0800,x             ; read charset byte
        eor zpInverse           ; invert if applicable
        l1acc = * + 1
        l1acd = * + 2
        sta $2000,x             ; store in first bitmap RAM
        l1acf = * + 1
        l1ad0 = * + 2
        sta $4000,x             ; store in second bitmap RAM
        dex
        bpl _drawCharL1

        ldx zpCursorRow
        lda videoMemRowPtrLb,x
        sta $60
        sta $62
        lda videoMemRowPtrHb,x
        ldx $5c
        beq _drawCharJ1
        clc
        adc #$5c
_drawCharJ1
        sta $61                 ; video RAM (color) for first bitmap
        ldx $5d
        beq _drawCharJ2
        eor #$64
_drawCharJ2
        sta $63                 ; video RAM (color) for second bitmap
        lda zpCursorCol
        clc
        adc zpWndLeft
        tay
        ldx $5e
        lda charColors,x        ; color value for character X
        sta ($60),y             ; store in first video RAM
        sta ($62),y             ; store in second video RAM
l1b00   ldx _drawCharStoreX     ; restore X
        pla                     ; restore A
        rts

_drawCharStoreX
        .byt $00

_animateWater
l1b06   jsr _animateWaterJ1     ; swap quarter-tile order
        ldx #$0f
        jsr _cycleHalfTile      ; cycle left side of tile
        ldx #$1f
        jsr _cycleHalfTile      ; cycle right side of tile
_animateWaterJ1
l1b13   ldx #$07                ; swap quarter-tile order
_animateWaterL1
        lda tileset+$08,x       ; quarter tile byte at offset $08
        ldy tileset+$10,x       ; quarter tile byte at offset $10
        sta tileset+$10,x       ; swap bytes
        tya
        sta tileset+$08,x
        dex                     ; repeat for all 8 bytes in quarter tiles
        bpl _animateWaterL1
        rts

_cycleHalfTile 
        lda tileset,x           ; store bottom row of half tile
        pha
_cycleHalfTileL1
l1b2a   dex
        lda tileset,x           ; copy tile byte
        inx
        sta tileset,x           ; to row below
        dex
        bmi _cycleHalfTileJ1    ; finished (left half)? ->
        cpx #$0f                ; finished (right half)?
        bne _cycleHalfTileL1    ; no ->
_cycleHalfTileJ1
        inx
        pla
        sta tileset,x           ; roll around lowest byte to uppermost
        rts

_soundFxRoutines
l1b3f
        .word $1c4f-1
        .word $1c49-1
        .word $1c2c-1
        .word $1bbe-1
        .word $1c1e-1
        .word $1bb8-1
        .word $1c0d-1
        .word $1ba2-1
        .word $1bb2-1

_playSoundEffect
l1b51   stx $43
        tax
        lsr
        bcs l1b6f
l1b57   cpx #$12
        bcs l1b6f
l1b5b   lda l1638
        beq l1b6f
l1b60   php
        sei                     ; block interrupts during sound playback
        jsr l1b67
        plp                     ; release interrupts
        rts

l1b67   lda _soundFxRoutines+1,x
        pha
        lda _soundFxRoutines,x
        pha
l1b6f   ldx $43
        rts

l1b72   lda $5b
        beq l1b88
l1b76   lda $57
        ldx #$01
l1b7a   ldy $57,x
        sty $56,x
        inx
        cpx #$04
        bcc l1b7a

l1b83   jsr _playSoundEffect
l1b86   dec $5b
l1b88   rts
l1b89   ldx $5b
        beq l1b9d
l1b8d   ldy $56,x
        bne l1b92
l1b91   dex
l1b92   cpx #$04
        bcc l1b9d
l1b96   pha
        jsr l1b72
l1b9a   pla
        ldx $5b
l1b9d   sta $57,x
        inc $5b
        rts
l1ba2   ldy #$10
        lda #$30
l1ba6   pha
        jsr l16a0
l1baa   jsr _toggleSpeaker
l1bad   pla
        dey
        bne l1ba6
l1bb1   rts
l1bb2   ldy #$32
        lda #$17
        bne l1ba6
l1bb8   ldx #$40
        ldy #$40
        bne l1bc2
l1bbe   ldx #$e0
        ldy #$06
l1bc2   stx $3a
        stx $2a
        sty $3b
        lda #$01
        sta $2b
l1bcc   lda $3b
        sta $43
l1bd0   ldx $2a
l1bd2   dex
        bne l1bd2
l1bd5   jsr _toggleSpeaker
l1bd8   ldx $2b
l1bda   dex
        bne l1bda
l1bdd   jsr _toggleSpeaker
l1be0   dec $43
        bne l1bd0
l1be4   dec $2a
        inc $2b
        lda $2b
        cmp #$1b
        bne l1bcc
l1bee   lda $3b
        sta $43
l1bf2   ldx $2a
l1bf4   dex
        bne l1bf4
l1bf7   jsr _toggleSpeaker
l1bfa   ldx $2b
l1bfc   dex
        bne l1bfc
l1bff   jsr _toggleSpeaker
l1c02   dec $43
        bne l1bf2
l1c06   inc $2a
        dec $2b
        bne l1bee
l1c0c   rts
l1c0d   lda #$fb
        sta $3a
l1c11   inx
        bne l1c11
l1c14   jsr _toggleSpeaker
l1c17   dec $3a
        ldx $3a
        bne l1c11
l1c1d   rts
l1c1e   ldy #$a0
l1c20   tya
        tax
l1c22   dex
        bne l1c22
l1c25   jsr _toggleSpeaker
l1c28   dey
        bne l1c20
l1c2b   rts
l1c2c   lda #$40
        sta $3a
        lda #$e0
        sta $3b
l1c34   jsr _randomNumber
l1c37   ora $3b
        tax
l1c3a   dex
        bne l1c3a
l1c3d   jsr _toggleSpeaker
l1c40   dec $3b
        lda $3b
        cmp $3a
        bcs l1c34
l1c48   rts

l1c49   lda #$e8
        ldx #$ff
        bne l1c53

l1c4f   lda #$00
        ldx #$08
l1c53   stx $3a
        sta l1c69
        lda #$00
        sta $3b
l1c5c   jsr _randomNumber
l1c5f   ora $3b
        tax
l1c62   dex
        bne l1c62
l1c65   jsr _toggleSpeaker
l1c68   l1c69 = * + 1
; Instruction parameter accessed.
        bit $c0e8
        dec $3a
        bne l1c5c
l1c6f   rts

_toggleSpeaker
l1c70   sta $5e
        lda _speakerValue
        eor #$80
        sta _speakerValue
        sta SidFilterModeVolume
        l1c7e = * + 1
; Instruction parameter accessed.
        lda $5e
        rts

_speakerValue
        .byt $8f

l1c81   jsr l1e08
l1c84   lda VicScreenCtrlReg1
        bpl l1c81
l1c89   rts

_updateMap                      ; update map routine?
l1c8a   lda #$08                ; start with raster line 8
        sta $45
        sec
        lda zpLongitude         ; calculate x-offset of map window
        sbc #9
        sta $46
        sec
        lda zpLatitude          ; calculate y-offset of map window
        sbc #4
        sta $47

l1c9c   jsr l1ed5               ; read joystick/keyboard (?)
l1c9f   bpl l1ca4
        jsr l1e0d
l1ca4   lda $47                 ; current map row
        cmp #$40                ; 0 < row <= 64?
        bcs _updateMapWaterRow  ; no -> fill this row with water
        lsr
        sta zpMapPtr+1          ; mapPtr = mapBuffer + row * 0x40
        lda #$00
        ror
        lsr zpMapPtr+1
        ror
        sta zpMapPtr
        lda zpMapPtr+1
        adc #>mapBuffer
        sta zpMapPtr+1
        ldx #$00
        ldy $46                 ; current map column
l1cbf   cpy #$40                ; 0 < column <= 64?
        bcc l1cd2
        lda #TILE_WATER         ; print water (0) for this tile
        beq l1cf1               ; always true ->
_updateMapWaterRow
l1cc7   ldx #$12
        lda #TILE_WATER         ; fill whole tile row with water
l1ccb   sta $66,x
        dex
        bpl l1ccb
l1cd0   bmi l1cfa

l1cd2   lda (zpMapPtr),y        ; read tile from mapBuffer
        and #$7e                ; clear highest and lowest bits
        cmp #$20
        bcc l1cf1
        cmp #$59
        bcs l1cf1
        stx $48
        sta $49
        inc l178e
        ldx l178e
        lda $b700,x
        and #$02
        adc $49
        ldx $48
l1cf1   lsr                     ; convert to continuous tile id
        sta $66,x               ; store in current tile row
        inx
        iny
        cpx #19                 ; repeat for 19 tiles in current row
        bcc l1cbf

l1cfa   lda $47                 ; current map row
        inc $47
        cmp zpLatitude
        bne l1d08
l1d02   lda l1639
        lsr
        sta $6f
l1d08   ldx $45                 ; destination raster line
        lda bmpLinePtrLb,x
        clc
        adc #$28
        sta $60
        lda bmpLinePtrHb,x
        adc #$01
        eor $5c
        sta $61
        lda $60
        adc #$40
        sta $62
        lda $61
        adc #$01
        sta $63
        lda $45
        lsr
        lsr
        lsr
        tay
        lda videoMemRowPtrLb,y
        sta $64
        lda videoMemRowPtrHb,y
        ldx $5c
        beq l1d3c
l1d39   clc
        adc #>(screenRAM1-screenRAM0)
l1d3c   sta $65
        ldx #18                 ; horizontal tile index (18..0)
_drawTilesL1
l1d40   lda $66,x               ; read tile from current row of tiles
        tay                     ; tile id as index
        lda tileColors,y
        sta $5e
        lda tilePtrLb,y
        sta _tilePtrUpper
        clc
        adc #$10
        sta _tilePtrLower
        lda tilePtrHb,y
        sta _tilePtrUpper+1
        adc #$00
        sta _tilePtrLower+1
        ldy #$0f                ; iterate for 16 tile lines
_drawTilesL2
_tilePtrUpper = * + 1
        lda tileset,y           ; read tile byte (upper half)
        sta ($60),y
_tilePtrLower = * + 1
        lda tileset,y           ; read tile byte (lower half)
        sta ($62),y
        dey
        bpl _drawTilesL2

        txa
        asl                     ; screenRAM column = xpos * 2
        tay                     ; screenRAM index
        iny                     ; skip left frame border
        lda $5e                 ; tile color
        sta ($64),y             ; store in screen RAM upper left
        iny
        sta ($64),y             ; store in screen RAM upper right
        tya
        clc
        adc #40
        tay
        lda $5e                 ; tile color
        sta ($64),y             ; store in screen RAM lower right
        dey
        sta ($64),y             ; store in screen RAM lower left

        lda $60
        sec
        sbc #$10                ; set bitmap pointer (upper) to next tile on the left
        sta $60
        lda $61
        sbc #$00
        sta $61
        lda $62
        sec
        sbc #$10                ; set bitmap pointer (lower) to next tile on the left
        sta $62
        lda $63
        sbc #$00
        sta $63
        dex                     ; repeat for 19 tiles
        bpl _drawTilesL1

l1da2   lda $45
        clc
        adc #$10
        sta $45
        lda $45
        cmp #$98
        bcs l1db2
l1daf   jmp l1c9c

l1db2   jsr l1700

        dec _waterTimer
        bne _animateCastleFlag
        lda #2                  ; reset timer to 2
        sta _waterTimer
        ldy #$00
        jsr _animateWater
_animateCastleFlag
        dec _castleFlagTimer
        bne _animateTownFlag
        lda #3                  ; reset timer to 3
        sta _castleFlagTimer
        ldx tileset+$0089       ; exchange right half of lines 1 and 2
        ldy tileset+$008a       ; (this wiggles the castle's flag)
        sty tileset+$0089
        stx tileset+$008a
_animateTownFlag
        dec _townFlagTimer
        bne _animateFrigateFlag
        lda #2                  ; reset timer to 2
        sta _townFlagTimer
        ldx tileset+$00c3       ; exchange left half of lines 3 and 4
        ldy tileset+$00c4       ; (this wiggles the town's flag)
        sty tileset+$00c3
        stx tileset+$00c4
_animateFrigateFlag
        ldx tileset+$018a       ; exchange lines 2 and 3 (both halfs)
        ldy tileset+$018b       ; (this wiggles the frigate's flag)
        sty tileset+$018a
        stx tileset+$018b
        ldx tileset+$0182
        ldy tileset+$0183
        sty tileset+$0182
        stx tileset+$0183

l1e08   jsr l1ed5
l1e0b   bpl l1e27

l1e0d   cmp #$90
        beq l1e27
l1e11   cmp #$93
        beq l1e27
l1e15   cmp #$a0
        bne l1e1d
l1e19   ldx #$00
        stx $56
l1e1d   ldx $56
        cpx #$08
        bcs l1e27
l1e23   sta $4e,x
        inc $56
l1e27   rts

_cia2PortAVal
l1e28
        .byt $97,$96
_vicMemCtrlRegVal
l1e2a
        .byt $18,$80

l1e2c   ldy #$07
l1e2e   jsr l1e08
l1e31   lda $56
        bne l1e27
l1e35   lda #$4f
        jsr l16a0
l1e3a   dey
        bne l1e2e
l1e3d   rts

_readKey
l1e3e   jsr _getKey
        beq _readKey
        rts

_getKey
l1e44   jsr l1e83
l1e47   jsr l1e2c
l1e4a   lda $56
        bne l1e5a
l1e4e   beq l1e7a
l1e50   jsr l1e83
l1e53   jsr l1c8a
l1e56   lda $56
        beq l1e7a
l1e5a   lda #$20                ; space
        jsr _drawChar
l1e5f   lda $4e
        dec $56
        ldx #$01
        cmp #$ff
        bne l1e6b
l1e69   lda #$88
l1e6b   cmp #$e0
        bcc l1e71
l1e6f   eor #$20
l1e71   ldy $4e,x
        sty $4d,x
        inx
        cpx #$08
        bcc l1e71
l1e7a   ldx l1789
        ldy l178a
        and #$7f
        rts

l1e83   stx l1789
        sty l178a
        jsr l16ac               ; (rts)
l1e8c   ldx _cursorAnimPhase
        dex
        cpx #$7c                ; char: min cursor phase
        bcs l1e96
        ldx #$7f                ; char: max cursor phase
l1e96   stx _cursorAnimPhase
_cursorAnimPhase = * + 1
        lda #$7c                ; cursor animation phase
        jsr _drawChar           ; draw cursor

_randomNumber
l1e9e   clc
        lda l1ed4
        ldx #$0e
l1ea4   adc l1ec5,x
        sta l1ec5,x
        dex
        bpl l1ea4
l1ead   lda l1ed4
        clc
        adc l1ec5
        sta l1ec5
        ldx #$0f
l1eb9   inc l1ec5,x
        bne l1ec1
l1ebe   dex
        bpl l1eb9
l1ec1   lda l1ec5
        rts

l1ec5   .asc ""
        .byt $64,$76,$85,$54
        .asc "v"
        .byt $5c,$76,$1f
        .asc "g"
        .byt $12
        .asc "'"
        .byt $6b,$93
        .asc "D"
l1ed3   l1ed4 = * + 1
        .byt $6e,$1b

l1ed5
        sty $5e
        lda #$ff
        sta Cia1PortB           ; keyboard row / joystick: set all to high
        lda Cia1PortA           ; read joystick port 2
        sty $5e
        ldy #$04                ; iterate over joystick direction pins
l1ee3   lsr                     ; direction pin: up/down/left/right/fire
        bcs l1eec               ; direction not activated ->
        lda _directionToKey,y   ; get keyboard code corresponding to direction
        bne l1f27               ; (always true?) ->
l1eeb   rts
l1eec
        dey                     ; try next direction pin
        bpl l1ee3

l1eef   jsr SCNKEY
l1ef2   jsr GETIN
l1ef5   cmp #$00
        bne l1f01
l1ef9   sta l1f83
        sta l1f84
        beq l1f7a
l1f01   cmp #KEY_SHIFT_AT       ; <shift>-@
        bne l1f07
        lda #KEY_NORTH
l1f07   cmp #KEY_ARROW_UP
        bne l1f0d
        lda #KEY_NORTH
l1f0d   cmp #KEY_ARROW_DOWN
        bne l1f13
        lda #KEY_SOUTH
l1f13   cmp #KEY_SHIFT_SLASH
        bne l1f19
l1f17   lda #KEY_SOUTH
l1f19   cmp #KEY_ARROW_LEFT
        bne l1f1f
        lda #KEY_WEST
l1f1f   cmp #KEY_ARROW_RIGHT
        bne l1f25
        lda #KEY_EAST
l1f25   ora #$80
l1f27   cmp l1f83
        sta l1f83
        bne l1f6f               ; entry came from keyboard ->
l1f2f   cmp #$c0                ; '@' (joystick up)
        beq l1f46
l1f33   cmp #$af                ; '/' (joystick down)
        beq l1f46
l1f37   cmp #$bb                ; ';' (joystick left)
        beq l1f46
l1f3b   cmp #$ba                ; ':' (joystick right)
        beq l1f46
l1f3f   lda #$00
        sta l1f84
        beq l1f7a
l1f46   ldy l1637
        cpy #$04
        bcs l1f5e
l1f4d   ldy l1f84
        bne l1f67
l1f52   ldy Cia1TimeOfDaySeconds
        bne l1f62
l1f57   ldy Cia1TimeOfDayDseconds
        cpy #$05
        bcs l1f62
l1f5e   lda #$00
        beq l1f7a
l1f62   inc l1f84
        bne l1f6f
l1f67   ldy Cia1TimeOfDayDseconds
        cpy l1637
        bcc l1f5e
l1f6f   ldy #$00
        sty Cia1TimeOfDayHours
        sty Cia1TimeOfDaySeconds
        sty Cia1TimeOfDayDseconds
l1f7a   ldy #$ff
        sty $c5
        ldy $5e
        pha
        pla
        rts

l1f83   l1f84 = * + 1
        .byt $00,$00
        .asc " "
        .byt $ff
