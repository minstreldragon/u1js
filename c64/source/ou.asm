#include "archdep.h"
#include "constants.h"

        .word $8c9e
        * = $8c9e

l8c9e   lda #$30
        sta $01
        ldx #$0d
        lda #$00
        sta $60
        sta $62
        lda #$d0                ; source: $d000
        sta $61
        lda #>mapData           ; dest: $b000
        sta $63
        ldy #$00
l8cb4   lda ($60),y             ; copy $d000-$dcff
        sta ($62),y             ; to   $b000-$bcff (packed map data?)
        iny
        bne l8cb4
l8cbb   inc $61
        inc $63
        dex
        bne l8cb4

l8cc2   lda #$36
        sta $01
        lda #$c1
        sta $1632
        lda #$02
        sta $1637
        lda statsLongitude
        sta zpLongitude
        lda statsLatitude
        sta zpLatitude
        lda #$60
        sta $5d
        sta $5c
        jsr $1646
l8ce3   ldx #$00
        stx $81c8
        lda $bd00
        bne l8cf0
l8ced   jsr l9a10
l8cf0   jsr l9840
l8cf3   lda statsHp
        ora statsHp+1
        beq l8d4e

_mainLoopOutdoors
l8cfb   ldx #$ff                ; reset stack
        txs
        jsr print               ; print prompt (?)
        .aasc LF,$0e,$00
        jsr _printPlayerTile
_mainLoopOutdrsL1
        jsr $86c6
        lda statsHp
        ora statsHp+1
        beq l8d4b               ; player dead? ->
l8d12   lda statsFood
        ora statsFood+1
        beq l8d4b
l8d1a   jsr l8dd0
l8d1d   bne l8d31
l8d1f   ldy #$05
        lda #$50
        jsr $863c
l8d26   jsr l9a2f
l8d29   lda zpCursorCol
        cmp #$02
        bcc _mainLoopOutdrsL1
l8d2f   bcs _mainLoopOutdoors
l8d31   jsr checkCommandKey     ; check and print command
        bcs l8d45               ; invalid command key? ->
        lda _commandTable,x     ; command table
        sta _cmdJmpPtr
        lda _commandTable+1,x
        sta _cmdJmpPtr+1
_cmdJmpPtr = * + 1
        jsr $8787               ; execute command
l8d45   jsr l9a2f
l8d48   jmp _mainLoopOutdoors

l8d4b   jsr $8bce
l8d4e   ldx #$0a
l8d50   jsr $16a0
l8d53   dex
        bpl l8d50
l8d56   jsr l97e0
l8d59   stx zpLongitude
        sty zpLatitude
        jsr l9a10
l8d60   lda #$00
        ldx statsTransport
        beq l8d72
l8d67   sta statsTransport
        ldy $8213,x
        beq l8d72
l8d6f   dec $8213,x
l8d72   ldx #$0f
l8d74   sta invWeapons,x
        dex
        bne l8d74
        sta statsArmour
        sta statsWeapon
        sta $81ee
        jsr print
        .aasc $7e,"Attempting resurrection!",$00
l8da0   inc statsHp             ; inc hit points
        jsr l8dc5
l8da6   lda statsHp
        cmp #99
        bcc l8da0
l8dad   inc statsFood           ; inc food
        jsr l8dc5
l8db3   lda statsFood
        cmp #99
        bcc l8dad
l8dba   jsr $8777
l8dbd   lda #$0a
        jsr $1685
l8dc2   jmp _mainLoopOutdoors
l8dc5   jsr $86c6
l8dc8   lda #$68
        jsr $16a0
l8dcd   jmp $169d

l8dd0   ldx #$80
l8dd2   jsr $167c
l8dd5   bne l8dda
l8dd7   dex
        bne l8dd2
l8dda   tax
        rts

pass
l8ddc   ldy #$05
        lda #$50
        jmp $863a
l8de3   lda #$00
        sta zpMapPtr
        lda $23
        lsr
        ror zpMapPtr
        lsr
        ror zpMapPtr
        adc #>mapBuffer
        sta zpMapPtr+1
        ldy $22
        rts
l8df6   jsr print
        .aasc ": ",$00
        jsr l8dd0
l8dff   ldx #$03
l8e01   l8e02 = * + 1
; Instruction parameter jumped to.
        cmp $81c9,x
        bne l8e35
l8e06   stx $24
        jsr printFromTable
        .byt $7f
l8e0c   adc $20a6,y
        ldy zpLatitude
        stx $22
        sty $23
        ldx #$00
        ldy #$00
        dec $24
        bmi l8e2c
l8e1d   dec $24
        bmi l8e2f
l8e21   dec $24
        bmi l8e32
l8e25   dex
l8e26   stx $24
        sty $25
        clc
        rts
l8e2c   dey
        bne l8e26
l8e2f   iny
        bne l8e26
l8e32   inx
        bne l8e26
l8e35   dex
        bpl l8e01
l8e38   jsr $842b
l8e3b   rol $3888
        rts
l8e3f   lda $22
        clc
        adc $24
        sta $22
        tax
        lda $23
        clc
        adc $25
        sta $23
        tay
        jsr getMapTile
l8e52   cmp #$03
        beq l8e61
l8e56   jsr l8e62
l8e59   bcc l8e61
l8e5b   dec la145
        bne l8e3f
l8e60   sec
l8e61   rts
l8e62   ldx $826b
        beq l8e97
l8e67   dex
        lda $826c,x
        cmp $22
        bne l8e94
l8e6f   lda $82bc,x
        and #$3f
        cmp $23
        bne l8e94
l8e78   lda $830c,x
        cmp #$20
        bcc l8e94
l8e7f   cmp #$5a
        bcs l8e94
l8e83   lsr
        lsr
        adc #$fe
        sta $8267
        stx $44
        stx $8268
        jsr _getObjectMapPtr
l8e92   clc
        rts
l8e94   txa
        bne l8e67
l8e97   sec
        rts

attack
l8e99   jsr print
       .aasc "with ",$00
        ldx statsWeapon
        jsr printFromTable
        .word strTableWeapons
        ldx statsWeapon
        lda la131,x
        bne l8eb5
        jmp $876a
l8eb5   sta la145
        jsr l8df6
l8ebb   bcc l8ec9
l8ebd   rts

l8ebe   jsr print
        .aasc $7e,"Miss!",$00
        rts
