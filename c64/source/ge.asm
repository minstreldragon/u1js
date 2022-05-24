#include "archdep.h"

playerSlot = $c4f8

        .word $8c9e
        * = $8c9e

mainMenu
l8c9e   ldx #$11
        jsr loadFile            ; load "RO",
_mainMenuL1
l8ca3   jsr $1655               ; home?
        lda #$00
        sta $5d
        sta $5c
        jsr l94d7
        jsr l94c0
        ldy #6
        ldx #12
        jsr printAtPos
        .aasc $1b,$1b,$1b," Ultima I ",$1b,$1b,$1b,LF,LF,CR
        .aasc $0e,"from darkest",LF,CR
        .aasc $0e,"dungeons, to",LF,CR
        .aasc $0d,"deepest space!",LF,LF,LF,CR
        .aasc $07,"a) Generate new character",LF,CR
        .aasc $07,"b) Continue previous game",LF,$7c,CR
        .aasc $0d,"Thy choice: ",$00

        jsr $1664
_mainMenuL2
        jsr $1676               ; get key
        pha
        jsr l94c0
        pla
        cmp #$41                ; 'A'
        bne _mainMenuJ1
        jmp _generateCharacter
_mainMenuJ1
        cmp #$42                ; 'B'
        bne _mainMenuL2
l8d5a   lda #$62                ; continue previous game
        jsr $1667
l8d5f   lda roster
        ora roster+$10
        ora roster+$20
        ora roster+$30
        beq l8da9
        jsr _selectPlayer
        lda playerSlot
        clc
        adc #$12
        tax
        jsr loadFile            ; load "P0" / "P1" / "P2" / "P3"
l8d7a   bcs l8d8a
l8d7c   lda $81e2
        cmp #$ca                ; copy protection?
        bne l8d8a
l8d83   lda $81e3
        cmp #$01
        beq l8ddd
l8d8a   jsr $870c
l8d8d   ldx #2
        ldy #20
        jsr printAtPos
        .aasc "Disk error.",$00

        jsr $8701
        jsr l948d
l8da6   jmp _mainMenuL1
l8da9   jsr $870c
l8dac   ldx #$02
        ldy #$15
        jsr printAtPos
        .aasc "Thou must first create a character.",$00
        jsr $8701
        jmp _mainMenuL2

l8ddd   ldy #$00
        lda #$30
        sta $01
        ldx #$0d
l8de5   l8de7 = * + 2
; Instruction parameter accessed.
        lda l95f7,y
        l8dea = * + 2
; Instruction parameter accessed.
        sta VicSprite0XPos,y    ; copy to $d000-dcff
        iny
        bne l8de5
l8dee   inc l8de7
        inc l8dea
        dex
        bne l8de5
l8df7   stx Cia2PortA
        lda #$36
        sta $01
        lda $81e7
        sta $1638
        lda #$60
        sta $5c
        jsr $84c0
l8e0b   jsr $165b
l8e0e   jsr $1649
l8e11   jsr $8689
l8e14   lda #$60
        sta $5d
        jsr $1664
l8e1b   jsr $1646
l8e1e   jmp $8c5e

_generateCharacter
l8e21   ldx #$00                ; character slot = 0
_genCharL1
l8e23   txa                     ; index = char slot * 16
        asl
        asl
        asl
        asl
        tay
        lda roster,y            ; character in use?
        bne _genCharJ1          ; yes ->
        jmp l8ee6
_genCharJ1
l8e31   inx                     ; inc character slot
        cpx #$04                ; max index reached?
        bcc _genCharL1          ; no, try next slot
        jsr l9598
        ldx #1
        ldy #14
        jsr printAtPos
        .aasc " Thou must first remove a character.",$7e
        .aasc " Enter a character number (1-4) or",$7e
        .aasc " space bar to return to main menu.",LF,LF,CR
        .aasc $0d,"Thy choice: ",$00

l8ebb
        jsr $1676               ; get key
        cmp #$20                ; space bar?
        bne l8ec5
        jmp _mainMenuL1

l8ec5   cmp #$31                ; '1'
        bcc l8ebb
l8ec9   cmp #$35                ; '5'
        bcs l8ebb
l8ecd   sec
        sbc #$31                ; make 0-based index
        tax
        stx playerSlot
        asl
        asl
        asl
        asl
        tax
        lda #$00
        sta roster,x
        ldx #$01
        jsr saveFile            ; "RO"
l8ee3   ldx playerSlot
l8ee6   stx playerSlot
        jsr $1655
l8eec   l8eed = * + 1
        jsr l94d7
l8eef   ldy #0
        ldx #8
        jsr printAtPos
        .aasc $0e," Character Generation ",$18,$7e,$00

        jsr l94c0
        lda #$e4
        sta l8f2b
        lda #$81
        sta l8f2c
        lda #$f7
        sta l8f28
        lda #$93
        sta l8f29
l8f27   l8f28 = * + 1
; Instruction parameter accessed.
        l8f29 = * + 2
        lda $ffff
        l8f2b = * + 1
; Instruction parameter accessed.
        l8f2c = * + 2
        sta $ffff
        inc l8f28
        bne l8f35
l8f32   inc l8f29
l8f35   inc l8f2b
        bne l8f3d
l8f3a   inc l8f2c
l8f3d   lda l8f28
        cmp #$7f
        bne l8f27
l8f44   lda l8f29
        cmp #$94
        bne l8f27
l8f4b   jsr l9359
l8f4e   lda #30
        sta _pointsLeft         ; initial points left to distribute: 30
        ldx #$01
        stx _attributeId
        ldy #$0f
        jsr printAtPos
        .aasc " Move cursor with up and down arrows,",$7e
        .aasc " increase and decrease attributes",$7e,
        .aasc " with left and right arrows.",$7e,
        .aasc " Press RETURN when finished,",$7e
        .aasc " or space bar to go back to main menu.",$00

l9006   jsr l9359
l9009   lda #$63
        sta $32
        jsr $1676               ; get key
l9010   tay
        lda _attributeId
        asl
        tax
        cpy #$20
        bne l901d
l901a   jmp _mainMenuL1
l901d   cpy #KEY_WEST
        bne l9030
l9021   lda $823b,x
        cmp #10                 ; minimum value (10)?
        beq l9006               ; yes ->
        dec $823b,x             ; dec attribute value
        inc _pointsLeft
        bne l9006

l9030   cpy #KEY_EAST
        bne l9048
        lda _pointsLeft         ; character points left?
        beq l9006               ; no ->
        lda $823b,x
        cmp #25                 ; maximum value (25)?
        bcs l9006               ; yes ->
        inc $823b,x             ; inc attribute value
        dec _pointsLeft
        bpl l9006

l9048   cpy #KEY_SOUTH
        bne l905d
        inc _attributeId        ; inc attribute id
        lda _attributeId
        cmp #$07                ; attribute too large (7)?
        bcc l9006               ; no ->
        lda #$01                ; revert to first attribute
        sta _attributeId
        beq l9006

l905d   cpy #KEY_NORTH
        bne l906d
        dec _attributeId        ; dec attribute id
        bne l9006               ; attribute too small (0)? no ->
        lda #$06                ; revert to last attribute
        sta _attributeId
        bne l9006

l906d   cpy #$0d                ; key = return?
        bne l9006               ; no ->

l9071   ldy _pointsLeft
        beq l907c
l9076   jsr $8772
l9079   jmp l9006
l907c   sty _attributeId
        jsr l9359
