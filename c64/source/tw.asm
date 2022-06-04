#include "archdep.h"
#include "constants.h"

        .word $8c9e
        * = $8c9e

enterTown
l8c9e   lda #$d4
        sta $1632
        lda #17                 ; set longitude and latitude for town
        sta zpLatitude
        lda #19
        sta zpLongitude
        lda statsGender
        beq l8cbb
l8cb0   ldx #$05
l8cb2   lda lad5e,x
        sta lad58,x
        dex
        bpl l8cb2
l8cbb   lda #$00
        sta lad2a
        sta $81c8
        sta lad38
        lda $8262
l8cc9   cmp #$15
        bcc l8cd1
l8ccd   sbc #$15
        bne l8cc9
l8cd1   sec
        sbc #$0d
        sta l94bc
        pha
        ldx #$00
        jsr loadFile            ; load "TC",$4000
l8cdd   ldx #$01
        jsr loadFile            ; load "MA",$c700
l8ce2   pla
        asl
        tax
        lda $4004,x
        sta l8cf6
        lda $4005,x
        sta l8cf7
        ldy #$03
        ldx #$00
l8cf5   l8cf6 = * + 1
        l8cf7 = * + 2
        lda $ffff,x
        l8cfa = * + 2
; Instruction parameter accessed.
        sta $cb00,x
        dex
        bne l8cf5
l8cfe   inc l8cf7
        inc l8cfa
        dey
        bne l8cf5
l8d07   jsr la51a
l8d0a   jmp l8d51

l8d0d   jsr $1649
l8d10   lda #$0e
        jsr printChar
l8d15   jsr $86c6
l8d18   jsr l8d45
l8d1b   bne l8d3f
l8d1d   lda #$00
        sta lad29
        jsr $83f6
l8d25   lda #$20
        jsr printChar
l8d2a   jsr la273
l8d2d   jsr l8e15
l8d30   lda lad29
        bne l8d0d
l8d35   lda #23
        sta zpCursorRow
        jsr $83f6
l8d3c   jmp l8d15
l8d3f   jsr checkCommandKey
l8d42   bcs l8d0d
l8d44   rts

l8d45   ldx #$80
l8d47   jsr getKey
l8d4a   bne l8d4f
l8d4c   dex
        bne l8d47
l8d4f   tax
        rts

l8d51   lda statsHp
        ora statsHp+1
        beq l8d61               ; -> starving
l8d59   lda statsFood
        ora statsFood+1
        bne l8d67
l8d61   jsr $1649               ; dead!
l8d64   jmp $8c5b

l8d67   jsr l8d0d               ; wait for command / check command key
l8d6a   lda _commandTable,x
        sta l8d77
        lda _commandTable+1,x
        sta l8d78
        l8d77 = * + 1
        l8d78 = * + 2
        jsr $ffff
l8d79   jsr la273
l8d7c   jmp l8d51

_commandTable
l8d7f
        .word cmdTwNorth        ; north
        .word cmdTwSouth        ; south
        .word cmdTwEast         ; east
        .word cmdTwWest         ; west
        .word l8e15             ; pass
        .word l8e22             ; attack
        .word $876a             ; board
        .word l8fc3             ; cast
        .word l8fe2             ; drop
        .word $876a             ; enter
        .word $876a             ; fire
        .word $9268             ; get
        .word $876a             ; hyper jump
        .word $a4fc             ; inform & search
        .word $876a             ; klimb
        .word $8bb9             ; noise
        .word $876a             ; open
        .word cmdTwQuit         ; quit (and save to disk)
        .word l9299             ; ready
        .word l92af             ; steal
        .word l93c9             ; transact
        .word cmdTwUnlock       ; unlock
        .word $876a             ; view change
        .word $876a             ; x-it
        .word $a26d             ; ztats

cmdTwNorth
l8db1   ldx #$00
        ldy #$ff
        bne l8dc7
cmdTwSouth
l8db7   ldx #$00
        ldy #$01
        bne l8dc7
cmdTwEast
l8dbd   ldx #$01
        ldy #$00
        beq l8dc7
cmdTwWest
l8dc3   ldx #$ff
        ldy #$00
l8dc7   txa
        clc
        adc zpLongitude
        sta $2c
        tax
        tya
        clc
        adc zpLatitude
        sta $2d
        tay
        jsr la5eb
l8dd8   bcs l8dff
l8dda   lda $2c
        cmp #$26
        bcs l8de6
l8de0   lda $2d
        cmp #$12
        bcc l8de9
l8de6   jmp $8c5e
l8de9   lda #$0e
        jsr playSoundEffect
l8dee   jsr $83f6
l8df1   jsr print
        .aasc "Blocked",$00
l8dfc   jmp l8e15
l8dff   ldx zpLongitude
        ldy zpLatitude
        lda #$20
        jsr la5d3
l8e08   ldx $2c
        stx zpLongitude
        ldy $2d
        sty zpLatitude
        lda #$7b
        jsr la5d3
l8e15   ldy #$01
        lda #$10
        jsr $863c
l8e1c   jsr $1688
l8e1f   l8e20 = * + 1
; Instruction parameter accessed.
        bne l8e1c
l8e21   rts
l8e22   jsr print
        .asc ""
        .byt $77
l8e26   adc #$74
        pla
        jsr lae00
        .asc "o"
        .byt $81
l8e2e   jsr printFromTable
        .asc "l"
        .byt $77
l8e33   ldx statsWeapon
        cpx #$04
        beq l8e42
l8e3a   cpx #$08
        bcc l8e45
l8e3e   cpx #$0b
        bcs l8e45
l8e42   jmp $876a
l8e45   jsr print
        .asc ""
        .byt $3a
l8e49   jsr $2000
l8e4c   eor $8d
        beq l8e6d
l8e50   ldx #$00
        ldy #$00
        cmp #$40
        bne l8e5b
l8e58   dey
        bne l8e7a
l8e5b   cmp #$2f
        bne l8e62
l8e5f   iny
        bne l8e7a
l8e62   cmp #$3b
        bne l8e69
l8e66   inx
        bne l8e7a
l8e69   cmp #$3a
        beq l8e79
l8e6d   jsr print
        .asc ""
        .byt $4e,$6f,$74,$68,$69
l8e75   ror !$0067
        rts
l8e79   dex
l8e7a   stx $24
        sty $25
        jsr checkCommandKey
l8e81   jsr $83ed
l8e84   ldx statsWeapon
        lda lad88,x
        sta lad2d
        lda zpLongitude
        sta $2c
        lda zpLatitude
        sta $2d
l8e95   lda $2c
        clc
        adc $24
        sta $2c
        tax
        lda $2d
        clc
        adc $25
        sta $2d
        tay
        jsr la5eb
l8ea8   php
        cmp #$16
        bcc l8ebd
l8ead   plp
        php
        bcs l8ebd
l8eb1   plp
        cmp #$30
        bcc l8ec3
l8eb6   cmp #$36
        bcs l8ec3
l8eba   jmp l8ed4
l8ebd   plp
        dec lad2d
        bne l8e95
l8ec3   lda #$06
        jsr playSoundEffect
l8ec8   jsr print
        .asc ""
        .byt $4d,$69,$73,$73
l8ecf   adc $64
        and ($00,x)
        rts
l8ed4   sec
        sbc #$30
        sta zpMapPtr
        ldx zpMapPtr
        lda #$80
        clc
        adc statsAgility
        sta $4d
        jsr randomNumber
l8ee6   cmp $4d
        bcs l8ec3
l8eea   lda #$01
        sta lad2a
        lda #$06
        jsr playSoundEffect
l8ef4   jsr print
l8ef7   pha
        adc #$74
        jsr la600
l8efd   jmp $2d20
l8f00   sty $39
        lda l8e20
        sty zpLatitude
        jsr $ad00
l8f0a   and $1882,x
        adc statsWeapon
        adc statsWeapon
        adc statsWeapon
        sta $4d
l8f18   jsr randomNumber
l8f1b   cmp #$00
        beq l8f18
l8f1f   cmp $4d
        bcs l8f18
l8f23   sta $4d
        lda #$02
        jsr playSoundEffect
l8f2a   ldx lad2e
        lda $cddc,x
        sec
        sbc $4d
        sta $cddc,x
        lda $cdec,x
        sbc #$00
        sta $cdec,x
        bcc l8f56
l8f40   lda $4d
        ldx #$00
        stx $85be
        jsr $8582
l8f4a   jsr print
l8f4d   jsr $6164
l8f50   adc $6761
        adc $00
        rts
l8f56   lda #$ff
        sta $cdac,x
        sta $cdbc,x
        sta $cdcc,x
        sta $cdec,x
        jsr print
        .asc ""
        .byt $4b
l8f68   adc #$6c
        jmp ($6465)
l8f6d   and ($00,x)
        lda zpMapPtr
        cmp #$04
        bne l8f7c
l8f75   lda #$01
        ldx #$00
        jmp l8f96
l8f7c   cmp #$05
        bne l8f87
l8f80   lda #$02
        ldx #$00
        jmp l8f96
l8f87   cmp #$01
        bne l8f92
l8f8b   lda #$01
        ldx #$00
        jmp l8f96
l8f92   lda #$0f
        ldx #$00
l8f96   clc
        adc $825c
        sta $825c
        txa
        adc $825d
        sta $825d
        lda $825c
        cmp #<9999
        lda $825d
        sbc #>9999
        bcc l8fba
l8fb0   lda #<9999
        sta $825c
        lda #>9999
        sta $825d
l8fba   ldx $2c
        ldy $2d
        lda #$20
        jmp la5d3
l8fc3   jsr print
        .aasc "-- Hmmmm... no effect?",$00
l8fdd   lda #$08
        jmp playSoundEffect
l8fe2   jsr print
        .aasc " Pence,Weapon,Armour: ",$00
        jsr $8d45
        ldx #$06
        stx zpCursorCol
        ldx #$03
l9005   cmp l9022,x
        beq l900d
l900a   dex
        bne l9005
l900d   txa
        asl
        tay
        lda l9027,y
        pha
        lda l9026,y
        pha
        jsr printFromTable
        .word $9187