l8ec9   lda #$06
        jsr $1685
        jsr l8e3f
        bcs l8ebe
        lda #$5e
        sta (zpMapPtr),y
        jsr $166a
l8eda   jsr l9c77
l8edd   lda $830c,x
        sta (zpMapPtr),y
        lda statsAgility
        clc
        adc #$80
        sta $43
        jsr randomNumber
l8eed   cmp $43
        bcc l8eff
l8ef1   jsr print
        .aasc $7e,"Missed",$00
l8efc   jmp l8fe7

l8eff   lda statsWeapon
        asl
        asl
        asl
        adc statsStrength
        jsr $85c9
l8f0b   lsr
        clc
        adc #$01
l8f0f   sta $81c1
        lda #$00
        sta $85be
        ldx $44
        lda $bd00,x
        sec
        sbc $81c1
        beq l8f51
l8f22   bcc l8f51
l8f24   sta $bd00,x
        jsr print
        .aasc $7e,"Hit",$00
l8f2f   jsr l8fe7
l8f32   lda zpCursorCol
        cmp #$15
        bcc l8f3b
l8f38   jsr $83f3
l8f3b   lda $81c1
        jsr $8582
l8f41   jsr print
        .aasc " damage",$00
l8f4c   lda #$02
        jmp playSoundEffect
l8f51   jsr print
        .aasc $7e,"Killed",$00
l8f5c   jsr l8fe7
l8f5f   jsr l8f4c
l8f62   ldx $8267
        ldy $7a51,x
        lda l9a05,y
        lsr
        cmp #$02
        bcc l8f73
l8f70   jsr $85c9
l8f73   adc statsXp
        sta statsXp
        bcc l8f7e
l8f7b   inc statsXp+1
l8f7e   tya
        asl
        asl
        jsr $85c9
l8f84   clc
        adc #$0a
        pha
        tax
        lda #$00
        jsr convertToBcd16
l8f8e   lda zpValue1e0
        and #$0f
        beq l8fa0
l8f94   jsr l8fd4
        .aasc "copper! ",$00
l8fa0   lda zpValue1e0
        lsr
        lsr
        lsr
        lsr
        beq l8fb4
l8fa8   jsr l8fd4
        .aasc "silver! ",$00
l8fb4   lda zpValue1e2
        beq l8fc1
        jsr l8fd4
        .aasc "gold!",$00
l8fc1   pla
        clc
        adc $8249
        sta $8249
        bcc l8fce
l8fcb   inc $824a
l8fce   jsr l9024
l8fd1   jmp l8fff

l8fd4   pha
        lda zpCursorCol
        cmp #$15
        bcc l8fde
l8fdb   jsr $83f3
l8fde   pla
        jsr printDigit
        inc zpCursorCol         ; skip one character (blank)
        jmp print

l8fe7   jsr print
l8fea   jsr $6874
        .asc ""
        .byt $65
l8fee   jsr $ae00
        .asc ""
        .byt $67,$82
l8ff3   jsr printFromTable
        .byt $7f,$7a
l8ff8   jsr print
        .asc ""
        .byt $21
l8ffc   jsr $6000
l8fff   ldx $8268
        cpx $826b
        bcs l9022
l9007   lda $830c,x
        l900b = * + 1
; Instruction parameter jumped to.
        cmp #$20
l900c   bcc l9022
l900e   cmp #$5a
        bcs l9022
l9012   jsr l9cfc
l9015   ldx #$00
        stx $8267
        stx $44
        dex
        stx $8268
        clc
        rts
l9022   sec
        rts
l9024   lda statsXp
        cmp #$10
        lda statsXp+1
        sbc #$27
        bcc l903a
l9030   lda #$0f
        sta statsXp
        lda #$27
        sta statsXp+1
l903a   lda $8249
        cmp #$10
        lda $824a
        sbc #$27
        bcc l9050
l9046   lda #$0f
        sta $8249
        lda #$27
        sta $824a
l9050   jmp $86c6

board
l9053   lda statsTransport
        beq l9077               ; on foot? ->
        jsr $83f6               ; set cursor column = 1
        jsr print
        .aasc "X-it thy craft first!",$00
        jmp $8772
l9077   jsr _getStoreMapTile
l907a   cmp #$10
        bcs l9082
l907e   cmp #$08
        bcs l909d
l9082   jsr $83f6
l9085   jsr print
        .aasc "nothing to Board!",$00
        jmp $8772
l909d   and #$07
        cmp #$07
        bcc l90a5
l90a3   lda #$0a
l90a5   sta statsTransport
        pha
        jsr l9cd8
l90ac   jsr _printPlayerTile
l90af   jsr $166a
l90b2   pla
        cmp #$03
        bcs l90c4
l90b7   jsr $83f6
l90ba   jsr print
        .aasc "Mount ",$00
l90c4   jsr $9e02
l90c7   lda statsTransport
        cmp #$06
        beq l90d1
l90ce   bcs l90db
l90d0   rts
l90d1   lda #$0f
        sta $1637
        lda #$05
l90d8   jmp l9262
l90db   lda statsRedGem
        beq l90f3
l90e0   lda statsGreenGem
        beq l90f3
l90e5   lda statsBlueGem
        beq l90f3
l90ea   lda statsWhiteGem
        beq l90f3
l90ef   lda #$06
        bne l90d8
l90f3   jsr $870c
l90f6   jsr $1661
l90f9   jsr $165e
l90fc   sta $5d
        jsr $8416
l9101   jsr print
        .aasc LF,LF,LF,LF,CR
        .aasc $03,"Entering the craft, thou dost",LF,CR
        .aasc $03,"remark upon four holes marked:",LF,LF,CR
        .aasc $0d,"o  o  o  o",LF,CR
        .aasc $0d,"R  G  B  W",LF,LF,$00

l9166   lda statsRedGem
        ora statsGreenGem
        ora statsBlueGem
        ora statsWhiteGem
        bne l91cb
        jsr print
        .aasc $7f,$02,"Thou canst not determine how to",LF,$7f
        .aasc $02,"operate the craft at this time.",$00

l91bb   lda #$60
l91bd   sta $5d
        jsr $1664
l91c2   jsr $8701
l91c5   jsr $85e1
l91c8   jmp $85e4

l91cb   lda statsRedGem
        beq l91d7
l91d0   ldx #$59
        lda #$20
        jsr l923d
l91d7   lda statsGreenGem
        beq l91e3