l9082   jsr l94c0
l9085   ldy #$12
        ldx #$0b
        jsr printAtPos
        .aasc "a) Human",LF,CR
        .aasc $0b,"b) Elf",LF,CR
        .aasc $0b,"c) Dwarf",LF,CR
        .aasc $0b,"d) Bobbit",$00

        ldy #16
        ldx #2
        jsr printAtPos
        .aasc "Select thy race: ",$00

_selectRaceL1
l90ce
        jsr $1676               ; get key
        cmp #$41                ; 'A'?
        bcc _selectRaceL1
        cmp #$45                ; 'E'?
        bcs _selectRaceL1
        sec
        sbc #$40                ; convert to 0-based index
        sta statsRace

        ldy #12
        ldx #13
        jsr printAtPos
        .aasc "Race  ",$00

        ldx statsRace
        jsr $8426               ; print from string table (?)
        .word $7763             ; _strTableRace
        jsr l94c0
        lda statsRace
        cmp #$01                ; human?
        bne _selectRaceJ1
        lda statsIntelligence
        clc
        adc #$05                ; add bonus
        sta statsIntelligence
        bne l913a
_selectRaceJ1
        cmp #$02                ; elf?
        bne _selectRaceJ2
        lda statsAgility
        clc
        adc #$05                ; add bonus
        sta statsAgility
        bne l913a
_selectRaceJ2
l9119   cmp #$03                ; dwarf?
        bne _selectRaceJ3
        lda statsStrength
        clc
        adc #$05                ; add bonus
        sta statsStrength
        bne l913a
_selectRaceJ3
        lda statsWisdom         ; bobbit
        clc
        adc #$0a
        sta statsWisdom
        lda statsStrength
        sec
        sbc #$05                ; add bonus
        sta statsStrength

l913a   jsr l9359
l913d   ldy #18
        ldx #11
        jsr printAtPos
        .aasc "a) Male",LF,CR
        .aasc $0b,"b) Female",$00

        ldy #16
        ldx #2
        jsr printAtPos
        .aasc "Select thy sex: ",$00

_selectSexL1
        jsr $1676               ; get key
        cmp #$41                ; 'A'
        bcc _selectSexL1
        cmp #$43                ; 'C'
        bcs _selectSexL1
        sec
        sbc #$41                ; make 0-based value
        sta statsGender
        ldy #13
        ldx #14
        jsr printAtPos
        .aasc "Sex  ",$00
        ldx statsGender
        jsr $8426               ; print from string table (?)
        .word _strTableGender

        jsr l94c0
        ldy #18
        ldx #11
        jsr printAtPos
        .aasc "a) Fighter",LF,CR
        .aasc $0b,"b) Cleric",LF,CR
        .aasc $0b,"c) Wizard",LF,CR
        .aasc $0b,"d) Thief",$00

        ldy #16
        ldx #2
        jsr printAtPos
        .aasc "Select thy class: ",$00

_selectClassL1
l91e8   jsr $1676               ; get key
        cmp #$41                ; 'A'
        bcc _selectClassL1
        cmp #$45                ; 'E'
        bcs _selectClassL1
        sec
        sbc #$40                ; make 0-based value
        sta statsClass
        ldy #14
        ldx #12
        jsr printAtPos
        .aasc "Class  ",$00

l9208   ldx statsClass
        jsr $8426               ; print from string table (?)
        .word strTableClass
        lda statsClass
        cmp #$01                ; Fighter?
        bne _selectClassJ1
        lda statsStrength
        clc
        adc #10                 ; add class bonus
        sta statsStrength
        lda statsAgility
        clc
        adc #$0a
        sta statsAgility
        bne _selectClassJ4
_selectClassJ1
        cmp #$02                ; Cleric?
        bne _selectClassJ2
        lda statsWisdom
        clc
        adc #10                 ; add class bonus
        sta statsWisdom
        bne _selectClassJ4
_selectClassJ2
        cmp #$03                ; Wizard?
        bne _selectClassJ3
        lda statsIntelligence
        clc
        adc #10                 ; add class bonus
        sta statsIntelligence
        bne _selectClassJ4
_selectClassJ3
        lda statsAgility        ; Thief
        clc
        adc #10                 ; add class bonus
        sta statsAgility
_selectClassJ4
        jsr l9359
l9255   jsr $1670
l9258   sta $8264
        jsr $1670
l925e   sta $8265
        ldy #$10
        ldx #$02
        jsr printAtPos
        .aasc "Enter thy name: ",$00

        jsr $94c0
        lda #$00
        sta l93ea               ; index name character
_enterNameL1
l9281   jsr $1676               ; get key
        ldx l93ea
        cmp #KEY_RETURN         ; return key?
        bne _enterNameJ1
        txa                     ; index name character
        beq _enterNameL1        ; name empty ->
l928e   dec zpCursorRow
        jsr l94c0
        lda #11
        sta zpCursorCol
        lda #3
        sta zpCursorRow
        jsr $8ba1
        jmp l92f4
_enterNameJ1
l92a1   cmp #KEY_WEST           ; cursor left (backspace)
        beq _enterNameBs
        cmp #KEY_BACKSPACE
        bne _enterNameJ2
_enterNameBs
        dex
        bmi _enterNameL1
        stx l93ea
        lda #$00
        sta statsName,x
        dec zpCursorCol
        jmp _enterNameL1
_enterNameJ2
        cpx #$00
        bne _enterNameJ4
        cmp #$41                ; 'A'
        bcc _enterNameL1
        cmp #$5b                ; 'Z'+1
        bcs _enterNameL1
_enterNameJ3
l92c5   sta statsName,x         ; store character in name
        inc l93ea
        jsr $83d7
        jmp _enterNameL1

_enterNameJ4
l92d1   cpx #$0d
        bcs _enterNameL1
        cmp #$20
        bcc _enterNameL1
        cmp #$40
        beq _enterNameL1
        cmp #$2f
        beq _enterNameL1
        cmp #$41                ; 'A'
        bcc _enterNameJ3
        cmp #$5b                ; 'Z'+1
        bcs _enterNameJ3
        ldy statsGender,x
        cpy #$20
        beq _enterNameJ3
        ora #$20
        bne _enterNameJ3

l92f4   jsr l947f
        .aasc $7e," Save this character? (Y-N) ",$00
        jsr l94c0
        jsr $1676               ; get key
        jsr $1667
        cmp #$59                ; 'Y'
        beq _saveCharacter
        cmp #$4e                ; 'N'
        bne l92f4
        jmp _generateCharacter

_saveCharacter
l9329   lda playerSlot
        asl
        asl
        asl
        asl
        tax
        lda #$ff
        sta roster,x            ; mark roster entry as used
        ldy #$00
        inx
        inx
        inx
_saveCharacterL1
        lda statsName,y         ; copy player name
        sta roster,x            ; to roster
        inx
        iny
        cpy #$0d
        bcc _saveCharacterL1
        ldx #$01
        jsr saveFile            ; save "RO"

        lda playerSlot
        clc
        adc #$02
        tax                     ; filename P0/P1/P2/P3
        jsr saveFile            ; save "P<x>"
        jmp _mainMenuL1

l9359   lda #$00
        sta $85be
        sta $81c4
        ldx #$05
        stx zpCursorCol
        ldy #$03
        sty zpCursorRow
        lda _attributeId
        beq l9393
        jsr print
        .aasc "Points left to distribute: ",$00
        lda _pointsLeft