l901d   jsr $164f
l9020   inc zpCursorCol
l9022   rts
l9023   bvc l907c
l9025   l9026 = * + 1
        eor (zpLatitude,x)
l9027   bcc l9056
l9029   bcc l904d
        .byt $91,$3d,$91
l902e   jsr print
        .asc ""
        .byt $7e,$48,$6f,$77
l9035   jsr $756d
        .asc ""
        .byt $63,$68,$3f
l903b   jsr $2000
l903e   adc $a6,x
        lda $ae60
        ora $ae61
        bne l9049
l9048   rts
l9049   lda statsCoin
        l904d = * + 1
; Instruction parameter jumped to.
        cmp $ae60
        lda statsCoin+1
        sbc $ae61
        l9056 = * + 1
; Instruction parameter jumped to.
        bcs l9077
l9057   jsr print
        .asc ""
        .byt $7e,$54,$68,$6f
l905e   adc zpLongitude,x
l9060   pla
        adc ($73,x)
        .asc ""
        .byt $74
l9064   jsr $6f6e
        .asc ""
        .byt $74
l9068   jsr $6874
l906b   adc ($74,x)
        jsr $756d
        .asc ""
        .byt $63
l9071   pla
        and ($00,x)
        jmp $8772
l9077   lda statsCoin
        sec
        l907c = * + 1
; Instruction parameter jumped to.
        sbc $ae60
        sta statsCoin
        lda statsCoin+1
        sbc $ae61
        sta statsCoin+1
        ldx zpLongitude
        ldy zpLatitude
        jsr la604
l9091   cmp #$61
        beq l909e
l9095   jsr print
l9098   ror $6b4f,x
        and ($00,x)
        rts
l909e   lda $ae60
        sta zpMapPtr
        lda $ae61
        lsr
        sta $4d
        ror zpMapPtr
        lda zpMapPtr
        clc
        adc $ae60
        sta zpMapPtr
        lda $4d
        adc $ae61
        sta $4d
        lda statsHp
        clc
        adc zpMapPtr
        sta statsHp
        lda statsHp+1
        adc $4d
        sta statsHp+1
        lda statsHp
        cmp #<9999
        lda statsHp+1
        sbc #>9999
        bcc l90e1
l90d7   lda #<9999
        sta statsHp
        lda #>9999
        sta statsHp+1
l90e1   jsr randomNumber
l90e4   cmp #$10
        bcc l90f9
l90e8   jsr print
l90eb   ror $6853,x
        adc ($7a,x)
        adc ($6d,x)
        and ($00,x)
        lda #$0a
        jmp playSoundEffect
l90f9   jsr randomNumber
l90fc   and #$0f
        cmp #$08
        bcs l90f9
l9102   cmp #$03
        beq l90f9
l9106   tax
        inx
        inc invSpells,x
        bne l9110
l910d   dec invSpells,x
l9110   jsr print
        .asc ""
        .byt $7e,$41
l9115   jmp ($6b61)
        .asc ""
        .byt $61,$7a,$6f,$74
l911c   and ($00,x)
        lda #$0a
        jmp playSoundEffect
l9123   jsr l91a1
        .byt $0f
        .asc "x"
        .byt $81,$7c,$77
l912b   bmi l913b
l912d   tax
        lda #$00
        sta invWeapons,x
        cpx statsWeapon
        bne l913b
l9138   sta statsWeapon
l913b   jmp la51a
l913e   jsr l91a1
l9141   ora $f2
        sta ($d4,x)
        sei
        bmi l913b
l9148   tax
        lda #$00
        sta invArmour,x
        cpx statsArmour
        bne l913b
l9153   sta statsArmour
        jmp la51a
l9159   lda statsFood
        cmp #<9999
        lda statsFood+1
        sbc #>9999
        bcc l916f
l9165   lda #<9999
        sta statsFood
        lda #>9999
        sta statsFood+1
l916f   rts
l9170   lda statsCoin
        cmp #<9999
        lda statsCoin+1
        sbc #>9999
        bcc l9186
l917c   lda #<9999
        sta statsCoin
        lda #>9999
        sta statsCoin+1
l9186   rts

l9187
        .aasc "nothin",$e7
        .aasc "penc",$e5
        .aasc "weapon",$ba
        .aasc "armour",$ba

l91a1   pla
        sta $83b5
        pla
        sta $83b6
        jsr $83ac
l91ac   sta l9267
        jsr $83ac
l91b2   sta $41
        jsr $83ac
l91b7   sta $42
        jsr $83ac
l91bc   sta l9263
        jsr $83ac
l91c2   sta l9264
        lda $83b6
        pha
        lda $83b5
        pha
        ldy l9267
        ldx #$00
l91d2   lda ($41),y
        beq l91d7
l91d6   inx
l91d7   dey
        bne l91d2
l91da   stx $43
        cpx #$00
        bne l91e5
l91e0   pla
        pla
        jmp l9250
l91e5   jsr $870c
l91e8   jsr $165e
l91eb   ldx #$0f
        ldy #$00
        jsr printAtPos
        .aasc $0e," Drop ",$18,$00
l91fb   jsr $1652
l91fe   sec
        lda #20
        sbc $43
        lsr
        sta zpCursorRow
        lda #$61
        sta l9218
        ldy #$00
        beq l9223
l920f   tya
        pha
        lda #$0d
        sta zpCursorCol
        jsr print
l9218   l9219 = * + 1
; Instruction opcode accessed.
; Instruction parameter jumped to.
        adc ($29,x)
l921a   jsr $6800
l921d   jsr l925e
l9220   tay
        inc zpCursorRow
l9223   cpy l9267
        bcs l9232
l9228   inc l9218
        iny
        lda ($41),y
        bne l920f
l9230   beq l9223
l9232   jsr $8701
l9235   jsr readKey
l9238   pha
        jsr $8ad6
l923c   sec
        pla
        sbc #$41
        beq l9250
l9242   bmi l9250
l9244   cmp l9267
        bcc l924b
l9249   bne l9250
l924b   tay
        lda ($41),y
        bne l925d
l9250   ldy #$ff
        jsr print
l9255   ror $6e6f
        adc $00
        tya
        tax
        rts
l925d   tya
l925e   tax
        pha
        jsr printFromTableCap
l9263   l9264 = * + 1
        .byt $00,$00
l9265   pla
        rts
l9267   .byt $0a
l9268   jsr print
l926b   jsr $6877
        .asc ""
        .byt $61,$74,$00
l9271   jmp $876a

cmdTwQuit
l9274   lda #18
        sta zpCursorCol
        jsr print
        .aasc " is",$7e
        .aasc "only allowed outdoors!",$00
        jmp $8772

l9299   jsr l8d45
l929c   cmp #$53
        beq l92a9
l92a0   cmp #$57
        beq l92a9
l92a4   cmp #$41
        beq l92a9
l92a8   rts
l92a9   jsr $87d0
l92ac   jmp la51a
l92af   ldx zpLongitude
        ldy zpLatitude
        jsr la604
l92b6   cmp #$65
        beq l92d6
l92ba   cmp #$67
        beq l92d6
l92be   cmp #$69
        beq l92d6
l92c2   jsr print
        .asc ""
        .byt $7e,$4e,$6f,$74,$68,$69
l92cb   ror $2067
        pla
        adc $72
        adc $00
        jmp $876a
l92d6   sta zpMapPtr
        jsr randomNumber
l92db   cmp #$26
        bcc l92ef
l92df   ldy lad2a
        bne l92ef
l92e4   ldy statsClass
        cpy #$04
        beq l9312
l92eb   cmp #$4d
        bcs l9312
l92ef   jsr print
        .aasc $7e,"Oh no! Thou wert caught!",$00
        lda #$01
        sta lad2a
        rts
l9312   jsr print
        .aasc $7e,"Thou dost find",$7e,$00
        lda $4c
        cmp #$65
        bne l934c
l932c   jsr la718
l932f   lsr
        lsr
        lsr
        and #$07
        beq l932c
l9336   cmp #$06
        bcs l932c
l933a   tax
        inc invArmour,x
        bne l9346
l9340   dec invArmour,x
        jmp l932c
l9346   jsr printFromTable
        .word strTableArmour
        rts
l934c   cmp #$67
        bne l9388
l9350   jsr randomNumber
l9353   and #$1f
        cmp #$02
        bcc l9350
l9359   cmp #$1f
        bcs l9350
l935d   pha
        ldx #$00
        stx $85be
        jsr $8582
l9366   jsr print
        .aasc " bags of food!",$00
        pla
        clc
        adc statsFood
        sta statsFood
        bcc l9385
l9382   inc statsFood+1
l9385   jmp l9159
l9388   jsr la723
l938b   lsr
        and #$0f
        beq l9388
l9390   cmp #$0c
        bcc l939f
l9394   sta zpMapPtr
        jsr randomNumber
l9399   cmp #$30
        bcs l9388
l939d   lda zpMapPtr
l939f   pha
        lda #$61
        jsr printChar
l93a5   pla
        pha
        cmp #$03
        beq l93af
l93ab   cmp #$08
        bne l93b4
l93af   lda #$6e
        jsr printChar
l93b4   lda #$20
        jsr printChar
l93b9   pla
        tax
        inc invWeapons,x
        bne l93c3
l93c0   dec invWeapons,x
l93c3   jsr printFromTable
        .word strTableLongWeapons
        rts
l93c9   lda lad2a
        beq l93eb
l93ce   jsr print
        .asc ""
        .byt $7e,$4e,$6f,$6e,$65
l93d6   jsr $6977
l93d9   jmp ($206c)
        .asc ""
        .byt $74,$61
l93de   jmp ($206b)
        .asc ""
        .byt $74,$6f
l93e3   jsr $6874
l93e6   adc $65
        and ($00,x)
        rts
l93eb   ldx zpLongitude
        ldy zpLatitude
        jsr la604
l93f2   cmp #$64
        bcc l9406
l93f6   cmp #$6d
        bcs l9406
l93fa   sec
        sbc #$64
        tax
        lda lada6,x
        sta zpMapPtr
        jmp l9426