l91dc   ldx #$71
        lda #$50
        jsr l923d
l91e3   lda statsBlueGem
        beq l91ef
l91e8   ldx #$89
        lda #$60
        jsr l923d
l91ef   lda statsWhiteGem
        beq l91fb
l91f4   ldx #$a1
        lda #$10
        jsr l923d
l91fb   jsr print
        .byt $7f,$05,$54,$68,$6f
l9203   adc $20,x
        pla
        adc ($73,x)
        .asc ""
        .byt $74
l9209   jsr $6f6e
        .asc ""
        .byt $74
l920d   jsr $6c61
l9210   jmp ($7420)
        .asc ""
        .byt $68,$65
l9215   jsr $6567
        .asc ""
        .byt $6d,$73,$7c,$7f,$04,$6e,$65
l921f   adc $64
        adc $64
        jsr $6f74
l9226   jsr $706f
        .asc ""
        .byt $65,$72,$61,$74,$65
l922e   jsr $6874
        .asc ""
        .byt $79
l9232   jsr $7263
        .asc ""
        .byt $61
l9236   ror $74
        and ($00,x)
        jmp l91bb
l923d   stx $46
        inx
        inx
        inx
        inx
        stx $47
        ldy #$39
        sty $27
        jsr $168b
l924c   jsr l924f
l924f   jsr l9255
l9252   jsr l9255
l9255   ldx $46
        stx $26
        ldx $47
        inc $27
        ldy $27
        jmp $1691

l9262   ldx zpLongitude
        ldy zpLatitude
        stx statsLongitude
        sty statsLatitude
        pha
        lda #$30
        sta $01
        ldx #$0d
        lda #$00
        sta $60
        sta $62
        lda #>mapData
        sta $61
        lda #$d0
        sta $63
        ldy #$00
l9283   lda ($60),y
        sta ($62),y
        iny
        bne l9283
l928a   inc $61
        inc $63
        dex
        bne l9283

l9291   lda #$36
        sta $01
        pla
        jmp $8c60

cast
l9299   jsr $8717
l929c   ldx $81ee
        bne l92a4
l92a1   jmp l93ba
l92a4   lda $8208,x
        bne l92cb
l92a9   jsr print
l92ac   ror $6f59,x
        adc $27,x
        ror $65,x
        jsr $7375
l92b6   adc $64
        jsr $7075
l92bb   jsr $6874
l92be   adc ($74,x)
        jsr $7073
l92c3   adc $6c
        jmp ($0021)
l92c8   jmp $8766
l92cb   cpx #$03
        beq l92f9
l92cf   cpx #$0a
        beq l92f9
l92d3   dec $8208,x
        jsr print
        .aasc $7e,"Failed, dungeon spell only!",$00
        jmp $8766
l92f9   jsr l8df6
l92fc   bcc l9301
l92fe   jmp _mainLoopOutdoors
l9301   lda #$0a
        jsr $1685
l9306   ldx $81ee
        dec $8208,x
        cpx #$0a
        ldx #$00
        bcc l9313
l9312   inx
l9313   jsr printFromTable
        .word $9394
        ldx #$03
        stx la145
        dex
        cpx statsClass
        beq l934f
l9323   lda #$80
        clc
        adc statsWisdom
        sta $43
        jsr randomNumber
l932e   cmp $43
        bcc l934f
l9332   jsr print
        .aasc "Failed!",$00
l933d   jsr $8766
l9340   jmp _mainLoopOutdoors
l9343   jsr print
        .aasc "Miss!",$00
        jmp l933d
l934f   jsr l8e3f
l9352   bcs l9343
l9354   lda #$5c
        sta ($4c),y
        jsr $166a
l935b   jsr l9c77
l935e   lda $830c,x
        sta ($4c),y
        lda $81ee
        cmp #$03
        beq l936f
l936a   lda #$ff
        jmp l8f0f
l936f   lda $8247
        jsr $85c9
l9375   inc $43
        lda $43
        ldx statsWeapon
        cpx #$08
        bcc l9391
l9380   cpx #$0c
        bcs l9391
l9384   asl
        cpx #$09
        beq l9391
l9389   clc
        adc $43
        cpx #$08
        bne l9391
l9390   lsr
l9391   jmp l8f0f

l9394
        .aasc $7e,$22,"DELCIO-ERE-UI!",$22,$a0,
        .aasc $7e,$22,"INTERFICIO-NUNC!",$22,$a0

l93ba   jsr print
        .aasc $7e,$22,"POTENTIS-LAUDIS!",$22,$00
l93d1   lda #$0a
        jsr $1685
l93d6   ldy #$0f
        lda statsHp+1
        bne l93f4
l93dd   cpy statsHp
        bcc l93f4
l93e2   beq l93f4
l93e4   sty statsHp
l93e7   jsr print
l93ea   jsr $6853
l93ed   adc ($7a,x)
        adc ($6d,x)
        and ($00,x)
        rts
l93f4   lda statsFood+1
        bne l9405
l93f9   cpy statsFood
        bcc l9405
l93fe   beq l9405
l9400   sty statsFood
        bne l93e7
l9405   jsr randomNumber
l9408   and #$03
        bne l9427
l940c   jsr l8fff
l940f   l9410 = * + 1
; Instruction parameter jumped to.
        bcs l9427
l9411   l9412 = * + 1
; Instruction parameter jumped to.
        jsr print
l9414   l9415 = * + 1
; Instruction parameter jumped to.
        ror $6f4d,x
l9417   ror $7473
        adc $72
        jsr $6572
l941f   adc $766f
        adc $64
        and ($00,x)
        rts
l9427   jmp $874e
l942a   lda la143
        cmp #$35
        bcs l943c
l9431   jsr getMapTile
l9434   cmp #$03
        bcs l943c
l9438   inc la143
        rts
l943c   lda #$ff
        rts
l943f   jmp $876a

enter
l9442   ldx zpLongitude
        ldy zpLatitude
        stx statsLongitude
        sty statsLatitude
        jsr _getStoreMapTile
l944f   cmp #TILE_CASTLE
        bcc l943f
l9453   cmp #TILE_DUNGEON+1
        bcs l943f
l9457   jsr print
        .aasc "ing...",$00
        jsr _informAndSearch
l9464   lda la142               ; current map tile (?)
        cmp #TILE_SIGN
        bne l9479
l946b   lda statsLocation
        ldx #$07