l9390   jsr $8582
l9393   dec $2f
        jsr $164f
l9398   inc $2f
        jsr $83f3
l939d   inc $81c4
        inc zpCursorRow
        ldx #10
        stx zpCursorCol
        lda #$20
        ldx $81c4
        cpx _attributeId
        bne l93b2
l93b0   lda #$0e
l93b2   jsr $83d7
        jsr $8426               ; print from string table (?)
        .word strTableAttributes
        lda #$2e                ; '.'
        sta $85be
l93bf   jsr $83d7
        ldx zpCursorCol
        cpx #26
        bcc l93bf
l93c8   lda $81c4
        asl
        tax
        lda $823b,x
        jsr $8582
l93d3   lda #$20
        ldx $81c4
        cpx _attributeId
        bne l93df
l93dd   lda #$18
l93df   jsr $83d7
l93e2   cpx #$06
        bcc l939d
l93e6   rts

_pointsLeft
l93e7
        .byt $00
        .byt $00
_attributeId
l93e9
        .byt $00
l93ea
        .byt $00

_strTableGender
l93eb
        .aasc "mal",$e5
        .aasc "femal",$e5

        .byt $ca
        .byt $01,$00,$00,$ff,$ff,$27,$21,$00,$00,$00,$00,$00,$01,$01,$00,$01
        .byt $01,$00,$00,$00,$00,$01,$02,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$96,$00,$0a,$00,$0a,$00,$0a,$00
        .byt $0a,$00,$0a,$00,$0a,$00,$64,$00,$01,$00,$01,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$95
        .asc "H"
        .byt $00,$00,$00
        .asc "h"
        .byt $03
        .asc "h"
        .byt $03,$00
        .byt $ff
        .asc "o>"
        .byt $00,$00,$00,$00,$00,$00

l947f   ldx #$02
        stx zpCursorCol
        ldy #$14
        sty zpCursorRow
        jsr l94c0
l948a   jmp print

l948d   ldx #$02
        ldy #$15
        jsr printAtPos
l9494   bvc l9508
        .asc ""
        .byt $65,$73,$73
l9499   jsr $7053
        .asc ""
        .byt $61,$63,$65
l949f   jsr $6f74
l94a2   jsr $6f63
        .asc ""
        .byt $6e,$74,$69,$6e,$75
l94aa   adc $3a
        jsr $2000
l94af   ror $16,x
        jsr $83f6
l94b4   lda #$14
        sta zpCursorRow
        bne l94c0
l94ba   jsr $1655
l94bd   jsr l9519

l94c0   jsr $870c
l94c3   dec $2f
l94c5   jsr $164f
l94c8   jsr $83f6
l94cb   inc zpCursorRow
        ldy zpCursorRow
        iny
        cpy $31
        bcc l94c5
l94d4   jmp $8701
l94d7   lda #$10
        jsr $83d7
l94dc   ldx #$26
        lda #$04
        jsr $84b9
l94e3   lda #$12
        jsr $1667
l94e8   inc zpCursorRow
        jsr $8411
l94ed   lda #$0a
        jsr $1667
l94f2   lda #$27
        sta zpCursorCol
        lda #$08
        jsr $1667
l94fb   jsr $1673
l94fe   lda zpCursorRow
        eor #$16
        bne l94e8
l9504   sta zpCursorCol
        inc zpCursorRow
l9508   lda #$14
        jsr $83d7
l950d   ldx #$26
        lda #$02
        jsr $84b9
l9514   lda #$16
        jsr $1667
l9519   ldx #$01
        stx zpCursorCol
        stx zpCursorRow
        rts


_selectPlayer
l9520   jsr l9598
        ldx #5
        ldy #14
        jsr printAtPos
        .aasc "Select a character (1-4) or",$7e,CR
        .aasc $04,"space bar to return to menu.",LF,LF,CR
        .aasc $0d,"Thy choice: ",$00

_selectPlayerL1
        jsr $1676               ; get key
        cmp #$20                ; space bar?
        bne _selectPlayerJ1
        jmp _mainMenuL1
_selectPlayerJ1
        cmp #$31                ; '1'
        bcc _selectPlayerL1
        cmp #$35                ; '5'
        bcs _selectPlayerL1
        sec
        sbc #$31                ; make 0-based index
        sta playerSlot
        asl
        asl
        asl
        asl
        tax
        lda roster,x
        beq _selectPlayerL1
        rts

l9598   jsr $1661
l959b   lda #$00
        sta l95f5
l95a0   lda #$0d
        sta zpCursorCol
        lda l95f5
        clc
        adc #$08
        sta zpCursorRow
l95ac   lda l95f5
        clc
        adc #$31
        jsr $1667
l95b5   inc zpCursorCol
        lda #$2e
        jsr $1667
l95bc   inc zpCursorCol
        lda #$20
        jsr $1667
l95c3   inc zpCursorCol
        lda #$0c
        sta l95f6
        lda l95f5
        asl
        asl
        asl
        asl
        tax
        lda roster,x
        beq l95ea
l95d7   inx
        inx
        inx
l95da   lda roster,x
        beq l95ea
l95df   jsr $1667
l95e2   inc zpCursorCol
        inx
        dec l95f6
        bpl l95da
l95ea   inc l95f5
        lda l95f5
        cmp #$04
        bcc l95a0
l95f4   rts
l95f5   l95f6 = * + 1
        l95f7 = * + 2
        .byt $00,$00,$08,$00
        .asc "g"
        .byt $02
l95fb   cli
        asl $b6
        ora #$f8
        sed
        bmi l961d
        .asc ""
        .byt $21,$78,$19
        .asc "X"
        .byt $09,$0a,$19
l960a   bmi l9626
        .asc ""
        .byt $31,$60,$11,$0d,$11,$48,$09,$12,$09,$68,$09,$2a,$09,$28,$22
l961b   and ($58),y
l961d   ora $2348,y
        .byt $1a
l9621   ora #$58
        ora #$1a
        l9626 = * + 1
; Instruction parameter jumped to.
        l9627 = * + 2
; Instruction parameter jumped to.
        ora $090a
l9628   jsr $0b1a
        .byt $0a,$09,$0b,$29
        .asc "("
        .byt $19,$0f,$0b,$2a,$09
l9635   bvc l9640
        .asc ""
        .byt $22,$09
l9639   jsr $3b12
l963c   and ($90,x)
        and ($3a),y
l9640   ora #$50
        ora #$22
        ora #$18
        .asc ""
        .byt $22,$13,$0f,$1b,$31
l964b   bvs l968e
        .asc ""
        .byt $22,$0b,$12,$09
l9651   bvc l965c
        .byt $12,$11,$18,$2a,$0b,$09,$0b,$12
l965b   l965c = * + 1
; Instruction parameter jumped to.
        eor ($58,x)
        eor ($1a),y
        .byt $0b,$09,$0a,$1b,$40,$19,$28,$11,$3a,$81,$18,$61,$12,$23,$0a,$09
        .byt $88,$11,$2a,$91,$18,$61,$12,$0b,$12,$19,$80
l967a   ora la11a,y
        bpl l96d8
        l968e = * + 15
        .asc ""
        .byt $2a,$21,$88
        .asc "A"
        .byt $28,$31,$0b,$3a,$29,$80
        .asc "I"
        .byt $28,$29,$0b,$12,$0b
        .byt $1a,$49