l9406   jsr print
        .asc ""
        .byt $7e,$54,$68,$6f,$75
l940e   jsr $7261
        .asc ""
        .byt $74
l9412   jsr $6f6e
        .asc ""
        .byt $74
l9416   jsr $7962
l9419   jsr $2061
        .asc ""
        .byt $63,$6f,$75,$6e,$74
l9421   adc $72
        and ($00,x)
        rts
l9426   jsr print
        .asc ""
        .byt $2d,$42
l942b   adc $79,x
        bit $5320
        adc $6c
        jmp ($203a)
        .byt $00
l9436   jsr l8d45
l9439   ldx #$09
        stx zpCursorCol
        cmp #$42
        beq l9454
l9441   cmp #$53
        bne l9448
l9445   jmp l9473
l9448   jsr print
l944b   and $6f6e
        ror !$0065
        jmp $164f
l9454   jsr print
        .asc ""
        .byt $2d,$42,$75,$79,$3a
l945c   jsr $2000
        .byt $93,$94
l9461   lda ladd2,x
        sta l946e
        lda ladd3,x
        sta l946f
        l946e = * + 1
        l946f = * + 2
        jsr $ffff
l9470   jmp la51a
l9473   jsr print
l9476   and $6553
        jmp ($3a6c)
l947c   jsr $2000
        .byt $93,$94
l9481   lda ladde,x
        sta l948e
        lda laddf,x
        sta l948f
        l948e = * + 1
        l948f = * + 2
        jsr $ffff
l9490   jmp la51a
l9493   jsr $164f
l9496   lda zpMapPtr
        jsr $8788
l949b   dec zpWndWdth
        jsr l94ab
l94a0   jsr $83f3
l94a3   jsr $83f3
l94a6   lda zpMapPtr
        asl
        tax
        rts
l94ab   lda zpMapPtr
        asl
        tax
        lda ladc6,x
        sta l94c0
        lda ladc7,x
        sta l94c1
        l94bc = * + 1
; Instruction parameter accessed.
        ldx #$00
        jsr printFromTable
l94c0   l94c1 = * + 1
        .byt $ff,$ff,$60
l94c3   lda #$01
        sta lad34               ; item index = 1

l94c8   lda #5
        sta zpCursorCol         ; cursor column: 5
        ldx lad34
        lda invArmour,x
        cmp #$ff
        beq l950e
l94d6   lda #$61                ; 'a' (selection letter)
        clc
        adc lad34               ; item index
        jsr printChar           ; print selection letter
        jsr print
        .aasc ") ",$00          ; whole string so far: "a) "
l94e5   ldx lad34               ; item index
        jsr printFromTable
        .word strTableArmour    ; print the armour for trade
        lda #23
        sta zpCursorCol         ; cursor column: 23
        jsr print
        .aasc "- ",$00          ; print "- "
        ldx lad34               ; item index
        jsr la200
l94fd   lda #$00
        sta $85be
        ldx lad30
        lda lad31
        jsr $857c
l950b   jsr $83f3
l950e   inc lad34               ; inc item index
        lda lad34
        cmp #$06                ; max index for armour trade?
        beq l9532               ; yes ->
l9518   cmp #$04
        bcc l94c8
l951c   lda $8250
        cmp #$d0
        lda $8251
        sbc #$07
        lda $8252
        sbc #$00
        lda $8253
        sbc #$00
        bcs l94c8

l9532   jsr la190
l9535   cmp #$42
        bcc l954f
l9539   cmp #$45
        bcc l9552
l953d   cmp #$47
        bcs l954f
l9541   ldx lad34
        ldy invArmour,x
        cpy #$ff
        beq l954f
l954b   cpx #$05
        bcs l9552
l954f   jmp l9580
l9552   sec
        sbc #$41
        sta $4d
        tax
        jsr la200
l955b   jsr la183
l955e   bcc l957d
l9560   ldx $4d
        inc invArmour,x
        jsr la16d
l9568   jsr $165b
l956b   lda #23
        sta zpCursorRow
        lda #15
        sta zpCursorCol
        ldx $4d
        jsr printFromTable
        .asc "T"
l9579   sei
        jmp la874
l957d   jsr la1c5
l9580   jsr $165b
l9583   lda #15
l9585   sta zpCursorCol
        lda #23
        sta zpCursorRow
        jsr print
        .asc ""
        .byt $6e,$6f,$74,$68,$69
l9593   ror !$0067
        rts
l9597   jsr $165b
l959a   lda #$10
        bne l9585
l959e   ldx #$05
        lda statsIntelligence
l95a3   sec
        sbc #$14
        bcc l95ac
l95a8   dex
        bne l95a3
l95ab   inx
l95ac   stx $ae62
        txa
        clc
        adc #$30
        sta l95d1
        jsr print
        .asc ""
        .byt $7e
l95ba   jsr $6150
        .asc ""
        .byt $63,$6b,$73
l95c0   jsr $666f
l95c3   jsr $3031
l95c6   jsr $6f66
        .asc ""
        .byt $6f,$64
l95cb   jsr $6f63
        .asc ""
        .byt $73,$74
l95d0   l95d1 = * + 1
; Instruction parameter accessed.
        jsr $2058
l95d3   bvs l963a
        .asc ""
        .byt $6e,$63
l95d7   adc $7e
        jsr $6520
        .asc ""
        .byt $61,$63,$68,$2e
l95e0   jsr $4820
        .asc ""
        .byt $6f,$77
l95e5   jsr $616d
        .asc ""
        .byt $6e,$79
l95ea   jsr $6f64
        .asc ""
        .byt $73,$74
l95ef   jsr $6874
        .asc ""
        .byt $6f,$75,$7e,$7f
l95f6   asl $77
        adc #$73
        pla
        jsr $6f74
l95fe   jsr $7570
        .asc ""
        .byt $72,$63,$68,$61,$73,$65,$3f,$00
l9609   jsr $870c
l960c   jsr $165b
l960f   lda #23
        sta zpCursorRow
        lda #15
        sta zpCursorCol
        jsr la675
l961a   jsr $8701
l961d   lda $ae61
        cmp #$1a
        bcc l9627
l9624   jmp l9580
l9627   lda $ae60
        ora $ae61
        bne l9632
l962f   jmp l9580
l9632   ldx $ae62
        lda #$00
        sta zpMapPtr
        l963a = * + 1
; Instruction parameter jumped to.
        sta $4d
l963b   lda zpMapPtr
        clc
        adc $ae60
        sta zpMapPtr
        lda $4d
        adc $ae61
        sta $4d
        dex
        bne l963b
l964d   asl $ae60
        rol $ae61
        lda $ae61
        pha
        lda $ae60
        pha
        asl $ae60
        rol $ae61
        asl $ae60
        rol $ae61
        pla
        clc
        adc $ae60
        sta $ae60
        pla
        adc $ae61
        sta $ae61
        lda statsCoin
        cmp zpMapPtr
        lda statsCoin+1
        sbc $4d
        bcs l9685
l9682   jmp l957d
l9685   lda statsCoin
        sec
        sbc zpMapPtr
        sta statsCoin
        lda statsCoin+1
        sbc $4d
        sta statsCoin+1
        lda statsFood
        clc
        adc $ae60
        sta statsFood
        lda statsFood+1
        adc $ae61
        sta statsFood+1
        jsr la1a7
l96ac   jsr $165b
l96af   lda #$17
        sta zpCursorRow
        sta zpCursorCol
        jsr $8720
l96b8   jsr print
l96bb   jsr $6170
        .asc ""
        .byt $63,$6b,$73
l96c1   jsr $6f66
        .asc ""
        .byt $6f,$64,$00
l96c7   jmp l9159
l96ca   lda #$01
        sta lad34
        lda #$07
        sta zpCursorRow
        lda $8250
        sta zpMapPtr
        lda $8251
        sta $4d
        ldx #$00
        lda $8252
        ora $8253
        beq l96ec
l96e7   ldx #$04
        jmp l9700
l96ec   lda zpMapPtr
        sec
        sbc #$b8
        sta zpMapPtr
        lda $4d
        sbc #$0b
        sta $4d
        bcc l9700
l96fb   inx
        cpx #$04
        bcc l96ec
l9700   lda l94bc
        and #$01
        bne l9708
l9707   inx
l9708   txa
        asl
        asl
        asl
        asl
        clc
        adc #$fa
        sta l97ad
        lda #$00
        adc #$ad
        sta l97ae
l971a   lda #$06
        sta zpCursorCol
        ldx lad34
        jsr l97ac
l9724   bne l9729
l9726   jmp l9761
l9729   lda #$61
        clc
        adc lad34
        jsr printChar
l9732   jsr print
        .asc ""
        .byt $29,$20,$00
l9738   ldx lad34
        jsr printFromTable
        .asc ""
        .byt $7c,$77
l9740   lda #$17
        sta zpCursorCol
        jsr print
l9747   and !zpLongitude
        ldx lad34
        jsr la20d
l9750   lda #$00
        sta $85be
        ldx lad30
        lda lad31
        jsr $857c
l975e   jsr $83f3
l9761   inc lad34
        lda lad34
        cmp #$10
        bcc l971a
l976b   jsr la190
l976e   cmp #$42
        bcc l977f
l9772   cmp #$51
        bcs l977f
l9776   sec
        sbc #$41
        tax
        jsr l97ac
l977d   bne l9782
l977f   jmp l9580
l9782   stx $4d
        jsr la20d
l9787   jsr la183
l978a   bcs l978f
l978c   jmp l957d
l978f   ldx $4d
        inc invWeapons,x
        jsr la16d
l9797   jsr $165b
l979a   lda #23
        sta zpCursorRow
        lda #15
        sta zpCursorCol
        ldx $4d
        jsr printFromTable
        .asc ""
        .byt $7c,$77
l97a9   jmp la874
l97ac   l97ad = * + 1
        l97ae = * + 2
        lda $ffff,x
        beq l97b6
l97b1   lda invWeapons,x
        cmp #$ff
l97b6   rts
l97b7   lda #$01
        sta lad34
        lda #$00
        sta l986a
        lda #$07
        sta zpCursorRow