l9470   cmp la119,x
        beq l94be
l9475   dex
        bpl l9470
l9478   rts

l9479   cmp #TILE_CASTLE
        bne l9486
l947d   lda #$01
        sta $1637
        lda #$04                ; file ID: 4+4 (CA)
        bne l94bb

l9486   cmp #TILE_TOWN
        bne l94b9
l948a   jsr l9916
l948d   ldx zpLongitude
        ldy zpLatitude
        dey
        jsr l942a
l9495   sta $8226
        iny
        dex
        jsr l942a
l949d   sta $8227
        inx
        inx
        jsr l942a
l94a5   sta $8228
        dex
        iny
        jsr l942a
l94ad   sta $8229
        lda #$01
        sta $1637
        lda #$03                ; file ID: 4+3 (TW)
        bne l94bb
l94b9   lda #$02                ; file ID: 4+2 (DN)
l94bb   jmp l9262

l94be   stx la141
        jsr $8788
l94c4   ldx la141
        jsr printFromTable
l94ca   cpx $209e
        ora ($87,x)
        jsr $8777
l94d2   ldx la141
        ldy la129,x
        bmi l9503
l94da   lda $821e,y
        beq l9503
l94df   bmi l9503
l94e1   lda #$ff
        sta $821e,y
        jsr print
        .aasc $7d,"A Quest is completed!",$00
        jsr l95b9
l9503   ldx la141
        lda la121,x
        bne l9568
l950b   cpx #$04
        bne l955c
l950f   cpx $8263
        beq l9520
l9514   ldx #$00
l9516   inx
        lda invWeapons,x
        beq l9526
l951c   cpx #$0f
        bcc l9516
l9520   jsr $874e
l9523   jmp l955c
l9526   lda #$01
        sta invWeapons,x
        stx $46
        jsr print
l9530   ror $6f59,x
        adc $20,x
        ror $69
        ror $2064
        adc ($00,x)
        ldx $46
        cpx #$03
        beq l9546
l9542   cpx #$08
        bne l954b
l9546   lda #$6e                ; 'n'
        jsr printChar
l954b   inc zpCursorCol
        ldx $46
        jsr printFromTable
        .asc ""
        .byt $7c,$77
l9554   lda #$21                ; '!'
        jsr printChar
l9559   jsr l95b9
l955c   lda la141
        sta $8263
        jmp $85e1
l9565   jmp l9520
l9568   cpx $8263
        beq l9565
l956d   sta $46
        asl
        tax
        lda statsHp,x
        sta $47
        sec
        lda #$63
        sbc statsHp,x
        bcc l9565
l957e   adc #$08
        jsr $85bf
l9583   adc statsHp,x
        cmp #$63
        bcc l958c
l958a   lda #$63
l958c   sta statsHp,x
        sec
        sbc $47
        beq l9565
l9594   pha
        jsr print
        .asc ""
        .byt $7d,$54,$68,$6f,$75
l959d   jsr $6f64
        .asc ""
        .byt $73,$74
l95a2   jsr $6167
l95a5   adc #$6e
        jsr $6800
l95aa   jsr printDigit
l95ad   inc zpCursorCol
        ldx $46
        jsr printFromTable
        .asc ""
        .byt $42
l95b5   sei
        jmp l9559

l95b9   lda #$10
        jsr $87a1
l95be   lda #$0a
        jsr playSoundEffect
l95c3   jsr l95c9
l95c6   jsr $879f
l95c9   lda #$e6
        jmp $16a0

fire
l95ce   ldx statsTransport
        cpx #TRANSPORT_FRIGATE
        bne _fireJ1
        jsr print
        .aasc "cannons",$00
        jmp _fireJ3
_fireJ1
        cpx #TRANSPORT_AIRCAR
        beq _fireJ2
        jsr print
        .aasc "what",$00
        jmp $876a
_fireJ2
        jsr print
        .aasc "lasers",$00

_fireJ3
        jsr l8df6
        bcc l960d
        rts
l9602   jsr print
        .aasc $7e,"Miss!",$00
        rts
l960d   lda #$0c
        jsr $1685
l9612   lda #$03
        sta la145
        jsr l8e3f
l961a   bcs l9602
l961c   lda #$5e
        sta ($4c),y
        jsr $166a
l9623   jsr l9c77
l9626   lda $830c,x
        sta ($4c),y
        jsr randomNumber
l962e   cmp #$33
        bcs l9640
l9632   jsr print
        .aasc $7e,"Missed",$00
l963d   jmp l8fe7
l9640   ldx statsTransport
        lda l9a05,x
        jsr $85c9
l9649   adc #$1e
        jmp l8f0f

quit
l964e   ldx zpLongitude
        ldy zpLatitude
        stx statsLongitude
        sty statsLatitude
        jsr $870c
_quitL1
l965b   jsr savePlayer
l965e   jsr $8175
        bcs _quitL1
        jsr print
        .aasc " saved.",$00
        jmp $164f

ready
l9671   jsr l8dd0
l9674   jmp $87d0

xit
l9677   lda statsTransport      ; on foot?
        bne _xitJ1              ; no ->
        jsr print
        .aasc " what",$00
        jmp $876a
_xitJ1
        jsr _getStoreMapTile
l968b   cmp #$03
        bcc l96b6
l968f   jsr $83f6
        jsr print
        .aasc "Thou canst not leave it here!",$00
        jmp $8772
l96b6   ldx zpLongitude
        ldy zpLatitude
        lda statsTransport
        cmp #TRANSPORT_PHANTOM
        bcc l96c3
        lda #$07                ; time capsule - 8
l96c3   ora #TILE_PLAYER
        jsr l9ca6
l96c8   bcs l968f
        lda #TRANSPORT_FOOT
        sta statsTransport
        rts

_getPosition
l96d0   ldx zpLongitude
        ldy zpLatitude
        clc
        rts

north
l96d6   jsr _getPosition
        dey
        bcc l96ec

south
l96dc   jsr _getPosition
        iny
        bcc l96ec

east
l96e2   jsr _getPosition
        inx
        bcc l96ec

west
l96e8   jsr _getPosition
        dex

l96ec   jsr $83f6               ; set cursor column = 1
l96ef   stx $2c
        sty $2d
        lda statsTransport
        cmp #TRANSPORT_SHUTTLE  ; transport < Shuttle?
        bcc l9716               ; yes ->
        jsr print
        .aasc "Can't travel on land!",$00
        jmp l9752