l9691   bvs l965c
l9693   jsr $2329
        .asc ""
        .byt $22,$49,$68
        .asc "y"
        .byt $29,$23,$0a,$13,$41
l969f   jsr $3811
        .asc "y"
        .byt $31,$0b,$0f,$1b,$39,$0e
l96a9   jsr $2821
        .asc ""
        .byt $69,$18
        .asc "A"
        .byt $13,$41
l96b1   jsr $2829
        .asc ""
        .byt $61,$28,$39,$0b,$81,$13,$39,$18,$31,$28,$11,$0a,$49
l96c1   bmi l96f4
        .byt $13,$19,$12,$59,$13,$79,$28,$09,$22,$39
l96cd   bmi l96f0
        .asc ""
        .byt $2b,$09,$0a,$0b,$22
l96d4   eor #$0b
        ora ($0b),y
l96d8   adc ($20,x)
        asl
        ora #$22
        eor #$20
        .byt $0c,$23,$1a,$23,$0a,$61,$5b,$0a,$21
l96e8   jsr $513a
        .byt $0b
l96ec   bpl l96f9
l96ee   clc
        l96f0 = * + 1
        l96f4 = * + 5
        .asc ""
        .byt $22,$13,$12,$09,$0e,$1a,$39,$0b,$22,$0b
l96f9   asl
        .byt $13,$1a,$21
l96fd   jsr $4942
        .byt $13
l9701   l9702 = * + 1
; Instruction parameter jumped to.
        bmi l976d
l9703   and ($13),y
        .byt $0f,$0b,$1a,$0b,$1a,$29,$18,$52,$39,$13,$40,$6a,$29,$13,$4a,$21
l9715   jsr $295a
        .asc ""
        .byt $58,$62,$39,$13,$0a,$0b,$2a,$29
l9720   jsr $214a
        .asc ""
        .byt $78,$12,$09,$3a,$49,$23,$22,$29
l972b   jsr $2932
        .byt $88,$0a,$21,$22,$69,$13,$1a,$29,$28,$2a,$0e
        .asc "(9"
        .byt $13,$1a,$19
l973e   sed
        bpl l9702
        .byt $13,$1a,$11
        .asc "("
        .byt $1b,$40
        .asc "I"
        .byt $0b,$2a,$09
        .asc " "
        .byt $13,$0f,$13,$38
        .asc "Q"
        .byt $0a,$11,$12,$09
        .asc "("
        .byt $0b
l9757   ora #$0b
        rti
        .byt $09,$0c
        .asc "a"
        .byt $50,$09,$12,$11,$98,$0e,$11,$22
        .asc "!"
        .byt $58,$2a,$0b,$12
        .byt $11
l976b   bcc l977f
l976d   php
        .asc ""
        .byt $22,$91,$28,$12
l9772   jsr $130a
        .byt $12,$13,$12
l9778   ora #$0b
        bvs l978e
l977c   jsr $892a
l977f   asl $1a18
        clc
        .byt $1b,$42,$13,$11
l9787   bvc l9792
        .byt $1a,$08,$42
l978c   sta ($22),y
l978e   jsr $0f0b
        l9792 = * + 1
        .byt $0b,$12,$13,$2a,$0b,$19
l9797   pha
        ora ($12),y
        bpl l97ad
        .asc ""
        .byt $2a,$89,$22,$28,$0b,$1a,$13,$12,$0b,$1a,$0b,$19,$48,$19,$4a,$89
        .asc ""
        .byt $22
l97ad   ora ($20),y
        .byt $0b,$12,$13,$1a,$0b,$12,$13,$19,$0a,$38,$31,$2a,$81,$32,$21,$18
        .byt $13,$32,$0b,$12,$0b
l97c4   and ($12,x)
        plp
        eor ($1a,x)
        adc $1152,y
        jsr $120b
        .asc ""
        .byt $2b,$12,$13,$21,$12,$08,$12
        .asc "I"
        .byt $6a,$09
l97d9   jsr $0912
        .byt $0b,$3a,$13,$19,$12
l97e1   bpl l97f5
l97e3   cmp ($12,x)
        .byt $13,$12
l97e7   bpl l980b
l97e9   ora ($20),y
        ora #$1b
        l97f5 = * + 8
        .byt $12,$1b,$09,$12,$0b,$21,$12,$08,$12
        .asc "I"
        .byt $0a,$0b,$0f,$09,$0a,$18
        .byt $12,$11,$28,$09,$0b,$1a,$13
l9804   ora #$13
        ora #$13
        and ($12,x)
        l980b = * + 1
        bpl l9826
        .asc "A"
        .byt $0b,$11,$28,$19,$28,$1b,$0a,$13,$19,$1b,$31,$12,$08,$22
l981b   lda ($1b),y
        ora #$70
        ora #$22
        adc ($12,x)
        bpl l9836
l9825   asl
l9826   lda #$13
        php
        .byt $13
l982a   bvs l983d
        .byt $12,$71,$22
        .asc ")"
        .byt $08,$13
l9832   bpl l983f
l9834   ora #$70
l9836   lda ($1a,x)
        lda ($20,x)
        .byt $13
l983b   ora #$70
l983d   l983f = * + 2
; Instruction parameter jumped to.
        sbc $0879,y
        .byt $0b,$11
l9842   bvs l988d
        .byt $1a,$91,$13,$71
l9848   bcc l986b
        .byt $13,$09,$18,$1a,$81,$13,$99
l9851   bvs l9874
        .byt $0b,$38,$12,$71,$13
        .asc "!"
        .byt $68,$21,$0a,$0b,$38,$12,$51,$1b,$09,$0b
        l986b = * + 8
        .asc ")"
        .byt $68,$19,$12,$0b,$11,$18,$11,$1a,$39,$1b,$0f,$1b
        .asc "!"
        .byt $40,$13
l9873   clc
l9874   and #$1a
        ora #$1b
        ora #$0e
        rol
        and $310b,y
        sec
        eor $1138,y
        .byt $0b,$18,$31,$2a,$0b
l9887   ora $1932,y
        dey
        eor ($30),y
l988d   ora $180b,y
        and $091a,y
        .byt $1b,$32
l9895   ldy #$0e
        eor ($0a),y
        jsr $0e11
l989c   ora #$0b
        jsr $0b59
        .asc ""
        .byt $32,$88,$69,$42,$19,$0b
l98a7   jsr $6081
        .asc ""
        .byt $23
l98ab   adc ($5a),y
        ora #$13
        jsr $6871
        .byt $13
l98b3   ora ($0b),y
        adc $1352,y
        jsr $7061
        .asc ""
        .byt $23,$31,$33,$41,$3a,$13,$28,$39
l98c3   bcc l98d0
        .byt $0f
l98c6   and #$13
        ora #$13
        jsr $213b
        .asc ""
        .byt $22,$13
l98cf   l98d0 = * + 1
; Instruction parameter jumped to.
        bmi l98e2
l98d1   clv
        .byt $0b,$11,$28,$1b,$58,$23
l98d8   ora ($0a),y
        sed
        sed
        bvc l98de
l98de   sed
        sed
        sed
        sed
l98e2   rti
        .asc ""
        .byt $22,$09
l98e5   bvs l9909
l98e7   rti
        .asc ""
        .byt $2b,$78,$11,$18,$19,$18,$32,$19,$48,$42,$28,$12,$0b,$0f,$12,$13
        .byt $0a,$11,$0b,$48,$49