l97c5   lda #$06
        sta zpCursorCol
        lda zpCursorRow
        cmp #$0f
        beq l9830
l97cf   ldx lad34
        lda invWeapons,x
        bne l97da
l97d7   jmp l9830
l97da   lda #$42
        clc
        adc lad34
        sta l986a
        lda #$61
        clc
        adc lad34
        jsr printChar
l97ec   jsr print
        .asc ""
        .byt $29,$20,$00
l97f2   ldx lad34
        jsr printFromTable
        .asc ""
        .byt $7c,$77
l97fa   lda #$17
        sta zpCursorCol
        jsr print
l9801   and !zpLongitude
        ldx lad34
        lda statsCharisma
        clc
        adc #$28
        sta zpMapPtr
        lda ladb6,x
        tax
        jsr la23f
l9816   lda lad31
        clc
        adc #$01
        sta lad30
        lda #$00
        sta lad31
        sta $85be
        ldx lad30
        jsr $857c
l982d   jsr $83f3
l9830   inc lad34
        lda lad34
        cmp #$10
        bcc l97c5
l983a   lda l986a
        bne l9862
l983f   jsr print
        .asc ""
        .byt $7e,$7f,$04,$54,$68,$6f,$75
l9849   jsr $6168
        .asc ""
        .byt $73,$74
l984e   jsr $6f6e
l9851   jsr $6577
        .asc ""
        .byt $61
l9855   bvs l98c6
l9857   ror $7972
        and ($00,x)
        jsr $85e1
l985f   jmp l9597
l9862   jsr la190
l9865   cmp #$42
        bcc l9876
l9869   l986a = * + 1
; Instruction parameter accessed.
        cmp #$51
        bcs l9876
l986d   sec
        sbc #$41
        tax
        l9872 = * + 1
; Instruction parameter jumped to.
        l9873 = * + 2
; Instruction parameter jumped to.
        lda invWeapons,x
l9874   bne l9879
l9876   jmp l9597
l9879   stx $4d
        lda statsCharisma
        clc
        adc #$28
        sta zpMapPtr
        lda ladb6,x
        tax
        jsr la23f
l988a   lda lad31
        clc
        adc #$01
        sta lad30
        lda #$00
        sta lad31
        lda statsCoin
        clc
        adc lad30
        sta statsCoin
        lda statsCoin+1
        adc lad31
        sta statsCoin+1
        jsr l9170
l98ae   ldx $4d
        dec invWeapons,x
        bne l98ba
l98b5   lda #$00
        sta statsWeapon
l98ba   jsr la1b6
l98bd   jsr $165b
l98c0   lda #$17
        sta zpCursorRow
        lda #$10
l98c6   sta zpCursorCol
        ldx $4d
        jsr printFromTable
        .asc ""
        .byt $7c,$77
l98cf   jmp la874
l98d2   lda #$01
        sta lad34
        lda l94bc
        and #$01
        sta $4d
l98de   lda #$06
        sta zpCursorCol
        ldx lad34
        cpx #$04
        beq l9902
l98e9   lda invSpells,x
        cmp #$ff
        beq l9902
l98f0   cpx #$07
        bcc l98fb
l98f4   lda statsClass
        cmp #$03
        bne l9902
l98fb   txa
        and #$01
        cmp $4d
        bne l9905
l9902   jmp l993d
l9905   lda #$61
        clc
        adc lad34
        jsr printChar
l990e   jsr print
        .asc ""
        .byt $29,$20,$00
l9914   ldx lad34
        jsr printFromTable
l991a   dey
        sei
        lda #$17
        sta zpCursorCol
        jsr print
l9923   and !zpLongitude
        ldx lad34
        jsr la1f0
l992c   lda #$00
        sta $85be
        ldx lad30
        lda lad31
        jsr $857c
l993a   jsr $83f3
l993d   inc lad34
        lda lad34
        cmp #$0b
        bcc l98de
l9947   jsr la190
l994a   cmp #$42
        bcc l9973
l994e   cmp #$4c
        bcs l9973
l9952   sec
        sbc #$41
        tax
        cpx #$04
        beq l9973
l995a   lda invSpells,x
        cmp #$ff
        beq l9973
l9961   cpx #$07
        bcc l996c
l9965   lda statsClass
        cmp #$03
        bne l9973
l996c   txa
        and #$01
        cmp $4d
        bne l9976
l9973   jmp l9580
l9976   stx $4d
        jsr la1f0
l997b   jsr la183
l997e   bcs l9983
l9980   jmp l957d
l9983   ldx $4d
        cpx #$0a
        bne l99a6
l9989   lda $825d
        bne l9998
l998e   lda $825c
        cmp #$0a
        bcs l9998
l9995   jmp l957d
l9998   lda $825c
        sec
        sbc #$0a
        sta $825c
        bcs l99a6
l99a3   dec $825d
l99a6   inc invSpells,x
        jsr la16d
l99ac   jsr $165b
l99af   lda #23
        sta zpCursorRow
        lda #15
        sta zpCursorCol
        ldx $4d
        jsr printFromTable
l99bc   dey
        sei
        jmp la874
l99c1   lda statsCoin
        ora statsCoin+1
        bne l9a17
l99c9   jsr print
        .byt $7f,$07,$54,$68,$6f,$75
l99d2   jsr $7261
        .asc ""
        .byt $74
l99d6   jsr $7262
        .asc ""
        .byt $6f,$6b,$65,$21,$7e,$7e,$7f,$03,$43,$6f,$6d,$65
l99e5   jsr $6162
        .asc ""
        .byt $63,$6b
l99ea   jsr $6877
l99ed   adc $6e
        jsr $6874
        .asc ""
        .byt $6f,$75
l99f4   jsr $6168
        .asc ""
        .byt $73,$74,$7e,$7f,$05,$73,$6f
l99fe   adc $2065
        adc $6e6f
        adc $79
        jsr $6f74
l9a09   jsr $7073
        .asc ""
        .byt $65,$6e,$64
l9a0f   rol $2000
        sbc ($85,x)
        jmp l9597
l9a17   dec statsCoin
        lda statsCoin
        cmp #$ff
        bne l9a24
l9a21   dec statsCoin+1
l9a24   jsr print
        .asc ""
        .byt $7e,$7f,$02,$54,$68,$65
l9a2d   jsr $6174
        .asc ""
        .byt $76
l9a31   adc $72
        ror $6b20
        adc $65
        bvs l9a9f
        .asc ""
        .byt $72
l9a3b   jsr $6173
        .asc ""
        .byt $79,$65,$74,$68,$3a,$7e
l9a44   ror $037f,x
        pha
        adc $72
        adc $2c
        jsr $6168
l9a4f   ror $65,x
        jsr $2061
        .asc ""
        .byt $63,$6f
l9a56   jmp ($2064)
        .asc ""
        .byt $6f,$6e,$65
l9a5c   and ($00,x)
        jsr $870c
l9a61   jsr $165b
l9a64   ldy #23
        ldx #15
        jsr printAtPos
        .aasc "ale",$00
        jsr $8701
l9a72   jsr $85e1
l9a75   jsr la85a
l9a78   lda #$08
        sta zpCursorRow
        inc lad38
        lda statsStamina
        lsr
        lsr
        cmp lad38
        beq l9a8b
l9a89   bcs l9af1
l9a8b   ldx #$01
        jsr la76e
l9a90   cmp #$02
        bcs l9af1
l9a94   jsr print
        .byt $7f,$03,$54,$68,$6f
l9a9c   adc zpLongitude,x
        pla
l9a9f   adc ($73,x)
        .asc ""
        .byt $74
l9aa2   jsr $6562
l9aa5   adc $6e
        jsr $6573
        .asc ""
        .byt $64,$75,$63,$65,$64,$21
l9ab0   ror $7f7e,x
        ora $41
        ror $74
        adc $72
        jsr $2061
l9abc   jmp ($6e6f)
        .asc ""
        .byt $67
l9ac0   jsr $696e
        .asc ""
        .byt $67,$68,$74,$2c,$7e,$7f,$07,$74,$68,$6f,$75
l9ace   jsr $7261
        .asc ""
        .byt $74
l9ad2   jsr $6162
        .asc ""
        .byt $63,$6b,$2e,$00
l9ad9   lsr statsCoin+1
        ror statsCoin
        dec statsWisdom
        lda statsWisdom
        cmp #$05
        bcs l9aee
l9ae9   lda #$05
        sta statsWisdom
l9aee   jmp $85e1
l9af1   jsr randomNumber
l9af4   cmp #$4b
        bcs l9af9
l9af8   rts
l9af9   jsr print
        .byt $7f,$06,$54,$68,$6f
l9b01   adc zpLongitude,x
        pla
        adc ($64,x)
        jsr $6562
        .asc ""
        .byt $73,$74
l9b0b   jsr $6e6b
        .asc ""
        .byt $6f,$77
l9b10   ror $2000,x
        bvs l9b2b
l9b15   lsr
        lsr
        lsr
        lsr
        lsr
        asl
        tax
        lda ladea,x
        sta l9b29
        lda ladeb,x
        sta l9b2a
        l9b29 = * + 1
        l9b2a = * + 2
        jsr $ffff
l9b2b   jmp $85e1
l9b2e   jsr print
        .byt $7f,$05,$61,$62,$6f
l9b36   adc $74,x
        jsr $7073
        .asc ""
        .byt $61,$63,$65
l9b3e   jsr $7274
        .asc ""
        .byt $61
l9b42   ror $65,x
        jmp ($7e21)
        .byt $7f,$05,$54,$68,$6f,$75
l9b4d   jsr $756d
        .asc ""
        .byt $73,$74
l9b52   jsr $6564
        .asc ""
        .byt $73,$74,$72,$6f,$79
l9b5a   jsr $7461
l9b5d   ror $047f,x
        jmp ($6165)
        .asc ""
        .byt $73,$74
l9b65   jsr $3032
l9b68   jsr $6e65
        .asc ""
        .byt $65,$6d,$79
l9b6e   jsr $6576
        .asc ""
        .byt $73,$73,$65