l9716   jsr getMapTile
l9719   tax
        bne l9725               ; water? no ->
l971c   lda statsTransport
        cmp #$03
        bcs l9795
l9723   bcc l974d
l9725   ldx #$01
        cmp #$03
        beq l974d
l972b   cmp #$10
        bcs l9757
l972f   inx
        cmp #$02
        bne l973b
l9734   lda statsTransport
        cmp #TRANSPORT_AIRCAR
        beq l974d
l973b   ldx statsTransport
        cpx #TRANSPORT_RAFT
        beq l9746
        cpx #TRANSPORT_FRIGATE
        bne l9795
l9746   jsr printFromTableCap
l9749   bmi l97c4
l974b   ldx #$03
l974d   jsr printFromTable
l9750   sta $9e,x
l9752   lda #$0e
        jmp $8774

l9757   pha
        jsr print
        .aasc "Blocked by a",$00
l9768   pla
        sec
        sbc #$04
        lsr
        tax
        cpx #$0e
        beq l977a
l9772   cpx #$10
        beq l977a
l9776   cpx #$13
        bne l977f
l977a   lda #$6e                ; 'n'
        jsr printChar
l977f   inc zpCursorCol
        cpx #$14
        bne l9788
l9785   jsr $83f3
l9788   jsr printFromTable
        .byt $7f,$7a
l978d   lda #$21                ; '!'
        jsr printChar
l9792   jmp l9752
l9795   ldx $2c
        ldy $2d
        stx zpLongitude
        sty zpLatitude
        jsr _checkLeaveContinent
        ldx statsTransport
        bne l97aa
l97a5   jsr $8678
l97a8   ldx #$00
l97aa   ldy l97bd,x
        lda l97c7,x
        ldx statsTransport
        cpx #TRANSPORT_RAFT
        bcs l97ba
l97b7   jmp $863c
l97ba   jmp $863a


l97bd   bvc $9802
l97bf   rol $29,x
        and ($14,x)
        l97c4 = * + 1
        l97c7 = * + 4
        .byt $07,$00,$00,$00,$00,$86,$71,$57,$43,$29,$14,$00,$00,$00,$00
l97d2   lda #$00
        sta $3f
l97d6   jsr l9d44
l97d9   beq l97df
l97db   dec $3f
        bne l97d6
l97df   rts

l97e0   lda #$00
        sta $3f
l97e4   jsr l9d44
l97e7   beq l97f1
l97e9   cmp #$08
        bcs l97f1
l97ed   cmp #$03
        bne l97f5
l97f1   dec $3f
        bne l97e4
l97f5   rts

_checkLeaveContinent
l97f6   lda zpLongitude
        bmi _checkLCWest
        cmp #$4a
        bcc _checkLCLatitude
        bcs _leaveContinentEast
_checkLCWest
        cmp #$f6
        bcs _checkLCLatitude
        bcc _leaveContinentWest
_checkLCLatitude
        lda zpLatitude
        bmi _checkLCNorth
        cmp #$4a
        bcc l9814
        bcs _leaveContinentSouth
_checkLCNorth
        cmp #$f6
        bcc _leaveContinentNorth
l9814   rts                     ; stay on current map

_leaveContinentEast
        inc statsContinent
        lda #$f6
        sta zpLongitude
        bne l983d
_leaveContinentWest
        dec statsContinent
        lda #$48
        sta zpLongitude
        bne l983d
_leaveContinentSouth
        dec statsContinent
        dec statsContinent
        lda #$fb
        sta zpLatitude
        bne l983d
_leaveContinentNorth
        inc statsContinent
        inc statsContinent
        lda #$43
        sta zpLatitude

l983d   jsr l9a10

_unpackMap
l9840   lda statsContinent
        and #$03                ; keep continent in range 0..3
        sta statsContinent
        asl                     ; as 16 bit index
        tax

        lda mapData,x           ; map data offset for continent x, lb
        adc #<mapData
        sta $36
        lda mapData+1,x         ; map data offset for continent x, hb
        adc #>mapData
        sta $37                 ; map data source pointer for continent X
        lda #<mapBuffer
        sta $38
        lda #>mapBuffer
        sta $39
        ldy #$00
_unpackMapL1
        lda ($36),y             ; read source byte (RLE packed)
        beq l9882               ; byte is zero ->
        lsr
        lsr                     ; get upper five bits
        lsr
        tax                     ; # of repeated bytes
        lda ($36),y
        and #$07                ; get lower three bits = tile
        asl                     ; tile = value * 2
_unpackMapL2
        sta ($38),y             ; store in mapBuffer
        inc $38                 ; inc map pointer
        bne _unpackMapJ1
        inc $39
_unpackMapJ1
        dex
        bne _unpackMapL2
        inc $36                 ; inc source pointer
        bne _unpackMapL1
        inc $37
        bne _unpackMapL1

l9882   lda statsContinent
        lsr
        ror
        ror
        sta statsContinentMsb
        ldx $826b
        beq l98ab
l9890   dex
        lda $82bc,x
        and #$c0                ; mask continent bits
        cmp statsContinentMsb   ; current continent?
        bne l98a8               ; no ->
        jsr _getObjectMapPtr
        lda (zpMapPtr),y        ; read map tile at object location
        sta $835c,x             ; store in object background slot
        lda $830c,x             ; read object tile
        sta (zpMapPtr),y        ; store in map
l98a8   txa
        bne l9890
l98ab   stx $3f
        ldx zpLongitude
        ldy zpLatitude
        dey
        lda $8226
        jsr l9c90
l98b8   ldx zpLongitude
        ldy zpLatitude
        dex
        lda $8227
        jsr l9c90
l98c3   ldx zpLongitude
        ldy zpLatitude
        inx
        lda $8228
        jsr l9c90
l98ce   ldx zpLongitude
        ldy zpLatitude
        iny
        lda $8229
        jsr l9c90
l98d9   ldx #$03
        lda #$ff
l98dd   sta $8226,x
        dex
        bpl l98dd
l98e3   jsr l9916
l98e6   lda $822a
        beq l9910
l98eb   lda $821d
        cmp #$07
        bcs l9910
l98f2   jsr randomNumber
l98f5   and #$07
        tay
        iny
        jsr randomNumber
l98fc   and #$07
        tax
        inx
        jsr getMapTile
l9903   cmp #$02
        beq l990b