l98fd   bpl l9921
        l9909 = * + 10
        .byt $0b,$1a,$21,$18,$29,$3a,$28,$0a,$1b,$2a,$1b,$09,$38,$49,$18,$1a
        .byt $13,$22
l9911   eor #$4a
        jsr $0a09
        .byt $0b,$1a,$0b,$12,$09,$0b,$0a,$0b
l991e   asl
        ora #$30
l9921   eor #$18
        asl
        ora #$12
        .byt $13,$22,$39,$52
l992a   jsr $132a
        .byt $0a,$1b,$22
l9930   jsr $0a11
        .asc ""
        .byt $41,$18,$21,$1b,$1a
l9938   eor ($4a,x)
        jsr $1322
        .byt $12,$0b,$1a,$0b,$12,$18,$11,$1a,$39
l9946   clc
        ora $0f13,y
        ora #$1a
        eor ($3a,x)
        ora #$0e
        jsr $1309
        .byt $0a,$0b,$1a,$0b,$12,$13
l9959   asl
        jsr $1223
        .asc ""
        .byt $31,$18,$21,$1b,$12,$59,$2a,$09,$28,$09,$0a,$0b,$2a,$0b,$0a,$13
l996d   bmi l997a
l996f   clc
        .byt $1a,$21
l9972   jsr $1321
        .byt $12,$69,$22,$09
l9979   l997a = * + 1
        bmi l999d
        .asc ""
        .byt $23,$0a,$0b,$60,$12
l9980   and ($28,x)
        and ($0b,x)
        asl
        adc $1112,y
        bmi l9993
        .asc ""
        .byt $42,$13
l998c   bvc l9999
        .byt $12
l998f   and ($30,x)
        lda #$0a
l9993   ora ($30),y
        ora ($3a),y
        ora #$13
l9999   pha
        .byt $0b
l999b   asl
        l999d = * + 1
; Instruction parameter jumped to.
        and #$38
        lda ($40),y
        .byt $13,$12,$1b,$12
l99a4   ora #$0b
        jsr $200a
        .byt $1b,$21,$40
        .asc ")"
        .byt $48,$23,$08,$13,$0a,$13
l99b3   jsr $2012
        .byt $09,$13,$11,$50,$99,$80,$1b,$28,$12,$18,$0e,$09,$0b,$0a,$11
l99c5   bvc l9a20
l99c7   clc
        and #$c0
        ora #$2a
        .byt $09,$12,$11
l99cf   bvc l9a22
l99d1   jsr $2829
        .byt $0b
l99d5   dey
        ora $093a,y
        rts
l99da   eor #$28
        ora $1b28,y
        bmi l99f3
l99e1   bmi l9a1c
        .asc ""
        .byt $2a,$09,$60,$49,$28,$11,$0b,$28,$0b,$0f,$40,$1a
l99ef   jsr $2241
l99f2   l99f3 = * + 1
; Instruction parameter jumped to.
        bvs l9a3d
l99f4   jsr $281b
        .byt $1b,$40,$22
l99fa   bpl l9a3d
        .asc ""
        .byt $22
l99fd   bvs l9a50
l99ff   jsr $380b
        .byt $0b,$58,$22,$49,$12,$78,$61,$0c,$98,$0a,$18,$1a,$41,$0a,$80
l9a11   adc ($13,x)
        bcc l9a2f
l9a15   clc
        asl
        eor #$50
        ora ($20),y
        l9a1c = * + 1
        adc ($0b,x)
        tya
        ora #$22
l9a20   php
        .byt $12
l9a22   eor ($50,x)
        ora ($20),y
        adc ($0b,x)
        ldy #$11
        .byt $12
l9a2b   ora #$12
        eor ($48,x)
l9a2f   ora #$0d
        ora #$20
        eor $a813,y
        ora #$12
        ora ($0a),y
        and #$0b
        l9a3d = * + 1
; Instruction parameter jumped to.
        ora #$50
l9a3e   l9a3f = * + 1
; Instruction parameter jumped to.
        ora ($30),y
l9a40   eor ($0b),y
        .byt $12
l9a43   tay
        ora #$12
        and $090b,y
        bmi l9a5e
l9a4b   bpl l9a5e
l9a4d   sec
        ora #$08
l9a50   and #$1b
        .byt $1a,$58,$12,$09,$38,$41,$1b,$28,$0b,$0f
l9a5c   ora #$70
l9a5e   and #$13
        rol
        bmi l9a6c
        l9a6c = * + 9
        .byt $0e,$08,$1a,$09,$38,$39,$0b,$0f,$09,$28,$0b,$11,$48,$09,$28,$29
        .byt $13,$32,$18,$09,$0c,$09
l9a79   bpl l9a95
l9a7b   ora #$40
        and #$13
        ora #$20
        .byt $13,$09,$48,$21,$18,$31,$13,$22
l9a89   clc
        and ($0a,x)
        clc
        asl
        ora #$48
        and #$0b
l9a92   ora #$18
        .byt $1b
l9a95   ora #$40
        and #$18
        and #$0a
        .byt $13,$1a
l9a9d   jsr $1219
        .byt $08,$0a,$08,$12
l9aa4   bvc l9ab7
        .byt $1b,$09,$18,$0b
l9aaa   ora $3938,y
        bpl l9ad0
        .byt $0a,$13
l9ab1   rol
        clc
        ora $100a,y
        asl
l9ab7   ora #$1a
        pha
        ora #$13
        ora ($20),y
        .byt $0b,$19,$38,$69,$42,$09,$18,$11,$22,$09,$1a,$48,$13,$09
l9acc   bmi l9ae1
l9ace   ora #$0b
l9ad0   bmi l9b4b
l9ad2   asl
        ora ($2a),y
        jsr $4209
        .asc ""
        .byt $48,$0b,$09,$38,$19,$13
l9ade   jsr $790b
l9ae1   asl
        ora #$0e
        rol
        bmi l9b19
l9ae7   tya
        and ($0b,x)
        jsr $790b
l9aed   asl
        ora #$32
        bmi l9b1c
        .asc " "
        .byt $19,$13,$18,$09,$0b,$0f,$81,$32,$38,$22,$98,$19,$13
l9b00   jsr $130a
l9b03   asl
        and #$1b
        and $092a,y
        rti
        .byt $12
l9b0b   bvc l9b2e
l9b0d   bmi l9b28
        .byt $0b,$28,$2a,$21,$12,$0b
l9b15   eor ($1a,x)
        l9b19 = * + 2
; Instruction parameter jumped to.
        ora $4978,y
l9b1a   plp
        l9b1c = * + 1
        ora $280b,y
        ora #$2a
        ora $1312,y
        eor ($0a,x)
        and #$60
        l9b28 = * + 1
; Instruction parameter jumped to.
        adc #$18
        ora $300b,y
        l9b2e = * + 2
        .asc ""
        .byt $32,$09,$12,$23
l9b30   adc ($38),y
        sta ($08),y
        asl $0b19
        bmi l9b42
        .asc ""
        .byt $52,$0b,$0f
l9b3c   sbc $1369,y
        bmi l9b53
        .byt $1b
l9b42   rol
        .byt $1b
l9b44   sbc $0b69,y
        bmi l9b52
        l9b4b = * + 2
        .byt $12,$09,$13,$2a,$1b
l9b4e   sbc $0b61,y
        sec
l9b52   l9b53 = * + 1
        ora #$12
        .byt $0b,$1a,$09,$0a,$13
l9b59   ora #$13
        sbc $0b59,y
        rti