l9b74   jmp ($7e73)
        .byt $7f,$06,$74,$6f
l9b7b   jsr $6562
        .asc ""
        .byt $63,$6f
l9b80   adc $2065
        adc ($6e,x)
        jsr $6361
        .asc ""
        .byt $65
l9b89   and ($00,x)
        rts
l9b8c   jsr print
        .byt $7f,$05,$74,$6f
l9b93   jsr $6177
        .asc ""
        .byt $74,$63
l9b98   pla
        jsr $6874
        .asc ""
        .byt $65
l9b9d   jsr la200
l9ba0   ora zpLongitude
        and $3984
        lda $2ea9
        jmp printChar
l9bab   jsr print
        .aasc " that the princess will give",$7e
        .aasc " great reward to the one who",$7e
        .aasc "rescues her, and an extra gift",$7e,$7f
        .aasc $05,"to an 8th level ace!",$00
        rts

l9c1f   jsr print
        .aasc "  thou must go back in time.",$00
        rts

l9c3f
        jsr print
        .aasc $7f
        .aasc $05,"thou should destroy",$7e,$7f
        .aasc $08,"the evil gem!",$00
        rts

l9c6a   jsr print
        .aasc "  that many lakes and ponds",$7e
        .aasc " have strong magical powers!",$00
        rts

l9ca7   jsr print
        .byt $7f
l9cab   ora $74
        pla
        adc #$73
        jsr $7369
l9cb3   jsr $2061
        .asc ""
        .byt $67,$72,$65
l9cb9   adc ($74,x)
        jsr $6167
        .asc ""
        .byt $6d,$65
l9cc0   and ($00,x)
        rts
l9cc3   jsr print
l9cc6   jsr $7420
l9cc9   pla
        adc ($74,x)
        jsr $766f
l9ccf   adc $72
        jsr $3031
l9cd4   bmi l9d06
l9cd6   jsr $6579
        .asc ""
        .byt $61,$72,$73
l9cdc   jsr $6761
        .asc ""
        .byt $6f,$2c
l9ce1   ror $6f4d,x
        ror $6164
        adc #$6e
        jsr $6874
        .asc ""
        .byt $65
l9ced   jsr $6957
        .asc ""
        .byt $7a,$61,$72,$64
l9cf4   jsr $7263
        .asc ""
        .byt $65
l9cf8   adc ($74,x)
        adc $64
        jsr $6e61
l9cff   ror $6520,x
        ror $69,x
        l9d06 = * + 2
        jmp ($6720)
        .asc ""
        .byt $65
l9d08   adc $202e
        jsr $6957
        .asc ""
        .byt $74
l9d0f   pla
        jsr $6874
l9d13   adc #$73
        jsr $6567
l9d18   adc $202c
        pla
        adc $7e
        jsr $6920
        .asc ""
        .byt $73
l9d22   jsr $6d69
        .asc ""
        .byt $6d,$6f,$72,$74
l9d29   adc ($6c,x)
        jsr $6e61
        .asc ""
        .byt $64
l9d2f   jsr $6163
        .asc ""
        .byt $6e
l9d33   ror $746f
        jsr $6562
        .asc ""
        .byt $7e,$7f,$0a,$64,$65
l9d3e   ror $65
        adc ($74,x)
        adc $64
        rol $2000
        sbc ($85,x)
        jsr la85a
l9d4c   lda #$08
        sta zpCursorRow
        jsr print
        .asc ""
        .byt $54,$68,$65
l9d56   jsr $7571
        .asc ""
        .byt $65,$73,$74
l9d5c   jsr $666f
l9d5f   jsr $2d2d
        .asc ""
        .byt $55
l9d63   jmp ($6974)
        .asc ""
        .byt $6d,$61
l9d68   and $202d
        adc #$73
        jsr $6f74
        .asc ""
        .byt $7e
l9d71   jsr $7274
        .asc ""
        .byt $61,$76,$65,$72,$73,$65
l9d7a   jsr $6874
l9d7d   adc zpLongitude
        jmp ($6e61)
        .asc ""
        .byt $64,$73
l9d84   jsr $6e69
l9d87   jsr $6573
        .asc ""
        .byt $61,$72,$63,$68,$7e,$7f,$03,$6f,$66
l9d93   jsr $2061
        .asc ""
        .byt $74
l9d97   adc #$6d
        adc zpLongitude
        adc $6361
        pla
        adc #$6e
        adc zpWndLeft
        jsr $5520
l9da6   bvs l9e17
        .asc ""
        .byt $6e,$7e
l9daa   jsr $6966
        .asc ""
        .byt $6e,$64,$69,$6e,$67
l9db2   jsr $7573
        .asc ""
        .byt $63
l9db6   pla
        jsr $2061
        .asc ""
        .byt $64
l9dbb   adc $76
        adc #$63
        adc $2c
        jsr $6874
        .asc ""
        .byt $6f,$75,$7e,$73,$68,$6f,$75
l9dcb   jmp ($2064)
        .asc ""
        .byt $67,$6f
l9dd0   jsr $6162
        .asc ""
        .byt $63,$6b
l9dd5   jsr $6e69
l9dd8   jsr $6974
        .asc ""
        .byt $6d,$65
l9ddd   jsr $6f74
l9de0   jsr $6874
l9de3   adc $7e
        jsr $6164
        .asc ""
        .byt $79,$73
l9dea   jsr $6562
        .asc ""
        .byt $66,$6f,$72,$65
l9df1   jsr $6f4d
l9df4   ror $6164
        adc #$6e
        jsr $7263
        .asc ""
        .byt $65
l9dfd   adc ($74,x)
        adc $64
        ror $6874,x
        adc zpLongitude
        adc $76
        adc #$6c
        jsr $6567
        .asc ""
        .byt $6d
l9e0e   jsr $6e61
        .asc ""
        .byt $64
l9e12   jsr $6564
        l9e17 = * + 2
        .asc ""
        .byt $73,$74,$72,$6f
l9e19   adc $6820,y
        adc #$6d
        rol $4c00
        sbc ($85,x)
        lda #$00
        sta lad35
        sta lad36
        sta lad37
        ldx #$06
l9e30   sta $ae62,x
        dex
        bpl l9e30
l9e36   ldx #$03
l9e38   l9e39 = * + 1
; Instruction parameter jumped to.
        lda $8226,x
        bne l9e40
l9e3d   inc lad35
l9e40   cmp #$01
        bne l9e47
l9e44   inc lad36
l9e47   cmp #$02
        bne l9e4e
l9e4b   inc lad37
l9e4e   dex
        bpl l9e38
l9e51   lda lad36
        ora lad37
        ora lad35
        bne l9e7a
l9e5c   jsr print
        .byt $7f
l9e60   asl $43
        jmp ($736f)
l9e65   adc $64
        jsr $6f66
        .asc ""
        .byt $72
l9e6b   jsr $6874
        .asc ""
        .byt $65
l9e6f   jsr $6164
l9e72   adc $2000,y
        sbc ($85,x)
        jmp l9580
l9e7a   lda lad36
        ora lad37
        beq l9eb2
l9e82   jsr print
        .byt $7f,$07
l9e87   adc ($29,x)
        jsr $6f48
        .asc ""
        .byt $72,$73
l9e8e   adc zpLongitude
        jsr $2d20
l9e93   jsr la200
l9e96   ora (zpLongitude,x)
        bcs l9e39
l9e9a   jsr print
        .byt $7f,$07,$62,$29
l9ea1   jsr $6143
        .asc ""
        .byt $72,$74
l9ea6   jsr $2020
l9ea9   jsr $202d
        .byt $00
l9ead   ldx #$02
        jsr l9fb0
l9eb2   lda lad35
        beq l9ee7
l9eb7   jsr print
        .byt $7f,$07,$63,$29
l9ebe   jsr $6152
l9ec1   ror $74
        jsr $2020
l9ec6   jsr $202d
        .byt $00
l9eca   ldx #$03
        jsr l9fb0
l9ecf   jsr print
        .byt $7f,$07,$64
l9ed5   and #$20
        lsr $72
        adc #$67
        adc ($74,x)
        adc zpLongitude
        and !zpLongitude
        ldx #$04
        jsr l9fb0
l9ee7   lda lad36
        beq l9f37
l9eec   lda $8250
        cmp #$b8
        lda $8251
        sbc #$0b
        lda $8252
        sbc #$00
        lda $8253
        sbc #$00
        bcc l9f37
l9f02   jsr print
        .byt $7f,$07
l9f07   adc $29
        jsr $6941
        .asc ""
        .byt $72
l9f0d   jsr $6143
        .asc ""
        .byt $72
l9f11   jsr $202d
        .byt $00
l9f15   ldx #$05
        jsr l9fb0
l9f1a   lda $8219
        bne l9f37
l9f1f   jsr print
        .byt $7f,$07
l9f24   ror $29
        jsr $6853
        .asc ""
        .byt $75,$74,$74
l9f2c   jmp ($2065)
l9f2f   and !zpLongitude
        ldx #$06
        jsr l9fb0
l9f37   jsr la190
l9f3a   cmp #$41
        bcc l9f4b
l9f3e   cmp #$47
        bcs l9f4b
l9f42   sec
        sbc #$40
        tax
        lda $ae62,x
        bne l9f4e
l9f4b   jmp l9580
l9f4e   stx $4d
        jsr la22b
l9f53   jsr la183
l9f56   bcs l9f5b
l9f58   jmp l957d
l9f5b   ldx $4d
        inc $8213,x
        cpx #$06
        bne l9f74
l9f64   lda #$e8
        sta $825e
        sta $8260
        lda #$03
        sta $825f
        sta $8261
l9f74   lda ladaf,x
        ldy #$03
l9f79   cmp $8226,y
        beq l9f91
l9f7e   cpx #$03
        bcs l9f8d
l9f82   sta zpMapPtr
        lda $8226,y
        cmp #$02
        beq l9f91
l9f8b   lda zpMapPtr
l9f8d   dey
        bpl l9f79
l9f90   iny
l9f91   txa
        clc
        adc #$08
        sta $8226,y
        jsr la16d