l9907   dec $3f
        bne l98f2
l990b   lda #$0f
        jsr l9ca6
l9910   lda #$00
        sta $822a
        rts
l9916   lda #$00
        ldx #$0a
l991a   sta $8213,x
        dex
        bne l991a
l9920   sta la143
        ldx statsTransport
        beq l992e
l9928   inc $8213,x
        inc la143
l992e   ldy $826b
        beq l9950
l9933   dey
        lda $830c,y
        cmp #$20
        bcs l994d
l993b   cmp #$12
        bcc l994d
l993f   inc la143
        lsr
        cmp #$0f
        bcc l9949
l9947   lda #$12
l9949   tax
        inc $820b,x
l994d   tya
        bne l9933
l9950   rts
l9951   lda $826b
        cmp #$41
        bcs l9987
l9958   jsr randomNumber
l995b   cmp #$0c
        bcc l996a
l995f   and #$3f
        cmp statsXp+1
        bcs l9987
l9966   and #$07
        bne l9987
l996a   sta $36
        jsr randomNumber
l996f   and #$07
        beq l9987
l9973   asl
        sta $22
l9976   lda #$0f
        jsr $85c9
l997b   tax
        lda $7a57,x
        cmp $22
        bcc l9988
l9983   dec $36
        bne l9976
l9987   rts
l9988   ldy #$00
        cpx #$04
        bcc l9996
l998e   ldy #$02
        cpx #$09
        bcc l9996
l9994   ldy #$01
l9996   sty $23
        stx $8267
        txa
        asl
        adc #$10
        sta $22
        lda zpLongitude
        sbc #$09
        bpl l99a9
l99a7   lda #$00
l99a9   sta $26
        lda zpLongitude
        adc #$09
        sta $28
        lda zpLatitude
        sbc #$04
        bpl l99b9
l99b7   lda #$00
l99b9   sta $27
        lda zpLatitude
        adc #$04
        sta $29
l99c1   jsr l9d44
l99c4   cmp $23
        bne l99c1
l99c8   cpx $26
        bcc l99dd
l99cc   cpx $28
        bcs l99dd
l99d0   cpy $27
        bcc l99dd
l99d4   cpy $29
        bcs l99dd
l99d8   dec $3a
        bne l99c1
l99dc   rts
l99dd   lda $22
        jsr l9ca6
l99e2   bcs l9a04
l99e4   lda statsXp+1
        ldx $8267
        ldy $7a57,x
        adc l9a05,y
        lsr
        cmp #$05
        bcc l99fe
l99f5   pha
        jsr $85c9
l99f9   pla
        sec
        adc $43
        ror
l99fe   ldx $826b
        sta $bcff,x
l9a04   rts
l9a05   .byt $00,$0a,$14,$1e,$28,$32,$3c,$46
l9a0d   bvc l9a69
        .asc ""
        .byt $64

l9a10   ldx $826b
        beq l9a27
l9a15   dex
        lda $830c,x
        cmp #$20
        bcc l9a24
l9a1d   cmp #$5a
        bcs l9a24
l9a21   jsr l9cfc
l9a24   txa
        bne l9a15
l9a27   stx $8267
        dex
        stx $bd00
        rts
l9a2f   jsr l9951
l9a32   ldx $826b
        beq l9a4c
l9a37   dex
        stx $44
        lda $830c,x
        cmp #$20
        bcc l9a48
l9a41   cmp #$5a
        bcs l9a48
l9a45   jsr l9b3e
l9a48   ldx $44
        bne l9a37
l9a4c   rts
l9a4d   .byt $00,$80
        .asc "*"
        .byt $00,$80
l9a52   cpy #$e6
        inc $e6
        inc $e6
l9a58   jsr randomNumber
l9a5b   ldx statsTransport
        cmp l9a4d,x
        bcc l9a4c
l9a63   ldx $44
        lda $830c,x
        l9a69 = * + 1
        ldy #$00
        cmp #$30
        bcc l9a7a
l9a6e   ldy #$01
        cmp #$38
        beq l9a78
l9a74   cmp #$40
        bne l9a7a
l9a78   ldy #$02
l9a7a   sty la144
        lda #$00
        sta $24
        sta $25
        lda $826c,x
        sta $22
        lda zpLongitude
        bmi l9a96
l9a8c   cmp $22
        bcc l9a96
l9a90   beq l9a98
l9a92   inc $24
        bcs l9a98
l9a96   dec $24
l9a98   lda $82bc,x
        and #$3f
        sta $23
        lda zpLatitude
        bmi l9aad
l9aa3   cmp $23
        bcc l9aad
l9aa7   beq l9aaf
l9aa9   inc $25
        bcs l9aaf
l9aad   dec $25
l9aaf   jsr randomNumber
l9ab2   bmi l9ab9
l9ab4   jsr l9aee
l9ab7   bcc l9acb
l9ab9   ldx $22
        lda $23
        clc
        adc $25
        tay
        jsr l9af6
l9ac4   bcc l9acb
l9ac6   jsr l9aee
l9ac9   bcs l9aed
l9acb   jsr l9c77
l9ace   lda $835c,x
        sta ($4c),y
        lda $2c
        sta $826c,x
        lda $2d
        ora statsContinentMsb
        sta $82bc,x
        jsr _getObjectMapPtr
l9ae3   lda ($4c),y
        sta $835c,x
        lda $830c,x
        sta ($4c),y
l9aed   rts
l9aee   ldy $23
        lda $22
        clc
        adc $24
        tax
l9af6   cpx #$40
        bcs l9b23
l9afa   cpy #$40
        bcs l9b23
l9afe   cpx zpLongitude
        bne l9b06
l9b02   cpy zpLatitude
        beq l9b23
l9b06   jsr getMapTile
l9b09   cmp #$08
        bcs l9b13
l9b0d   cmp #$04
        bcc l9b13
l9b11   lda #$01
l9b13   cmp la144
        beq l9b25
l9b18   cmp #$02
        bne l9b23
l9b1c   lda la144
        cmp #$01
        beq l9b25
l9b23   sec
        rts
l9b25   stx $2c
        sty $2d
        clc
        rts
l9b2b   tay
        beq l9b3d
l9b2e   bmi l9b33
l9b30   ldy #$01
        rts
l9b33   ldy #$ff
        sta l9b3c
        lda #$00
        sec
        l9b3c = * + 1
        sbc #$00