l9b5f   ora #$13
        asl
        and ($0b,x)
        ora $b133,y
        bpl l9bd2
        .byt $0b,$48,$0b,$0a,$59,$0b,$0a,$1b
        .asc ")"
        .byt $0b,$08,$69,$0b,$48,$0b,$61
        .byt $0b,$0a,$0f,$0a,$13,$71,$12,$19,$13,$08,$51,$0a,$11,$13,$50,$51
        .byt $13,$0a,$0b,$12,$0b
l9b8e   adc ($1a),y
        ora #$13
        jsr $1241
l9b95   ora ($0b),y
        rts
        .asc ""
        .byt $49,$0b,$1a,$13,$69,$12,$23
l9b9f   bpl l9bb4
l9ba1   php
        and $111a,y
        l9bb4 = * + 15
        .byt $0b,$68,$41,$13,$1a,$13,$61,$12,$0b,$0f,$09,$23,$09,$08,$39,$22
        .byt $09,$0b,$68,$41,$0b,$2a,$13,$51,$22,$19,$0b,$19,$08,$19,$18,$2a
        .byt $11,$68,$19,$0e
l9bc9   bpl l9bdc
        .byt $1b,$22,$1b
l9bce   eor ($2a,x)
        bvs l9bfc
l9bd2   ora #$18
        ora ($48),y
        ora ($18),y
        ora ($13),y
        l9bdc = * + 2
        .asc ""
        .byt $32,$0b,$12,$39,$1a,$80,$32
l9be1   bpl l9bec
        .byt $12,$09,$68,$11,$0b,$4a,$11
l9bea   bpl l9bfa
l9bec   ora ($22),y
        .byt $80,$2a,$18,$22
l9bf2   ora #$58
        ora $1a0b,y
        ora $111a,y
l9bfa   clc
        l9bfc = * + 1
        ora #$32
        sei
        rol
        clc
        ora #$22
        ora ($40),y
        and ($12,x)
        and ($1a),y
        ora #$18
        .asc ""
        .byt $42,$68,$09,$22,$0b
l9c0f   clc
        ora #$0a
        ora $091a
        sec
        adc ($12),y
        jsr $091a
        .asc ""
        .byt $22,$09,$58,$19,$12,$13,$18,$09,$2a,$09,$30,$89,$18,$1a,$11,$1a
        .byt $11
l9c2c   bvc l9c3f
l9c2e   asl $1311
        .asc ""
        .byt $28,$19,$0a,$09,$38,$69
l9c37   bmi l9c53
l9c39   php
        ora $190a,y
        pha
        .byt $0b
l9c3f   and ($13,x)
        pha
        ora ($40),y
        eor ($50,x)
        .byt $12,$18,$21,$58,$33
        .asc "xx"
        .byt $38,$00
l9c4f   sed
        sed
        l9c53 = * + 2
; Instruction parameter jumped to.
        jsr $3833
        eor ($50,x)
        .byt $12,$18,$21,$58,$33
l9c5b   bmi l9c70
l9c5d   ora ($0a),y
        ora #$13
        plp
        adc #$30
        .byt $1a,$08,$19,$0a,$19,$48,$0b,$21,$13,$28,$0b
l9c6f   rol
l9c70   ora #$0b
        plp
        .byt $89,$18,$1a
l9c76   ora ($1a),y
        ora ($50),y
        ora ($0e),y
        ora ($13),y
        jsr $0a0b
        .byt $0d,$1a
l9c83   ora #$0b
        bmi l9cf8
        .byt $12
l9c88   jsr $091a
        .asc ""
        .byt $22,$09,$58,$19,$12,$13,$18,$0b,$22,$11,$0b,$38,$21,$12,$31,$1a
        .byt $09,$18,$42,$68,$09,$22,$0b,$18,$0b,$1a,$09,$0b,$08,$0b,$40,$19
        .byt $0b,$1a,$19,$1a,$11,$18,$09,$32,$78,$2a,$18,$0b,$12,$09,$13,$58
        .byt $11,$0b,$4a,$11
l9cbf   bpl l9ccf
l9cc1   ora ($22),y
        l9ccf = * + 12
        .byt $80,$2a,$18,$2b,$60,$11,$13,$32,$0b,$12,$39,$1a,$80,$32,$80,$0e
l9cd3   bpl l9ce6
        .byt $1b,$22,$1b
l9cd8   eor ($2a,x)
        bvs l9d06
        .byt $09,$80,$29,$0b,$2a,$13
l9ce2   eor ($22),y
        l9ce6 = * + 2
; Instruction parameter jumped to.
        ora $190b,y
l9ce7   php
l9ce8   l9ce9 = * + 1
; Instruction parameter jumped to.
        l9cea = * + 2
; Instruction parameter jumped to.
        ora $2a18,y
        ora ($88),y
        and ($13,x)
        .byt $1a,$13,$61,$12,$0b,$0f
l9cf5   ora #$23
        l9cf8 = * + 1
; Instruction parameter jumped to.
        ora #$08
        and $0922,y
        .byt $0b,$98,$11,$0b,$1a,$13,$69,$12,$23
l9d05   l9d06 = * + 1
        bpl l9d1a
l9d07   php
        and $111a,y
        .byt $0b
        .asc " "
        .byt $13,$0a,$0b,$12,$0b
l9d12   adc ($1a),y
        ora #$13
        jsr $1241
l9d19   l9d1a = * + 1
        ora ($0b),y
        rti
        .byt $0b,$60,$0b,$0a,$0f,$0a,$13
l9d23   adc ($12),y
        ora $0813,y
        eor ($0a),y
        ora ($13),y
        rti
        .byt $0b,$0a,$58,$0b,$0a,$1b
l9d33   lda #$0b
        php
        adc #$0b
        rti
l9d39   ora #$13
        asl
        jsr $180b
        .asc ""
        .byt $33
        .asc "1"
l9d41   bpl l9dac
        .byt $0b,$38,$09,$12,$0b,$1a,$08,$0a,$13,$08,$13
l9d4e   sbc $0b59,y
        bmi l9d5c
        .byt $12,$09,$13,$2a,$1b
l9d58   sbc $0b61,y
        l9d5c = * + 1
        bmi l9d6f
        .byt $1b,$2a,$1b
        .asc "y"
        .byt $69,$0b,$28,$09,$52,$0b,$0f
        .asc "y"
        .byt $69,$13,$28,$32
        l9d6f = * + 2
        .byt $09,$12,$23
        .asc "y"
        .byt $41,$08,$0e,$19,$0b,$28,$09,$2a,$19,$12,$13,$41
        .byt $0a
        .asc "q"
        .byt $18,$19,$0b,$28,$2a,$21,$12,$0b,$41,$1a
        .asc "i"
        .byt $18,$19,$0b
        .asc ""
        .byt $28,$0a,$13,$0a,$29,$1b,$39,$2a,$49,$12,$89,$18,$19,$0b,$28,$09
        l9dac = * + 15
        .byt $0b,$0f,$81,$32,$39,$22,$81,$18,$19,$13,$28,$0b,$79,$0a,$09,$32
        .asc ""
        .byt $31,$2a,$81
l9db0   jsr $1319
l9db3   jsr $790b
        .byt $0a,$09,$0e,$2a,$31,$32,$79
l9dbd   jsr $0b21
        .asc ""
        .byt $28,$79,$0a,$11,$2a,$29,$42,$49,$0b,$21