l9f9b   jsr $165b
l9f9e   lda #23
        sta zpCursorRow
        lda #15
        sta zpCursorCol
        ldx $4d
        jsr printFromTable
l9fab   bmi la026
l9fad   jmp la874
l9fb0   inc $ae62,x
        jsr la22b
l9fb6   lda #$00
        sta $85be
        ldx lad30
        lda lad31
        jsr $857c
l9fc4   jmp $83f3
l9fc7   lda #$01
        sta lad34
        lda #$00
        sta $ae62
l9fd1   lda #$05
        sta zpCursorCol
        ldx lad34
        lda invArmour,x
        beq la01f
l9fdd   inc $ae62
        lda #$61
        clc
        adc lad34
        jsr printChar
l9fe9   jsr print
        .asc ""
        .byt $29,$20,$00
l9fef   ldx lad34
        jsr printFromTable
        .asc "T"
l9ff6   sei
        lda #$17
        sta zpCursorCol
        jsr print
l9ffe   and !zpLongitude
        ldx lad34
        lda statsCharisma
        lsr
        lsr
        sta zpMapPtr
        jsr la23f
la00e   lda #$00
        sta $85be
        ldx lad30
        lda lad31
        jsr $857c
la01c   jsr $83f3
la01f   inc lad34
        lda lad34
        la026 = * + 1
; Instruction parameter jumped to.
        cmp #$06
la027   la028 = * + 1
; Instruction parameter jumped to.
        bcc l9fd1
        lda $ae62
        bne la056
la02e   jsr print
        .asc ""
        .byt $7e
la032   jsr $6854
        .asc ""
        .byt $6f,$75
la037   jsr $6168
        .asc ""
        .byt $73,$74
la03c   jsr $6f6e
la03f   jsr $7261
        .asc ""
        .byt $6d,$6f
la044   adc $72,x
        jsr $6f74
la049   jsr $6573
la04c   jmp ($216c)
        .byt $00
la050   jsr $85e1
la053   jmp l9597
la056   jsr $870c
la059   jsr $165b
la05c   lda #$17
        sta zpCursorRow
        lda #$10
        sta zpCursorCol
        jsr readKey
la067   pha
        jsr $8701
la06b   pla
        cmp #$42
        bcc la074
la070   cmp #$47
        bcc la077
la074   jmp l9597
la077   sec
        sbc #$41
        sta $4d
        tax
        lda invArmour,x
        beq la074
la082   ldx $4d
        lda statsCharisma
        lsr
        lsr
        sta zpMapPtr
        jsr la23f
la08e   ldx $4d
        dec invArmour,x
        bne la09a
la095   lda #$00
        sta statsArmour
la09a   lda statsCoin
        clc
        adc lad30
        sta statsCoin
        lda statsCoin+1
        adc lad31
        sta statsCoin+1
        jsr l9170
la0b0   jsr la1b6
la0b3   jsr $165b
la0b6   lda #$17
        sta zpCursorRow
        lda #$10
        sta zpCursorCol
        ldx $4d
        jsr printFromTable
        .asc "T"
la0c4   sei
        jmp la874
la0c8   jsr print
la0cb   ror $047f,x
        eor $73,x
        adc $64
        jsr $6f66
        .asc ""
        .byt $6f,$64,$3f
la0d8   jsr $4e20
        .asc ""
        .byt $6f
la0dc   jsr $6874
        .asc ""
        .byt $61
la0e0   ror $736b
        and ($00,x)
        jsr $85e1
la0e8   jmp l9597
la0eb   jsr print
        .asc ""
        .byt $7e,$7f,$03,$53,$6f,$72,$72,$79,$2c
la0f7   jsr $6577
la0fa   jsr $6f64
la0fd   ror $7427
        jsr $6564
la103   adc ($6c,x)
        jsr $6e69
la108   ror $097f,x
        adc $73,x
        adc $64
        jsr $7473
        .asc ""
        .byt $75
la113   ror $66
        rol $2000
        sbc ($85,x)
        jmp l9597
la11d   jsr print
        .asc ""
        .byt $7e,$7f,$05,$57,$65
la125   jsr $6f64
la128   ror $7427
        jsr $7562
la12e   adc $7320,y
        bvs la198
la133   jmp ($736c)
la136   and ($00,x)
        jsr $85e1
la13b   jmp l9597
la13e   jsr print
        .asc ""
        .byt $7e,$7f,$03,$57
la145   adc zpLongitude
        pla
        adc ($76,x)
        adc zpLongitude
        bvs la1ba
        .asc ""
        .byt $65
la14f   ror $7974
        jsr $666f
la155   jsr $6f62
        .asc ""
        .byt $6f,$7a,$65,$7e,$7f,$0a,$61
la15f   jmp ($6572)
la162   adc ($64,x)
        adc !zpLatitude,y
        jsr $85e1
la16a   jmp l9597
la16d   lda statsCoin
        sec
        sbc lad30
        sta statsCoin
        lda statsCoin+1
        sbc lad31
        sta statsCoin+1
        jmp la1a7
la183   lda statsCoin
        cmp lad30
        lda statsCoin+1
        sbc lad31
        rts
la190   jsr $870c
la193   jsr $165b
la196   lda #23
la198   sta zpCursorRow
        lda #15
        sta zpCursorCol
        jsr readKey
la1a1   pha
        jsr $8701
la1a5   pla
        rts
la1a7   jsr la85a
la1aa   jsr print
        .byt $7f,$0b,$53,$6f
la1b1   jmp ($2164)
        .byt $00,$60
la1b6   jsr la85a
la1b9   la1ba = * + 1
; Instruction parameter jumped to.
        jsr print
        .byt $7f,$0b,$44,$6f,$6e,$65
la1c2   and ($00,x)
        rts
la1c5   jsr la85a
la1c8   jsr print
la1cb   jsr $5420
        .asc ""
        .byt $68,$6f,$75
la1d1   jsr $6163
la1d4   ror $7473
        jsr $6f6e
        .asc ""
        .byt $74
la1db   jsr $6661
        .asc ""
        .byt $66,$6f,$72,$64
la1e2   jsr $7469
la1e5   and (zpLongitude,x)
        jsr zpLongitude
la1ea   jsr $8772
la1ed   jmp la874
la1f0   lda #$c8
        sec
        sbc statsWisdom
        lsr
        lsr
        lsr
        lsr
        lsr
        sta zpMapPtr
        jmp la23f
la200   lda #$c8
        sec
        sbc statsIntelligence
        lsr
        lsr
        sta zpMapPtr
        jmp la23f
la20d   lda #$ff
        sec
        sbc statsIntelligence
        sta zpMapPtr
        lda ladb6,x
        tax
        jsr la23f
la21c   lda lad31
        clc
        adc #$05
        sta lad30
        lda #$00
        sta lad31
        rts
la22b   lda #$c8
        sec
        sbc statsIntelligence
        ldy #$00
la233   iny
        sec
        sbc #$05
        bcs la233
la239   sty zpMapPtr
        lda ladb6,x
        tax
la23f   lda #$00
        sta lad30
        sta lad31
la247   dex
        cpx #$ff
        beq la260
la24c   lda lad30
        clc
        adc zpMapPtr
        sta lad30
        lda lad31
        adc #$00
        sta lad31
        jmp la247
la260   rts


cmdTwUnlock
la261   jsr print
        .aasc " what",$00
        jmp $876a

la26d   jsr $890c
la270   jmp la51a

la273   lda lad2a
        bne la27b
la278   jmp la3ea
la27b   ldx #$0f
        stx lad2b
la280   ldx lad2b
        lda $cdac,x
        cmp #$03
        beq la28d
la28a   jmp la33d
la28d   jsr la76e
la290   cmp #$02
        bcs la297
la294   jmp la347
la297   cmp #$09
        bcc la29e
la29b   jmp la33d
la29e   ldy #$00
        ldx lad2b
        lda zpLongitude
        cmp $cdbc,x
        beq la2b0
la2aa   bmi la2af
la2ac   iny
        bne la2b0
la2af   dey
la2b0   sty $24
        ldy #$00
        lda zpLatitude
        cmp $cdcc,x
        beq la2c1
la2bb   bmi la2c0
la2bd   iny
        bne la2c1
la2c0   dey
la2c1   sty $25
        lda $cdcc,x
        clc
        adc $25
        sta $2d
        lda $cdbc,x
        clc
        adc $24
        sta $2c
        jsr randomNumber
la2d6   ora #$01
        sta la346
la2db   lda la346
        bmi la2f9
la2e0   ldx lad2b
        lda $cdbc,x
        tax
        ldy $2d
        jsr la5eb
la2ec   bcc la331
la2ee   ldx lad2b
        lda $cdbc,x
        sta $2c
        jmp la30e
la2f9   ldx lad2b
        ldy $cdcc,x
        ldx $2c
        jsr la5eb
la304   bcc la331
la306   ldx lad2b
        ldy $cdcc,x
        sty $2d
la30e   ldx lad2b
        ldy $cdcc,x
        lda $cdbc,x
        tax
        lda #$20
        jsr la5d3
la31d   ldx lad2b
        lda $2d
        sta $cdcc,x
        tay
        lda $2c
        sta $cdbc,x
        tax
        lda #$2f
        jsr la5d3
la331   lda la346
        eor #$ff
        sta la346
        and #$01
        beq la2db
la33d   dec lad2b
        bmi la345
la342   jmp la280
la345   rts
la346   .byt $00
la347   jsr $165b
la34a   lda #$17
        sta zpCursorRow
        jsr print
        .asc ""
        .byt $7e,$41,$74,$74,$61,$63,$6b
la358   adc $64
        jsr $7962
la35d   jsr $7567
        .asc ""
        .byt $61,$72,$64,$21,$7e,$00
la366   lda #$04
        jsr playSoundEffect
la36b   lda statsStamina
        lsr
        sta zpMapPtr
        lda statsArmour
        asl
        asl
        asl
        clc
        adc zpMapPtr
        adc #$38
        sta zpMapPtr
        sta lad29
        jsr randomNumber
la384   cmp zpMapPtr
        bcs la396
la388   jsr print
        .asc ""
        .byt $4d,$69,$73,$73