l9b3d   rts
l9b3e   ldx $44
        lda $826c,x
        sta $22
        sec
        sbc zpLongitude
        jsr l9b2b
l9b4b   sty $48
        sta $24
        lda $82bc,x
        and #$3f
        sta $23
        sec
        sbc zpLatitude
        jsr l9b2b
l9b5c   sty $49
        sta $25
        tay
        lda $24
        beq l9b70
l9b65   cpy #$00
        beq l9b6f
l9b69   cpy $24
        bne l9b8b
l9b6d   iny
        l9b6f = * + 1
; Instruction parameter jumped to.
        cmp #$a8
l9b70   cpy #$02
        bcc l9baf
l9b74   cpy #$04
        bcs l9b8b
l9b78   lda $830c,x
        cmp #$28
        beq l9b8e
l9b7f   cmp #$2c
        beq l9b8e
l9b83   cmp #$38
        beq l9b8e
l9b87   cmp #$58
        beq l9b8e
l9b8b   jmp l9a58
l9b8e   lda #$02
        sta la145
l9b93   sec
        lda $22
        sbc $48
        tax
        sec
        lda $23
        sbc $49
        tay
        stx $22
        sty $23
        jsr getMapTile
l9ba6   cmp #$03
        beq l9b8b
l9baa   dec la145
        bne l9b93
l9baf   jsr $83ed
l9bb2   ldx $44
        stx $8268
        lda $830c,x
        lsr
        lsr
        adc #$fe
        sta $8267
        tax
        jsr printFromTableCap
        .byt $7f,$7a
l9bc7   jsr print
l9bca   jsr $7461
        .asc ""
        .byt $74,$61,$63,$6b,$73,$21
l9bd3   jsr $a900
        .byt $04
l9bd7   jsr $1685
l9bda   lda #$5e
        sta $1639
        jsr $166a
l9be2   lda statsStamina
        lsr
        sta $43
        lda statsArmour
        asl
        asl
        asl
        adc $43
        sta $43
        sec
        lda #$c8
        sbc $43
        sta $43
        jsr randomNumber
l9bfc   cmp $43
        bcc l9c17
l9c00   lda zpCursorCol
        cmp #$17
        bcc l9c09
l9c06   jsr $83f3
l9c09   jsr print
        .aasc "Missed!",$00
        jmp l9c71
l9c17   lda zpCursorCol
        cmp #$1a
        bcc l9c20
l9c1d   jsr $83f3
l9c20   jsr print
        .aasc "Hit! ",$00
        lda $32
l9c2b   cmp #$15
        bcc l9c32
l9c2f   jsr $83f3
l9c32   ldx $8267
        lda $7a51,x
        asl
        jsr $85c9
l9c3c   clc
        adc #$01
        sta $81c1
        jsr $8582
l9c45   jsr print
        .aasc " damage",$00
        lda statsHp
        sec
        sbc $81c1
        sta statsHp
        lda statsHp+1
        sbc #$00
        bpl l9c66
l9c61   lda #$00
        sta statsHp
l9c66   sta statsHp+1
        jsr $86c6
l9c6c   lda #$02
        jsr playSoundEffect
l9c71   jsr _printPlayerTile
l9c74   jmp $166a
l9c77   ldx $44

_getObjectMapPtr
l9c79   lda #$00
        sta zpMapPtr
        lda $82bc,x
        and #$3f
        lsr
        ror zpMapPtr
        lsr
        ror zpMapPtr
        adc #>mapBuffer
        sta zpMapPtr+1
        ldy $826c,x
        rts

l9c90   cmp #$08
        bcc l9cd7
l9c94   cmp #$10
        bcc l9ca6
l9c98   rts
l9c99   pha
        jsr l97d2
l9c9d   pla
        jmp l9ca6
l9ca1   pha
        jsr l97e0
l9ca5   pla


l9ca6   cpx #$40
        bcs l9cd7
l9caa   cpy #$40
        bcs l9cd7
l9cae   stx $46
        ldx $826b
        cpx #$50
        bcs l9cd7
l9cb7   asl                     ; object * 2
        sta $830c,x
        pha
        tya                     ; latitude
        ora statsContinentMsb   ; location?
        sta $82bc,x
        lda $46                 ; longitude
        sta $826c,x
        jsr _getObjectMapPtr    ; tile pointer?
l9ccb   lda (zpMapPtr),y        ; get map tile (background)
        sta $835c,x             ; store in object table
        pla                     ; object to drop
        sta (zpMapPtr),y        ; update tile in map
        inc $826b
        clc
l9cd7   rts

l9cd8   ldx zpLongitude
        ldy zpLatitude
        cpx #$40
        bcs l9cd7
l9ce0   cpy #$40
        bcs l9cd7
l9ce4   stx $46
        tya
        ora statsContinentMsb
        ldx $826b
l9ced   dex
        bmi l9cd7
l9cf0   cmp $82bc,x
        bne l9ced
l9cf5   ldy $826c,x
        cpy $46
        bne l9ced
l9cfc   lda $82bc,x
        and #$c0
        cmp statsContinentMsb
        bne l9d0e
l9d06   jsr _getObjectMapPtr
l9d09   lda $835c,x
        sta (zpMapPtr),y
l9d0e   lda $830c,x
        sta $3a
        stx $46
        dec $826b
        bne l9d3a
l9d1a   rts
l9d1b   lda $826d,x
        sta $826c,x
        lda $82bd,x
        sta $82bc,x
        lda $830d,x
        sta $830c,x
        lda $835d,x
        sta $835c,x
        lda $bd01,x
        sta $bd00,x
        inx
l9d3a   cpx $826b
        bcc l9d1b
l9d3f   ldx $46
        lda $3a
        rts
l9d44   jsr randomNumber
l9d47   and #$3f
        tay
        jsr randomNumber
l9d4d   and #$3f
        tax

getMapTile
l9d50   lda #$00
        cpy #$40
        bcs l9d75
l9d56   cpx #$40
        bcs l9d75
        tya
        sta l9d74               ; store y register
        lsr
        sta zpMapPtr+1
        lda #$00
        ror
        lsr zpMapPtr+1
        ror
        sta zpMapPtr
        lda zpMapPtr+1
        adc #>mapBuffer         ; map buffer at $6400
        sta zpMapPtr+1
        txa                     ; latitude as offset
        tay
        lda (zpMapPtr),y        ; read byte from map
        l9d74 = * + 1
        ldy #$00                ; restore y register