l9dca   jsr $1319
l9dcd   bmi l9e38
        .asc ""
        .byt $42,$31,$22,$09,$1a,$49,$13,$21,$18,$13,$09,$0b,$38,$39
l9ddd   bpl l9e00
        .byt $0a,$13
l9de1   rol
        and ($0a),y
        bpl l9df0
l9de6   ora #$1a
        eor ($13),y
        ora $0b18,y
        ora $2940,y
l9df0   clc
        and #$0a
        .byt $13,$1a,$39,$12,$08,$0a,$08,$12,$61,$1b,$09,$18,$0b
l9e00   ora $2148,y
        clc
        and ($13),y
        .asc ""
        .byt $22,$39,$0a,$18,$0a,$79,$0b,$09,$18,$1b,$09
l9e11   bvc l9e1c
l9e13   plp
        .asc ""
        .byt $29,$13,$32,$21,$0c,$09
l9e1a   bpl l9e36
l9e1c   adc ($13),y
        ora #$20
        .byt $13
l9e21   ora #$78
        and #$13
        rol
        jsr $0e19
        l9e36 = * + 13
        .byt $08,$1a,$79,$0b,$0f,$09,$28,$0b,$11,$58,$09,$08,$29,$1b,$1a
l9e38   cli
        .byt $12,$81,$1b,$28,$0b,$0f,$09
l9e40   bpl l9e65
l9e42   jsr $0b51
        .byt $12
l9e46   pla
        eor #$12
        and $090b,y
        bmi l9e61
l9e4e   bpl l9e5b
        l9e5b = * + 11
        .byt $0d,$09,$23,$59,$13,$88,$29,$12,$11,$0a,$29,$0b,$09
l9e5d   bvc l9e72
l9e5f   l9e60 = * + 1
        ora #$23
l9e61   adc ($0b,x)
        bcc l9e86
l9e65   .byt $12,$09,$12,$41
l9e69   bvc l9e8c
        l9e72 = * + 7
        .byt $13,$61,$0b,$98,$09,$22,$08,$12,$41,$58,$89,$13
l9e77   bcc l9e93
l9e79   clc
        asl
        eor #$60
        sta ($0c,x)
        tya
        asl
        clc
        .byt $1a
l9e83   eor ($0a,x)
        pla
l9e86   adc #$20
        l9e8c = * + 4
        .byt $0b,$38,$0b,$58,$22
l9e8d   eor #$12
        pla
        eor $1b20,y
l9e93   plp
        .byt $1b,$40,$22,$51,$22,$68,$49,$28,$11,$0b,$28,$0b,$0f,$40,$1a
l9ea3   adc ($22,x)
        pla
        eor #$28
        ora $1270,y
        and ($10),y
        and #$2a
        ora #$58
        eor ($20),y
        and #$58
        eor #$20
        ora ($3a),y
        ora #$58
        eor $2918,y
        bvc l9f09
l9ec0   bmi l9eec
        .byt $09,$12,$11
l9ec5   bvc l9e60
l9ec7   bvc l9efa
        .byt $1b,$28,$12,$18,$0e,$09,$0b,$0a,$11,$48
        .asc ")"
        .byt $48,$23,$09,$13,$0a
        .byt $13
l9eda   jsr $2012
        .byt $09,$13,$11,$40
        .asc "1"
        .byt $40,$13,$12,$1b,$12
l9ee7   ora #$0b
        jsr $200a
l9eec   .byt $1b,$21,$30
        .asc ")"
        .byt $0a,$11
l9ef2   bmi l9f05
        .asc ""
        .byt $3a,$09,$13,$48,$0b
l9ef9   asl
l9efa   and #$28
        and ($0b,x)
        asl
        adc $1112,y
        l9f05 = * + 3
        .asc ""
        .byt $30,$09,$42,$13
l9f06   bvc l9f13
        .byt $12
l9f09   and ($20,x)
        and ($13,x)
        .byt $12,$69,$22,$09
l9f11   bmi l9f35
l9f13   .asc ""
        .byt $23,$0a,$0b,$60,$12,$21
l9f19   jsr $1b21
        .byt $12,$59,$2a,$09,$28,$09,$0a,$0b,$2a,$0b,$0a,$13
l9f28   bmi l9f35
l9f2a   clc
        .byt $1a
l9f2c   and ($20,x)
        ora $0f13,y
        ora #$1a
        eor ($3a,x)
l9f35   ora #$0e
        jsr $1309
        .byt $0a,$0b,$1a,$0b,$12,$13
l9f40   asl
        jsr $1223
        .asc ""
        .byt $31,$18,$21,$1b,$1a
l9f49   eor ($4a,x)
        jsr $1322
        .byt $12,$0b,$1a,$0b,$12
l9f53   jsr $1a0b
        .asc ""
        .byt $39,$18,$0a,$09,$12,$13,$22,$39,$52
l9f5f   jsr $132a
        .byt $0a,$1b,$22,$18,$13,$09,$0a,$41,$18,$1a,$13,$22
l9f6e   eor #$4a
        jsr $0a09
        .byt $0b,$1a,$0b,$12,$09,$0b,$0a,$0b,$0a,$2b,$59,$18,$22,$0b,$1a,$21
        .byt $18,$29,$3a,$28,$0a,$1b,$2a,$2b,$79
l9f8c   jsr $1932
        .asc ""
        .byt $48,$42,$28,$12,$0b,$0f,$12,$13,$0a,$11,$0b,$38,$59,$28,$22,$09
l9f9f   bvs l9fc3
l9fa1   rti
        .asc ""
        .byt $2b
l9fa3   bvs l9fbe
l9fa5   clc
        ora $f8f8,y
        sed
        sed
        plp
        .byt $00
        .asc "xx"
        .byt $28,$19,$0a,$09
        .asc "X"
        .byt $19
l9fb5   sei
        and ($1a,x)
        bmi l9fc3
l9fba   rol
        ora #$68
        l9fbe = * + 1
        ora #$12
        ora #$48
        ora ($0d),y
l9fc3   ora ($60),y
        and ($1a),y
        plp
        ora #$0a
        ora $091a
        cli
        ora #$1a
        .asc ""
        .byt $23,$48,$19,$58,$31,$22,$28,$09,$22,$09
l9fda   bvc l9fe5
l9fdc   rol
        l9fe5 = * + 8
        .byt $0b,$0f,$19
        .asc "("
        .byt $29,$0b,$09,$0a,$0b,$1a,$18,$09,$22,$09
l9feb   bvc l9ff6
        .asc ""
        .byt $3a,$31
l9fef   bcc la012
        .asc ""
        .byt $3b,$12
l9ff3   clc
        ora ($12),y
l9ff6   ora #$50
        ora #$12
        .byt $0b,$22,$41
l9ffd   bvs la030
        .byt $1b,$0f,$13,$22,$28,$19,$40,$1b,$0a,$09,$0b,$1a,$51,$58,$41,$12
        .byt $0b
la010   ora #$0b
la012   rol
        .byt $80,$09,$0a,$23,$12,$61,$18,$81,$3a,$11,$78,$19,$12,$0b,$12,$61
        .byt $18,$12,$81,$2a,$11,$80,$21,$2a,$59
la02c   bpl la037
        la030 = * + 2
        la037 = * + 9
        .byt $12,$89,$1a,$19,$78,$29,$3a,$0b,$31,$28,$1a
        .asc ")"
        .byt $68,$49,$1a,$0b
        .byt $12,$0b,$29,$28,$22
        .asc ")"
        .byt $60,$49,$22,$23