la38f   adc $64
        and ($00,x)
        jmp la33d
la396   lda statsHp+1
        asl
        clc
        adc #$0f
        sta zpMapPtr
la39f   jsr randomNumber
la3a2   cmp #$00
        beq la39f
la3a6   cmp zpMapPtr
        bcs la39f
la3aa   sta $4d
        jsr print
la3af   pha
        adc #$74
        rol $2e2e
        jsr la200
        .byt $00
la3b9   stx $85be
        lda $4d
        jsr $8582
la3c1   jsr print
la3c4   jsr $6164
la3c7   adc $6761
        adc $00
        lda #$02
        jsr playSoundEffect
la3d1   lda statsHp
        sec
        sbc $4d
        sta statsHp
        lda statsHp+1
        sbc #$00
        sta statsHp+1
        bcs la3e7
la3e4   jmp l8d61
la3e7   jmp la33d
la3ea   ldy #$0f
        sty lad2b
la3ef   lda $cdac,y
        cmp #$04
        bne la3fc
la3f6   jsr la40c
la3f9   jmp la403
la3fc   cmp #$05
        bne la403
la400   jsr la4c7
la403   dec lad2b
        ldy lad2b
        bpl la3ef
la40b   rts
la40c   jsr la662
la40f   ldx $2c
        ldy $2d
        jsr la5eb
la416   bcc la41b
la418   jmp la4a4
la41b   cmp #$2f
        beq la457
la41f   jsr randomNumber
la422   cmp #$28
        bcs la456
la426   lda #$17
        sta zpCursorRow
        inc lad29
        jsr print
la430   ror $6f49,x
        jmp ($206f)
        .asc ""
        .byt $74,$68,$65
la439   jsr $6142
        .asc ""
        .byt $72,$64
la43e   jsr $6973
        .asc ""
        .byt $6e,$67,$73,$3a
la445   ror $6f48,x
        jsr $7965
        .asc ""
        .byt $6f
la44c   pla
        jsr $6568
la450   jsr $7568
la453   adc !zpLatitude
la456   rts
la457   lda #$00
        sta zpMapPtr
        ldx #$0f
la45d   lda invWeapons,x
        beq la46c
la462   cpx statsWeapon
        beq la46c
la467   dec invWeapons,x
        inc zpMapPtr
la46c   dex
        bne la45d
la46f   lda #$80
        clc
        adc statsWisdom
        sta $4d
        jsr randomNumber
la47a   cmp zpMapPtr
        bcs la4a3
la47e   lda zpMapPtr
        beq la4a3
la482   lda #$17
        sta zpCursorRow
        inc lad29
        jsr print
la48c   ror $6f49,x
        jmp ($206f)
        .asc ""
        .byt $73,$74,$6f
la495   jmp ($2065)
        .asc ""
        .byt $73,$6f,$6d,$65,$74,$68,$69,$6e,$67
la4a1   and ($00,x)
la4a3   rts
la4a4   ldy lad2b
        ldx $cdbc,y
        lda $cdcc,y
        tay
        lda #$20
        jsr la5d3
la4b3   ldy lad2b
        lda $2c
        sta $cdbc,y
        tax
        lda $2d
        sta $cdcc,y
        tay
        lda #$5c
        jmp la5d3
la4c7   jsr la662
la4ca   ldx $2c
        ldy $2d
        jsr la5eb
la4d1   bcs la4d4
la4d3   rts
la4d4   cmp #$6d
        bne la4d9
la4d8   rts
la4d9   ldy lad2b
        ldx $cdbc,y
        lda $cdcc,y
        tay
        lda #$20
        jsr la5d3
la4e8   ldy lad2b
        lda $2c
        sta $cdbc,y
        tax
        lda $2d
        sta $cdcc,y
        tay
        lda #$5f
        jmp la5d3
la4fc   ldx #$00
        ldy #$17
la500   jsr printAtPos
        .aasc $7e
        .aasc "the city of ",$00
la511   ldx $8262
        jsr printFromTable
        .word strTablePlaces
        rts
la51a   lda #$01
        sta zpCursorRow
        jsr $165e
la521   jsr la553
la524   lda #$00
        sta la532
        lda #$cb
        sta la533
la52e   jsr printCR
la531   la532 = * + 1
; Instruction parameter accessed.
        la533 = * + 2
; Instruction parameter accessed.
        lda $cb00
        jsr printChar
la537   inc la532
        bne la53f
la53c   inc la533
la53f   lda zpCursorCol
        cmp #$26
        bne la531
la545   inc zpCursorRow
        lda zpCursorRow
        cmp #$13
        bne la52e
la54d   jsr la553
la550   jmp la59d
la553   ldx #$00
la555   lda $c700,x
        ldy $0800,x
        sta $0800,x
        tya
        sta $c700,x
        lda $c800,x
        ldy $0900,x
        sta $0900,x
        tya
        sta $c800,x
        lda $c900,x
        ldy $0a00,x
        sta $0a00,x
        tya
        sta $c900,x
        lda $ca00,x
        ldy $0b00,x
        sta $0b00,x
        tya
        sta $ca00,x
        dex
        bne la555
la58c   lda $1530,x
        ldy la887,x
        sta la887,x
        tya
        sta $1530,x
        inx
        bpl la58c
la59c   rts
la59d   jsr $165e
la5a0   lda zpLongitude
        sta zpCursorCol
        lda zpLatitude
        sta zpCursorRow
        inc zpCursorRow
        lda #$7b
        jsr printChar
la5af   ldy #$0f
la5b1   lda $cdbc,y
        sta zpCursorCol
        lda $cdcc,y
        sta zpCursorRow
        inc zpCursorRow
        lda $cdac,y
        bmi la5cd
la5c2   sty zpMapPtr
        tax
        lda lad98,x
        jsr printChar
la5cb   ldy zpMapPtr
la5cd   dey
        bpl la5b1
la5d0   jmp $165b
la5d3   stx zpMapPtr
        sty $4d
        pha
        jsr $165e
la5db   pla
        ldx zpMapPtr
        ldy $4d
        stx zpCursorCol
        iny
        sty zpCursorRow
        jsr printChar
la5e8   jmp $165b
la5eb   jsr la604
la5ee   bcs la5f1
la5f0   rts
la5f1   lda zpLongitude
        cmp zpMapPtr
        bne la601
la5f7   lda zpLatitude
        cmp $4d
        bne la601
la5fd   lda #$2f
        clc
la600   rts
la601   tya
        sec
        rts
la604   cpx #$26
        bcc la60c
la608   lda #$60
        clc
        rts
la60c   cpy #$12
        bcs la608
la610   lda lad64,y
        clc
        adc #$00
        sta la622
        lda lad76,y
        adc #$cb
        sta la623
        la622 = * + 1
        la623 = * + 2
        lda $ffff,x
        cmp #$60
        bcs la629
la628   rts
la629   stx zpMapPtr
        sty $4d
        ldx #$0f
        tay
la630   lda $cdbc,x
        cmp zpMapPtr
        bne la648
la637   lda $cdcc,x
        cmp $4d
        bne la648
la63e   stx lad2e
        lda $cdac,x
        clc
        adc #$30
        rts
la648   dex
        bpl la630
la64b   tya
        sec
        rts
la64e   jsr randomNumber
la651   cmp #$55
        bcs la658
la655   lda #$ff
        rts
la658   cmp #$aa
        bcs la65f
la65c   lda #$00
        rts
la65f   lda #$01
        rts
la662   jsr la64e
la665   clc
        adc $cdbc,y
        sta $2c
        jsr la64e
la66e   clc
        adc $cdcc,y
        sta $2d
        rts
la675   lda #$00
        sta $ae60
        sta $ae61
        sta $ae5e
        sta $ae5f
        sta lad2c
la686   jsr getKey
la689   beq la686
la68b   cmp #$0d
        bne la69a
la68f   lda lad2c
        bne la699
la694   jsr print
la697   bmi la699
la699   rts
la69a   cmp #$14
        bne la6b6
la69e   lda lad2c
        beq la686
la6a3   dec lad2c
        ldx #$05
la6a8   lda lae5a,x
        sta $ae5c,x
        dex
        bpl la6a8
la6b1   dec zpCursorCol
        jmp la686
la6b6   cmp #$30
        bcc la686
la6ba   cmp #$3a
        bcs la686
la6be   pha
        jsr printChar
la6c2   pla
        sec
        sbc #$30
        pha
        ldx #$00
la6c9   lda $ae5c,x
        sta lae5a,x
        inx
        cpx #$06
        bne la6c9
la6d4   asl $ae60
        rol $ae61
        lda $ae61
        pha
        lda $ae60
        pha
        asl $ae60
        rol $ae61
        asl $ae60
        rol $ae61
        pla
        clc
        adc $ae60
        sta $ae60
        pla
        adc $ae61
        sta $ae61
        pla
        clc
        adc $ae60
        sta $ae60
        bcc la70a
la707   inc $ae61
la70a   inc lad2c
        lda lad2c
        cmp #$04
        bcs la717
la714   jmp la686
la717   rts
la718   jsr randomNumber
la71b   sta zpMapPtr
        sta lad2f
        jmp la733
la723   jsr randomNumber
la726   pha
        jsr la71b
la72a   sta zpMapPtr
        pla
        sta lad2f
        jmp la733
la733   lda #$00
        sta $4d
        sta lad30
        sta lad31
        ldx #$07
la73f   lda lad2f
        and #$01
        bne la757
la746   lda lad30
        clc
        adc zpMapPtr
        sta lad30
        lda lad31
        adc $4d
        sta lad31
la757   lsr lad2f
        asl zpMapPtr
        rol $4d
        dex
        bne la73f
la761   lda lad31
        rts
la765   jsr $165b
la768   jsr $1649
la76b   jmp $8b64
la76e   stx lad24
        lda $cdbc,x
        cmp #$ff
        beq la7f0
la778   lda zpLongitude
        cmp #$ff
        beq la7f0
la77e   sec
        sbc $cdbc,x
        bcs la78d
la784   sta lad33
        sec
        lda #$00
        sbc lad33