l9d75   lsr
        rts

_getStoreMapTile
l9d77   ldx zpLongitude
        ldy zpLatitude
        jsr getMapTile
        sta la142
        rts

_informAndSearch
l9d82   jsr $83ed
        jsr _getStoreMapTile
l9d88   cmp #$03
        beq l9dad
l9d8c   cmp #$08
        bcc l9daf
l9d90   lda zpLatitude
        ora statsContinentMsb
        ldx $826b
l9d98   cmp $82bb,x             ; object coordinates (?)
        bne l9daa
l9d9d   ldy $826b,x             ; object coordinates (?)
        cpy zpLongitude
        bne l9daa
l9da4   lda $835b,x             ; location id (?)
        lsr
        bpl l9daf
l9daa   dex
        bne l9d98
l9dad   lda #$01
l9daf   sta la142
        cmp #$04
        bcs l9dcb
l9db6   tax
        jsr printFromTable
        .word _textTableSearch
l9dbc   ldx la142
        dex
        bne l9dca
l9dc2   ldx statsContinent
        jsr printFromTable
        .word strTableLands
l9dca   rts

l9dcb   cmp #$06
        bne l9ddf
        jsr print
        .aasc "the city of ",$00
l9ddf
        lda statsContinentMsb
        ora zpLatitude
        ldx #$53
l9de6   cmp $7c18,x
        bne l9df2
l9deb   ldy $7c6c,x
        cpy zpLongitude
        beq l9df9
l9df2   dex
        bpl l9de6
l9df5   stx statsLocation
        rts

l9df9   stx statsLocation
        jsr printFromTable
l9dff   cpy #$7c
        rts
l9e02   ldx statsTransport
        jsr printFromTable
        .word strTableTransport

        rts

_printPlayerTile
l9e0b   lda statsTransport      ; check for allowed transport
        cmp #TRANSPORT_TIME_MACHINE+1
        bcc _printPlrTileJ1     ; transport range OK ->
        lda #TRANSPORT_FOOT
        sta statsTransport
_printPlrTileJ1
        cmp #TRANSPORT_PHANTOM  ; check for unsupported transport
        bcc _printPlrTileJ2     ; transport OK
        lda #TRANSPORT_TIME_MACHINE
        sta statsTransport
        lda #TRANSPORT_PHANTOM
_printPlrTileJ2
        ora #TILE_PLAYER
        asl                     ; convert to map tile
        sta $1639
        rts

_commandTable
l9e29   l9e2a = * + 1
        .word north             ; north
        .word south             ; south
        .word east              ; east
        .word west              ; west
        .word pass              ; pass
        .word attack            ; attack
        .word board             ; board
        .word cast              ; cast
        .word $876a             ; drop
        .word enter             ; enter
        .word fire              ; fire
        .word $876a             ; get
        .word $876a             ; hyper jump
        .word _informAndSearch  ; inform & search
        .word $876a             ; klimb
        .word $8bb9             ; noise
        .word $876a             ; open
        .word quit              ; quit (and save to disk)
        .word ready             ; ready
        .word $876a             ; steal
        .word $876a             ; transact
        .word $876a             ; unlock
        .word $876a             ; view change
        .word xit               ; x-it
        .word $890c             ; ztats

_textTableSearch
l9e5b
        .aasc "You are at se",$e1
        .aasc "You are in the lands",$7e,"of",$a0
        .aasc "You are in the wood",$f3
        .aasc "You can't walk on water",$a1
        .aasc "Mountains are impassable",$a1
        .aasc "Aircars can't pass woods",$a1
        .aasc "s like water",$a1
        .aasc $7e,$7e,$7e,$7f
        .aasc $07,"The sign reads:",$7e,$7e,$7f
        .aasc $04,$22,"GO EAST TO GO EAST!",$a2
        .aasc $7e,$7e,$7e,$7f
        .aasc $05,"The grave is marked:",$7e,$7e,$7f
        .aasc $09,$22,"VAE VICTIS",$a2
        .aasc $7e,$7e,$7e,$7f
        .aasc $07,"The sign reads:",$7e,$7e,$7f
        .aasc $06,$22,"OMNIA MUTANTUR!",$a2
        .aasc $7e,$7e,$7f
        .aasc $07,"The sign reads:",$7e,$7e,$7f
        .aasc $07,$22,"ULTIMA THULE!",$22,$7e,$7e,$7f
        .aasc $02,"The sky grows dark, and a",$7e,$7f
        .aasc $02,"strong magic engulfs you",$a1
        .aasc $7e,$7e,$7e,$7f
        .aasc $08,"A sign reads:",$7e,$7e,$7f
        .aasc $02,$22,"FORTES FORTUNA ADIUVAT!",$a2
        .aasc $7f
        .aasc $08,"On a pedestal,",$7e,$7f
        .aasc $05,"these words appear:",$7e,$7e,$7f
        .aasc $03,$22,"MY NAME IS OZYMANDIAS,",$7e,$7f
        .aasc $08,"KING OF KINGS:",$7e,$7f
        .aasc $06,"LOOK ON MY WORKS,",$7e,$7f
        .aasc $03,"YE MIGHTY, AND DESPAIR!",$22,$7e,$7e,$7f
        .aasc $03,"Nothing beside remains.",$7e,$7f
        .aasc $02,"You feel a strange force",$a1
        .aasc $7e,$7e,$7e,$7e,$7f
        .aasc $03,"You feel a strong magic",$7e,$7f
        .aasc $07,"surrounding you",$a1
        .aasc $7e,$7e,$7e,$7f
        .aasc $04,"You hear someone say,",$7e,$7e
        .aasc " ",$22,"TURRIS-SCIENTIA-MAGNOPERE",$a2

la119
        .aasc "BA-,"
        .byt $18,$17,$03,$02
la121
        .byt $00,$03,$04,$03,$00
        la129 = * + 3
        la131 = * + 11
        .byt $05,$02,$06,$ff,$06,$ff,$04,$ff,$02,$ff,$00,$01,$01,$01,$01,$00
        la141 = * + 11
        la142 = * + 12
        la143 = * + 13
        la144 = * + 14
        la145 = * + 15
        .byt $01,$01,$03,$00,$00,$00,$01,$03,$01,$03,$03,$00,$00
        .asc $de
        .byt $02,$4e
        .byt $06
        .asc "+"
        .byt $09,$19