la048   and #$20
        ora #$2a
        sta $1138,y
        jsr $1341
        .byt $0a,$23,$49,$52,$69
la057   bvc la07a
la059   jsr $390e
        .byt $1b,$0f,$0b,$51,$5a,$49,$68,$29
la064   jsr $1341
        .asc ""
        .byt $71,$4a,$09,$18,$19,$78,$31,$18,$39,$13
la071   sta ($0b,x)
        asl
        ora ($22),y
        bcs la0f1
        la07a = * + 2
        .byt $13,$59,$12
la07b   ora $1a13,y
        ora #$12
        rts
        .byt $19,$40,$61,$0b,$11,$0b,$49,$22,$0b,$0a,$09,$2b,$22,$60
la08f   ora #$12
        rti
        .asc ""
        .byt $21,$0a,$5b,$61,$0a,$23,$1a,$23,$0c,$58,$11,$1a,$38,$21,$1a,$13
        .byt $0a,$0b,$22,$0b,$39,$1a,$0e,$09,$12,$13,$22,$18,$0b
la0af   bpl la0bc
la0b1   ora #$38
        ora ($22),y
        sec
        and #$1a
        la0bc = * + 4
        .byt $0b,$1a,$0b,$0f,$13
la0bd   and ($6a),y
        bmi la0d4
        .byt $11,$28,$11,$32,$38,$21,$4a,$13
la0c9   and #$6a
        rti
        .byt $13,$28,$11,$3a,$38,$29,$2a,$0b
la0d4   asl
        .byt $13,$39,$62,$78,$09,$42,$38,$29,$22,$23,$49,$3a,$09,$12,$80,$19
        .asc ""
        .byt $32,$38,$29,$1a,$13
la0ea   adc #$22
        and ($0a,x)
        bcc la111
        .byt $12
la0f1   pha
        ora $131a,y
        lda $0ea8,y
        asl
        bvc la10c
        .byt $1a,$13,$39,$40,$21
        .asc "x"
        .byt $38,$09,$2a,$0b,$21,$80,$19
la108   bvc la125
        la10c = * + 2
        la111 = * + 7
        .asc "("
        .byt $09,$12,$11,$0a,$88,$41,$40,$13,$0f,$13
la115   bcs la130
        la11a = * + 3
        .byt $80,$49,$0c,$09,$40,$0b
la11d   ora #$0b
        sed
        bvc la14b
        .asc ""
        .byt $22
la123   ora ($0e),y
la125   tya
        ora ($12),y
        ora #$30
        .byt $12,$98,$21,$22,$08,$12
la130   bcc la143
        .byt $12,$0b
la134   rol
        jsr $181a
        .byt $0e,$09,$68,$19
la13c   rol
        jsr $7012
        la143 = * + 3
        .byt $0b,$09,$12,$13,$12,$13,$0a,$28,$22,$19
la14a   pla
la14b   ora ($42),y
        php
        .byt $1a,$09
la150   bvc la163
        .byt $13,$42,$1b,$28,$22,$09
la158   bvs la16b
la15a   rol
        .byt $11
la15c   bpl la170
la15e   ora ($48),y
        ora $2a0b,y
la163   .byt $13,$12,$0b,$0f,$0b
la168   jsr $2211
la16b   bvs la186
        .asc ""
        .byt $4a,$19
la16f   pha
la170   ora $1a0b,y
        .byt $0b,$12,$13,$1a,$0b
la178   clc
        and ($32,x)
        bvc la1ae
        la186 = * + 9
        .asc ""
        .byt $2a,$31,$38,$0a,$19,$13,$12,$0b,$1a,$13,$12,$0b,$18,$11,$52,$79
        .byt $1a,$41,$28,$12,$21,$0b,$12,$0b,$32,$13,$18,$09,$6a
        .asc "I"
        .byt $12,$08
        .byt $12,$21,$13,$12,$2b,$12,$0b
la1a4   jsr $2211
la1a7   bpl la1bb
        .byt $13,$12
la1ab   cmp ($12,x)
        la1ae = * + 1
        bpl la1c1
        la1bb = * + 12
        .byt $19,$13,$3a,$0b,$09,$12,$28,$11,$12,$18,$0a,$09,$0f,$0b,$0a
        .asc "I"
        la1c1 = * + 2
        .byt $12,$08,$12,$21,$0b,$12,$09,$1b,$12,$1b,$09,$28,$19
la1cc   plp
        ora ($0b),y
        cmp ($1a,x)
        bpl la1e5
        .asc ""
        .byt $21,$13,$09,$13,$09,$13,$1a,$0b,$09,$68,$09,$1b
        .asc "1"
        .byt $22,$08,$12
la1e3   and ($1b),y
la1e5   ora $0a13,y
        .byt $1b,$68,$13,$08,$13
la1ed   adc #$30
        ora ($0a),y
        jsr $6112
        .asc ""
        .byt $22
la1f5   ora #$70
        ora #$0b
        bpl la20e
        .byt $08,$49,$60,$22
la1ff   adc ($12),y
        ora ($70),y
        ora #$13
        jsr $5849
        .byt $1a
la209   lda ($70,x)
        ora ($0b),y
        php
la20e   eor $b960,y
        bcc la264
la213   jsr $1113
la216   bmi la269
        .byt $1a
la219   eor #$70
        adc ($20),y
        ora #$13
        and ($20,x)
        eor ($1a,x)
        clc
        ora #$13
        and ($70,x)
        adc ($18),y
        ora $2113,y
        jsr $1231
        .asc ""
        .byt $38,$0b,$21
la233   bvs la2a6
la235   jsr $0b19
        .byt $09,$1b,$09,$18,$31,$12,$38,$0b,$0a,$21
la242   jsr $4013
        .asc ""
        .byt $61,$28,$19,$1b,$0f,$1b
la24b   bpl la276
        .byt $1a,$11,$18,$11,$0b,$12,$19
la254   jsr $110b
        .asc ""
        .byt $38,$59,$38,$31,$0b,$09
la25d   jsr $2a11
        la264 = * + 4
        .byt $0e,$09,$1b,$09,$1a,$29,$18,$0b,$19
la269   bmi la2bc
        .asc " "
        .byt $32,$19,$0b,$2a,$31,$18,$0b,$09
la274   la276 = * + 2
        asl $2011
        asl
        eor ($0e),y
        ldy #$32
        .byt $1b
la27d   ora #$1a
        and $0b18,y
        ora $6142,y
        bcc la2b9
        .byt $0b
la288   eor $1320,y
        ora #$5a
        adc ($23),y
        rts
        .byt $81,$28,$13,$52,$79,$0b,$11,$13,$68,$71
la29a   bmi la2af
        .asc ""
        .byt $3a
la29d   eor ($33,x)
        and ($23),y
        bvs $a304
la2a3   bmi la2b8
        .asc ""
        .byt $22
la2a6   and ($3b,x)
        jsr $0913
        .byt $13,$29,$0f,$0b
la2af   bcc $a2ea
la2b1   bvc la2bd
        .byt $11,$23,$58,$1b
la2b7   plp
la2b8   la2b9 = * + 1
        ora ($0b),y
        clv
        la2bc = * + 1
; Instruction parameter jumped to.
        ora ($f8),y
la2bd   sed
        jsr $f200
        .asc "int"
        .byt $8d
        .asc " a%"