la78d   ldy #$00
        sty lad25
        sty lad26
        tay
        tax
        inx
la798   dex
        beq la7aa
la79b   tya
        clc
        adc lad25
        sta lad25
        bcc la798
la7a5   inc lad26
        bcs la798
la7aa   ldx lad24
        lda zpLatitude
        sec
        sbc $cdcc,x
        bcs la7be
la7b5   sta lad33
        sec
        lda #$00
        sbc lad33
la7be   ldy #$00
        sty lad27
        sty lad28
        tay
        tax
        inx
la7c9   dex
        beq la7db
la7cc   tya
        clc
        adc lad27
        sta lad27
        bcc la7c9
la7d6   inc lad28
        bcs la7c9
la7db   clc
        lda lad27
        adc lad25
        sta lad25
        lda lad28
        adc lad26
        sta lad26
        bcc la7f6
la7f0   lda #$ff
        sta lad25
        rts
la7f6   ldy #$01
        sty lad27
        dey
        sty lad28
la7ff   sec
        lda lad25
        tax
        sbc lad27
        sta lad25
        lda lad26
        sbc lad28
        sta lad26
        bcc la825
la815   iny
        lda lad27
        adc #$01
        sta lad27
        bcc la7ff
la820   inc lad28
        bcs la7ff
la825   sty lad25
        stx lad26
        tya
        rts
la82d   clc
        adc #$b8
        sta zpMapPtr
        txa
        adc #$0b
        sta $4d
        lda zpMapPtr
        cmp #$0f
        lda $4d
        sbc #>9999
        bcc la846
la841   lda #$0f
la843   ldx #>9999
        rts
la846   lda zpMapPtr
        ldx $4d
        rts
la84b   lda #$ff
        jsr $16a0
la850   lda #$ff
        jsr $16a0
la855   lda #$ff
        jmp $16a0
la85a   lda #$06
        sta zpCursorRow
        jsr $83f6
la861   jsr print
        .asc ""
        .byt $7e,$00
la866   jsr $164f
la869   lda zpCursorRow
        cmp #$0e
        bne la861
la86f   lda #$0a
        sta zpCursorRow
        rts
la874   jsr $8777
la877   ldy #$18
la879   jsr $85db
la87c   bne la884
la87e   jsr $16a0
la881   dey
        bne la879
la884   jmp $8777
la887   .asc ""
        .byt $60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60
        .asc ""
        .byt $60,$60,$60,$60,$60,$60,$60,$60
la89f   bvc la8f1
la8a1   bpl la843
        .asc ""
        .byt $70,$70
la8a5   bvs $a917
la8a7   bvs $a919
la8a9   bpl $a8bb
la8ab   bpl $a8bd
la8ad   bpl $a8bf
la8af   bpl $a8c1
la8b1   bpl $a8c3
la8b3   bpl $a8c5
la8b5   bpl $a8c7
la8b7   bpl $a8c9
la8b9   bpl $a8cb
la8bb   bpl $a8cd
la8bd   bpl $a8cf
la8bf   bpl $a8d1
la8c1   bpl $a8d3
la8c3   bpl $a8d5
la8c5   bpl $a8d7
la8c7   ldy #$a0
la8c9   ldy #$a0
la8cb   ldy #$a0
la8cd   ldy #$a0
la8cf   ldy #$a0
la8d1   ldy #$a0
la8d3   ldy #$a0
la8d5   ldy #$a0
la8d7   ldy #$a0
        ldy #$a0
        ldy #$a0
        ldy #$a0
        ldy #$a0
        bpl $a8f3
la8e3   bpl $a8f5
la8e5   bpl $a8f7
la8e7   bpl $a8f9
la8e9   bpl $a8fb
la8eb   bpl $a8fd
la8ed   bpl $a8ff
la8ef   bpl $a901
la8f1   bpl $a903
la8f3   bpl $a905
la8f5   bpl $a907
la8f7   bpl $a909
la8f9   bpl $a90b
la8fb   bpl $a90d
la8fd   bpl $a90f
la8ff   bpl $a911
la901   bpl $a913
la903   bpl $a915
la905   bpl $a917

la907
        .aasc " Super Duper Transport, Inc",$ae
        .aasc " Horse and Carriage Transpor",$f4
        .aasc " The Reliable Transportation",$7e,$7f
        .aasc $0c,"Shopp",$e5,$7f
        .aasc $06,"Quality Transpor",$f4,$7f
        .aasc $04,"Comfort Ride Tranport",$f3
        .aasc "O.K. New & Used Transportatio",$ee,$7f
        .aasc $0a,"Sly Sam'",$f3
        .aasc "  Transportation Specialist",$f3,$7f
        .aasc $09,"Pub de Var",$e7,$7f
        .aasc $07,"Ye Old Local Pu",$e2,$7f
        .aasc $08,"Dr. Cat's Lai",$f2,$7f
        .aasc $06,"Dav's House-O-Sud",$f3,$7f
        .aasc $03,"The Slaughtered Lamb In",$ee,$7f
        .aasc $05,"The Blue Boar Taver",$ee,$7f
        .aasc $09,"The Open Ke",$e7,$7f
        .aasc $07,"The Running Ta",$f0
        .aasc " Chad the Mad's Magic Shopp",$e5,$7f
        .aasc $07,"Mystic Melinda'",$f3,$7f
        .aasc $08,"Words of Powe",$f2
        .aasc "Psychic Sam's Magical Emporiu",$ed,$7f
        .aasc $03,"The Alchemist's Worksho",$f0,$7f
        .aasc $07,"The Crystal Bal",$ec,$7f
        .aasc $06,"Herbs and Potion",$f3,$7f
        .aasc $05,"The Unleashed Spel",$ec
        .aasc "  The Armour Shoppe of Lord",$7e,$7f
        .aasc $05,"Eldric D'Charbonneu",$f8,$7f
        .aasc $08,"Max's Armour",$f9,$7f
        .aasc $08,"The Iron Fis",$f4,$7f
        .aasc $05,"The Hammer -n- Anvi",$ec
        .aasc "Defense Specialties, Unlimite",$e4,$7f
        .aasc $08,"The Armour Bi",$ee,$7f
        .aasc $05,"Protective Product",$f3,$7f
        .aasc $05,"Custom Armour Work",$f3,$7f
        .aasc $03,"Naughty Nomaan's Weapon",$f3,$7f
        .aasc $06,"The Tempered Stee",$ec,$7f
        .aasc $07,"The Razor's Edg",$e5,$7f
        .aasc $06,"The Polished Hil",$f4,$7f
        .aasc $07,"The Bloody Blad",$e5,$7f
        .aasc $08,"The Duelo Sho",$f0,$7f
        .aasc $07,"Weaponry Suppl",$f9,$7f
        .aasc $05,"Cold Steel Creation",$f3,$7f
        .aasc $03,"Little Karelia's Finnish",$7e,$7f
        .aasc $0b,"Grocer",$f9,$7f
        .aasc $04,"Adventurer Supply Pos",$f4,$7f
        .aasc $08,"The Brown Ba",$e7,$7f
        .aasc $0a,"The Marke",$f4,$7f
        .aasc $04,"Fresh Food Marketplac",$e5,$7f
        .aasc $06,"Rations Unlimite",$e4,$7f
        .aasc $04,"Fast Fresh Foodmarke",$f4,$7f
        .aasc $03,"Exploration Provisioner",$f3

lad24
        .byt $00
lad25
        .byt $00
lad26
        .byt $00
lad27
        .byt $00
lad28
        .byt $00
lad29   lad2a = * + 1
        lad2b = * + 2
        lad2c = * + 3
        lad2d = * + 4

        lad2e = * + 5
        lad2f = * + 6
        lad30 = * + 7
        lad31 = * + 8
        lad33 = * + 10
        lad34 = * + 11
        lad35 = * + 12
        lad36 = * + 13
        lad37 = * + 14
        lad38 = * + 15
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
lad39
        .aasc "Kin",$e7
        .aasc "Merchan",$f4
        .aasc "Princes",$f3
        .aasc "Guar",$e4
        .aasc "Jeste",$f2
lad58
        .aasc "Wenc",$e8,$00
lad5e
        .aasc "Leche",$f2
lad64
        .byt $00


        .byt $26
lad66   jmp l9872
lad69   ldx $0ae4,y
        bmi ladc4
        .asc ""
        .byt $7c
lad6f   ldx #$c8
        inc $3a14
        rts
        lad76 = * + 1
        lad7c = * + 7
        .byt $86,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$02
        lad88 = * + 3
        .byt $02,$02,$02,$01,$01,$01,$01,$01,$01,$01,$03,$01,$01,$01,$01,$03
        lad98 = * + 3
        .byt $01,$03,$03,$1e,$5f,$5f,$2f,$5c,$5f,$02,$07,$08,$07,$03,$0c,$04
        lada6 = * + 1
        ladaf = * + 10
        .byt $0b,$00,$00,$01,$01,$02,$02,$03,$04,$05,$01,$01,$01,$00,$00,$01
ladb5   ladb6 = * + 1
        ora ($00,x)
        ora ($04,x)
ladb9   ora #$10
        ora $3124,y
        rti
ladbf   eor ($64),y
        adc $a990,y
ladc4   cpy $e1
ladc6   ladc7 = * + 1
        .byt $17
        .asc "+"
        .byt $71
        .asc ",U+"
        .byt $67
        .asc "*U)"
        ladd2 = * + 2
        ladd3 = * + 3
  .word la907,l94c3,l959e,l96ca,l98d2,l99c1
        .asc ""
        .byt $23,$9e
ladde   laddf = * + 1
        ladea = * + 12
        ladeb = * + 13
  .word l9fc7,la0c8,l97b7,la11d,la13e,la0eb,l9b2e,l9b8c
  .word l9bab,l9c1f
        .asc ""
        .byt $40,$9c
  .word l9c6a,l9ca7,l9cc3
        lae00 = * + 6
        .byt $00,$01,$00,$01,$00,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$01,$00,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$00,$00,$00,$00
        .byt $00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01
        .byt $00,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00
lae5a   .byt $8d
