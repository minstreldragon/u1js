#include "archdep.h"

        .word $8c9e
        * = $8c9e

mainMenu
l8c9e   ldx #$11
        jsr loadFile            ; load "RO",
_mainMenuL1
l8ca3   jsr setTextFull         ; set full text window, home
        lda #$00
        sta $5d
        sta $5c
        jsr _printFrame
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
        jsr readKey
        pha
        jsr l94c0
        pla
        cmp #$41                ; 'A'
        bne _mainMenuJ1
        jmp _generateCharacter
_mainMenuJ1
        cmp #$42                ; 'B'
        bne _mainMenuL2
        lda #$62                ; continue previous game
        jsr drawChar
        lda roster              ; check whether a player has been created
        ora roster+$10
        ora roster+$20
        ora roster+$30
        beq l8da9
        jsr _selectPlayer
        lda playerSlot
        clc
        adc #$12                ; add base file id
        tax
        jsr loadFile            ; load "P0" / "P1" / "P2" / "P3"
        bcs _mainMenuJ2
        lda statsFileLen
        cmp #$ca                ; check first two byte i.e. file length
        bne _mainMenuJ2
        lda statsFileLen+1
        cmp #$01
        beq l8ddd
_mainMenuJ2
        jsr $870c
        ldx #2
        ldy #20
        jsr printAtPos
        .aasc "Disk error.",$00

        jsr $8701
        jsr l948d
        jmp _mainMenuL1
l8da9   jsr $870c
        ldx #$02
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
        lda _packedMapOutdoors,y; copy $95f7-
        l8dea = * + 2
        sta $d000,y             ; to $d000-dcff
        iny
        bne l8de5
l8dee   inc l8de7
        inc l8dea
        dex
        bne l8de5
l8df7   stx Cia2PortA
        lda #$36
        sta $01
        lda statsNoiseOn
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
_genCharL1                      ; find an empty character slot
        txa                     ; roster index = char slot * 16
        asl
        asl
        asl
        asl
        tay
        lda roster,y            ; character in use?
        bne _genCharJ1          ; yes ->
        jmp _genCharJ3          ; found an empty slot! ->
_genCharJ1
        inx                     ; inc character slot
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

_genCharL2
        jsr readKey
        cmp #$20                ; space bar?
        bne _genCharJ2
        jmp _mainMenuL1

_genCharJ2
        cmp #$31                ; '1'
        bcc _genCharL2
        cmp #$35                ; '5'
        bcs _genCharL2
        sec
        sbc #$31                ; make 0-based index
        tax
        stx playerSlot
        asl                     ; roster index = char slot * 16
        asl
        asl
        asl
        tax
        lda #$00
        sta roster,x            ; mark roster slot as empty
        ldx #$01
        jsr saveFile            ; "RO"
        ldx playerSlot          ; generate new player for this slot

_genCharJ3
        stx playerSlot
        jsr setTextFull         ; set full text window, home
        jsr _printFrame
        ldy #0
        ldx #8
        jsr printAtPos
        .aasc $0e," Character Generation ",$18,$7e,$00

        jsr l94c0
        lda #<stats+2
        sta l8f2b               ; destination pointer
        lda #>stats+2
        sta l8f2c
        lda #<_statsInitValues+2
        sta l8f28               ; source pointer
        lda #>_statsInitValues+2
        sta l8f29
l8f27   l8f28 = * + 1
        l8f29 = * + 2
        lda $ffff               ; copy initial stats from source
        l8f2b = * + 1
        l8f2c = * + 2
        sta $ffff               ; to destination (?)
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
l8f4b   jsr _printAttributes
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

l9006   jsr _printAttributes
l9009   lda #$63
        sta $32
        jsr readKey
l9010   tay
        lda _attributeId
        asl
        tax
        cpy #$20
        bne l901d
l901a   jmp _mainMenuL1
l901d   cpy #KEY_WEST
        bne l9030
l9021   lda statsAttributes,x
        cmp #10                 ; minimum value (10)?
        beq l9006               ; yes ->
        dec statsAttributes,x   ; dec attribute value
        inc _pointsLeft
        bne l9006

l9030   cpy #KEY_EAST
        bne l9048
        lda _pointsLeft         ; character points left?
        beq l9006               ; no ->
        lda statsAttributes,x
        cmp #25                 ; maximum value (25)?
        bcs l9006               ; yes ->
        inc statsAttributes,x   ; inc attribute value
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
l907c   sty _attributeId        ; set _attributeId to 0 (none)
        jsr _printAttributes
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
        jsr readKey
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
        jsr printFromTableCap   ; print from string table, capitalize
        .word strTableRace
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

l913a   jsr _printAttributes
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
        jsr readKey
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
        jsr printFromTableCap   ; print from string table, capitalize
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
l91e8   jsr readKey
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
        jsr printFromTableCap   ; print from string table, capitalize
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
        jsr _printAttributes
l9255   jsr randomNumber
l9258   sta $8264
        jsr randomNumber
l925e   sta $8265
        ldy #$10
        ldx #$02
        jsr printAtPos
        .aasc "Enter thy name: ",$00

        jsr $94c0
        lda #$00
        sta l93ea               ; index name character
_enterNameL1
l9281   jsr readKey
        ldx l93ea
        cmp #KEY_RETURN         ; return key?
        bne _enterNameJ1
        txa                     ; index name character
        beq _enterNameL1        ; name empty ->
        dec zpCursorRow
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
        jsr printChar
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
        jsr readKey
        jsr drawChar
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

_printAttributes
l9359   lda #$00
        sta $85be
        sta $81c4
        ldx #$05
        stx zpCursorCol
        ldy #$03
        sty zpCursorRow
        lda _attributeId
        beq _printAttsJ1        ; no selection ->
        jsr print
        .aasc "Points left to distribute: ",$00
        lda _pointsLeft
        jsr $8582
_printAttsJ1
        dec $2f
        jsr $164f
        inc $2f
        jsr $83f3
_printAttsL1
        inc $81c4
        inc zpCursorRow
        ldx #10
        stx zpCursorCol
        lda #$20                ; char: space
        ldx $81c4
        cpx _attributeId
        bne _printAttsJ2        ; no selection ->
        lda #$0e                ; char: blue triangle right
_printAttsJ2
        jsr printChar
        jsr printFromTableCap   ; print from string table, capitalize
        .word strTableAttributes
        lda #$2e                ; '.'
        sta $85be
_printAttsL2
        jsr printChar           ; print dotted line
        ldx zpCursorCol
        cpx #26
        bcc _printAttsL2
        lda $81c4
        asl
        tax
        lda statsAttributes,x
        jsr $8582
        lda #$20                ; char: space
        ldx $81c4
        cpx _attributeId
        bne _printAttsJ3
        lda #$18                ; char: blue triangle left
_printAttsJ3
        jsr printChar
        cpx #$06                ; more attributes to print?
        bcc _printAttsL1        ; yes ->
        rts

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

_statsInitValues
l93f5
        .word $01ca             ; stats file length (fixed)
l93f7
        .byt $00                ; continent (0-3)
        .byt $00                ; continent << 6
        .byt $ff
        .byt $ff
        .byt $27                ; longitude
        .byt $21                ; latitude
        .byt $00,$00,$00,$00
        .byt $00                ; spell
        .byt $01                ; weapon
        .byt $01                ; armour
        .byt $00                ; transport (TRANSPORT_FOOT)
                                ; offset: $10
        .byt $01
        .byt $01                ; leather armour ($11)
        .byt $00                ; chain mail ($12)
        .byt $00                ; plate mail ($13)
        .byt $00                ; vacuum suit ($14)
        .byt $00                ; reflect suit ($15)
                                ; -- inventory: weapons --
        .byt $01                ; hands ($16)
        .byt $02                ; dagger ($17)
        .byt $00                ; mace ($18)
        .byt $00                ; axe ($19)
        .byt $00                ; rope & spikes ($1a)
        .byt $00                ; sword ($1b)
        .byt $00                ; great sword ($1c)
        .byt $00                ; bow and arrows ($1d)
        .byt $00                ; amulet ($1e)
        .byt $00                ; wand ($1f)
        .byt $00                ; staff ($20)
        .byt $00                ; triangle ($21)
        .byt $00                ; pistol ($22)
        .byt $00                ; light sword ($23)
        .byt $00                ; phazor ($24)
        .byt $00                ; blaster ($25)
                                ; -- inventory: spells --
        .byt $01                ; prayer ($26)
        .byt $00                ; open ($27)
        .byt $00                ; unlock ($28)
        .byt $00                ; magic missile ($29)
        .byt $00                ; steal ($2a)
        .byt $00                ; ladder down ($2b)
        .byt $00                ; ladder up ($2c)
        .byt $00                ; blink ($2d)
        .byt $00                ; create ($2e)
        .byt $00                ; destroy ($2f)
        .byt $00                ; kill ($2f)

        .byt $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                                ; offset: $40
        .byt $00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byt $00                ; gender ($4a)
                                ; name ($4b)
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .word $0096             ; hit points ($59)
        .word $000a             ; strength ($5b)
        .word $000a             ; agility ($5d)
        .word $000a             ; stamina ($5f)
        .word $000a             ; charisma ($61)
        .word $000a             ; wisdom ($63)
        .word $000a             ; intelligence ($65)
        .word $0064             ; coin ($67)
        .byt $01                ; race ($69)
        .byt $00
        .byt $01                ; class ($6b)
        .byt $00,$00,$00,$00
                                ; offset: $70
        .byt $00,$00,$00,$00,$00,$00,$00,$95
        .word $00c8             ; food ($78)
        .word $0000             ; experience ($7a)
        .byt $e8,$03,$e8,$03,$00,$ff,$ef,$be,$00,$00,$00,$00,$00,$00


l947f   ldx #$02
        stx zpCursorCol
        ldy #$14
        sty zpCursorRow
        jsr l94c0
l948a   jmp print

l948d   ldx #2
        ldy #21
        jsr printAtPos
        .aasc "Press Space to continue: ",$00
        jsr readKey
        jsr $83f6
l94b4   lda #$14
        sta zpCursorRow
        bne l94c0
l94ba   jsr setTextFull         ; set full text window, home
l94bd   jsr _cursorHome

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

_printFrame
l94d7   lda #$10                ; char: upper left corner of frame
        jsr printChar
        ldx #38                 ; # of repeats: 38
        lda #$04                ; char: upper border
        jsr printRepeatChar     ; print upper border
        lda #$12                ; char: upper right corner
        jsr drawChar
_printFrameL1
l94e8   inc zpCursorRow         ; next line
        jsr printCR             ; carriage return
        lda #$0a                ; char: left border
        jsr drawChar
        lda #39
        sta zpCursorCol
        lda #$08                ; char: right border
        jsr drawChar
        jsr $1673
        lda zpCursorRow
        eor #22                 ; repeat 22 times
        bne _printFrameL1
        sta zpCursorCol         ; zpCursorCol = 0
        inc zpCursorRow
        lda #$14                ; char: lower left corner of frame
        jsr printChar
        ldx #38                 ; # of repeats: 38
        lda #$02                ; char: lower border
        jsr printRepeatChar     ; print lower border
        lda #$16                ; char: lower right corner of frame
        jsr drawChar
_cursorHome
l9519   ldx #$01                ; return cursor to upper left corner
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
        jsr readKey
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
        jsr drawChar
l95b5   inc zpCursorCol
        lda #$2e
        jsr drawChar
l95bc   inc zpCursorCol
        lda #$20
        jsr drawChar
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
l95df   jsr drawChar
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
        .byt $00,$00

_packedMapOutdoors
l95f7
	.word $0008             ; offset continent 0
        .word $02e7             ; offset continent 1
        .word $0658             ; offset continent 2
        .word $09b6             ; offset continent 3

	.byt $f8,$f8,$30,$1a,$21,$78,$19,$d8,$09,$0a,$19,$30,$1a,$31,$60,$11
	.byt $0d,$11,$48,$09,$12,$09,$68,$09,$2a,$09,$28,$22,$31,$58,$19,$48
	.byt $23,$1a,$09,$58,$09,$1a,$0d,$0a,$09,$20,$1a,$0b,$0a,$09,$0b,$29
	.byt $a8,$19,$0f,$0b,$2a,$09,$50,$09,$22,$09,$20,$12,$3b,$21,$90,$31
	.byt $3a,$09,$50,$09,$22,$09,$18,$22,$13,$0f,$1b,$31,$70,$41,$22,$0b
	.byt $12,$09,$50,$09,$12,$11,$18,$2a,$0b,$09,$0b,$12,$41,$58,$51,$1a
	.byt $0b,$09,$0a,$1b,$40,$19,$28,$11,$3a,$81,$18,$61,$12,$23,$0a,$09
	.byt $88,$11,$2a,$91,$18,$61,$12,$0b,$12,$19,$80,$19,$1a,$a1,$10,$59
	.byt $2a,$21,$88,$c1,$28,$31,$0b,$3a,$29,$80,$c9,$28,$29,$0b,$12,$0b
	.byt $1a,$49,$70,$c9,$20,$29,$23,$22,$49,$68,$f9,$29,$23,$0a,$13,$41
	.byt $20,$11,$38,$f9,$31,$0b,$0f,$1b,$39,$0e,$20,$21,$28,$69,$18,$c1
	.byt $13,$41,$20,$29,$28,$61,$28,$39,$0b,$81,$13,$39,$18,$31,$28,$11
	.byt $0a,$49,$30,$31,$13,$19,$12,$59,$13,$79,$28,$09,$22,$39,$30,$21
	.byt $2b,$09,$0a,$0b,$22,$49,$0b,$11,$0b,$61,$20,$0a,$09,$22,$49,$20
	.byt $0c,$23,$1a,$23,$0a,$61,$5b,$0a,$21,$20,$3a,$51,$0b,$10,$0b,$18
	.byt $22,$13,$12,$09,$0e,$1a,$39,$0b,$22,$0b,$0a,$13,$1a,$21,$20,$42
	.byt $49,$13,$30,$6a,$31,$13,$0f,$0b,$1a,$0b,$1a,$29,$18,$52,$39,$13
	.byt $40,$6a,$29,$13,$4a,$21,$20,$5a,$29,$58,$62,$39,$13,$0a,$0b,$2a
	.byt $29,$20,$4a,$21,$78,$12,$09,$3a,$49,$23,$22,$29,$20,$32,$29,$88
	.byt $0a,$21,$22,$69,$13,$1a,$29,$28,$2a,$0e,$a8,$b9,$13,$1a,$19,$f8
	.byt $10,$c1,$13,$1a,$11,$a8,$1b,$40,$c9,$0b,$2a,$09,$a0,$13,$0f,$13
	.byt $38,$d1,$0a,$11,$12,$09,$a8,$0b,$09,$0b,$40,$09,$0c,$e1,$50,$09
	.byt $12,$11,$98,$0e,$11,$22,$a1,$58,$2a,$0b,$12,$11,$90,$12,$08,$22
	.byt $91,$28,$12,$20,$0a,$13,$12,$13,$12,$09,$0b,$70,$12,$20,$2a,$89
	.byt $0e,$18,$1a,$18,$1b,$42,$13,$11,$50,$09,$1a,$08,$42,$91,$22,$20
	.byt $0b,$0f,$0b,$12,$13,$2a,$0b,$19,$48,$11,$12,$10,$11,$2a,$89,$22
	.byt $28,$0b,$1a,$13,$12,$0b,$1a,$0b,$19,$48,$19,$4a,$89,$22,$11,$20
	.byt $0b,$12,$13,$1a,$0b,$12,$13,$19,$0a,$38,$31,$2a,$81,$32,$21,$18
	.byt $13,$32,$0b,$12,$0b,$21,$12,$28,$41,$1a,$79,$52,$11,$20,$0b,$12
	.byt $2b,$12,$13,$21,$12,$08,$12,$c9,$6a,$09,$20,$12,$09,$0b,$3a,$13
	.byt $19,$12,$10,$12,$c1,$12,$13,$12,$10,$22,$11,$20,$09,$1b,$12,$1b
	.byt $09,$12,$0b,$21,$12,$08,$12,$c9,$0a,$0b,$0f,$09,$0a,$18,$12,$11
	.byt $28,$09,$0b,$1a,$13,$09,$13,$09,$13,$21,$12,$10,$1a,$c1,$0b,$11
	.byt $28,$19,$28,$1b,$0a,$13,$19,$1b,$31,$12,$08,$22,$b1,$1b,$09,$70
	.byt $09,$22,$61,$12,$10,$11,$0a,$a9,$13,$08,$13,$70,$11,$12,$71,$22
	.byt $a9,$08,$13,$10,$0b,$09,$70,$a1,$1a,$a1,$20,$13,$09,$70,$f9,$79
	.byt $08,$0b,$11,$70,$49,$1a,$91,$13,$71,$90,$21,$13,$09,$18,$1a,$81
	.byt $13,$99,$70,$21,$0b,$38,$12,$71,$13,$a1,$68,$21,$0a,$0b,$38,$12
	.byt $51,$1b,$09,$0b,$a9,$68,$19,$12,$0b,$11,$18,$11,$1a,$39,$1b,$0f
	.byt $1b,$a1,$40,$13,$18,$29,$1a,$09,$1b,$09,$0e,$2a,$39,$0b,$31,$38
	.byt $59,$38,$11,$0b,$18,$31,$2a,$0b,$19,$32,$19,$88,$51,$30,$19,$0b
	.byt $18,$39,$1a,$09,$1b,$32,$a0,$0e,$51,$0a,$20,$11,$0e,$09,$0b,$20
	.byt $59,$0b,$32,$88,$69,$42,$19,$0b,$20,$81,$60,$23,$71,$5a,$09,$13
	.byt $20,$71,$68,$13,$11,$0b,$79,$52,$13,$20,$61,$70,$23,$31,$33,$41
	.byt $3a,$13,$28,$39,$90,$0b,$0f,$29,$13,$09,$13,$20,$3b,$21,$22,$13
	.byt $30,$11,$b8,$0b,$11,$28,$1b,$58,$23,$11,$0a,$f8,$f8,$50,$00,$f8
	.byt $f8,$f8,$f8,$40,$22,$09,$70,$22,$40,$2b,$78,$11,$18,$19,$18,$32
	.byt $19,$48,$42,$28,$12,$0b,$0f,$12,$13,$0a,$11,$0b,$48,$49,$10,$22
	.byt $0b,$1a,$21,$18,$29,$3a,$28,$0a,$1b,$2a,$1b,$09,$38,$49,$18,$1a
	.byt $13,$22,$49,$4a,$20,$09,$0a,$0b,$1a,$0b,$12,$09,$0b,$0a,$0b,$0a
	.byt $09,$30,$49,$18,$0a,$09,$12,$13,$22,$39,$52,$20,$2a,$13,$0a,$1b
	.byt $22,$20,$11,$0a,$41,$18,$21,$1b,$1a,$41,$4a,$20,$22,$13,$12,$0b
	.byt $1a,$0b,$12,$18,$11,$1a,$39,$18,$19,$13,$0f,$09,$1a,$41,$3a,$09
	.byt $0e,$20,$09,$13,$0a,$0b,$1a,$0b,$12,$13,$0a,$20,$23,$12,$31,$18
	.byt $21,$1b,$12,$59,$2a,$09,$28,$09,$0a,$0b,$2a,$0b,$0a,$13,$30,$0b
	.byt $18,$1a,$21,$20,$21,$13,$12,$69,$22,$09,$30,$22,$23,$0a,$0b,$60
	.byt $12,$21,$28,$21,$0b,$0a,$79,$12,$11,$30,$09,$42,$13,$50,$0b,$12
	.byt $21,$30,$a9,$0a,$11,$30,$11,$3a,$09,$13,$48,$0b,$0a,$29,$38,$b1
	.byt $40,$13,$12,$1b,$12,$09,$0b,$20,$0a,$20,$1b,$21,$40,$a9,$48,$23
	.byt $08,$13,$0a,$13,$20,$12,$20,$09,$13,$11,$50,$99,$80,$1b,$28,$12
	.byt $18,$0e,$09,$0b,$0a,$11,$50,$59,$18,$29,$c0,$09,$2a,$09,$12,$11
	.byt $50,$51,$20,$29,$28,$0b,$88,$19,$3a,$09,$60,$49,$28,$19,$28,$1b
	.byt $30,$12,$30,$39,$2a,$09,$60,$49,$28,$11,$0b,$28,$0b,$0f,$40,$1a
	.byt $20,$41,$22,$70,$49,$20,$1b,$28,$1b,$40,$22,$10,$41,$22,$70,$51
	.byt $20,$0b,$38,$0b,$58,$22,$49,$12,$78,$61,$0c,$98,$0a,$18,$1a,$41
	.byt $0a,$80,$61,$13,$90,$1a,$18,$0a,$49,$50,$11,$20,$61,$0b,$98,$09
	.byt $22,$08,$12,$41,$50,$11,$20,$61,$0b,$a0,$11,$12,$09,$12,$41,$48
	.byt $09,$0d,$09,$20,$59,$13,$a8,$09,$12,$11,$0a,$29,$0b,$09,$50,$11
	.byt $30,$51,$0b,$12,$a8,$09,$12,$39,$0b,$09,$30,$13,$10,$11,$38,$09
	.byt $08,$29,$1b,$1a,$58,$12,$09,$38,$41,$1b,$28,$0b,$0f,$09,$70,$29
	.byt $13,$2a,$30,$09,$0e,$08,$1a,$09,$38,$39,$0b,$0f,$09,$28,$0b,$11
	.byt $48,$09,$28,$29,$13,$32,$18,$09,$0c,$09,$10,$1a,$09,$40,$29,$13
	.byt $09,$20,$13,$09,$48,$21,$18,$31,$13,$22,$18,$21,$0a,$18,$0a,$09
	.byt $48,$29,$0b,$09,$18,$1b,$09,$40,$29,$18,$29,$0a,$13,$1a,$20,$19
	.byt $12,$08,$0a,$08,$12,$50,$11,$1b,$09,$18,$0b,$19,$38,$39,$10,$21
	.byt $0a,$13,$2a,$18,$19,$0a,$10,$0a,$09,$1a,$48,$09,$13,$11,$20,$0b
	.byt $19,$38,$69,$42,$09,$18,$11,$22,$09,$1a,$48,$13,$09,$30,$13,$09
	.byt $0b,$30,$79,$0a,$11,$2a,$20,$09,$42,$48,$0b,$09,$38,$19,$13,$20
	.byt $0b,$79,$0a,$09,$0e,$2a,$30,$32,$98,$21,$0b,$20,$0b,$79,$0a,$09
	.byt $32,$30,$2a,$a0,$19,$13,$18,$09,$0b,$0f,$81,$32,$38,$22,$98,$19
	.byt $13,$20,$0a,$13,$0a,$29,$1b,$39,$2a,$09,$40,$12,$50,$21,$30,$19
	.byt $0b,$28,$2a,$21,$12,$0b,$41,$1a,$19,$78,$49,$28,$19,$0b,$28,$09
	.byt $2a,$19,$12,$13,$41,$0a,$29,$60,$69,$18,$19,$0b,$30,$32,$09,$12
	.byt $23,$71,$38,$91,$08,$0e,$19,$0b,$30,$09,$52,$0b,$0f,$f9,$69,$13
	.byt $30,$12,$1b,$2a,$1b,$f9,$69,$0b,$30,$09,$12,$09,$13,$2a,$1b,$f9
	.byt $61,$0b,$38,$09,$12,$0b,$1a,$09,$0a,$13,$09,$13,$f9,$59,$0b,$40
	.byt $09,$13,$0a,$21,$0b,$19,$33,$b1,$10,$69,$0b,$48,$0b,$0a,$59,$0b
	.byt $0a,$1b,$a9,$0b,$08,$69,$0b,$48,$0b,$61,$0b,$0a,$0f,$0a,$13,$71
	.byt $12,$19,$13,$08,$51,$0a,$11,$13,$50,$51,$13,$0a,$0b,$12,$0b,$71
	.byt $1a,$09,$13,$20,$41,$12,$11,$0b,$60,$49,$0b,$1a,$13,$69,$12,$23
	.byt $10,$13,$08,$39,$1a,$11,$0b,$68,$41,$13,$1a,$13,$61,$12,$0b,$0f
	.byt $09,$23,$09,$08,$39,$22,$09,$0b,$68,$41,$0b,$2a,$13,$51,$22,$19
	.byt $0b,$19,$08,$19,$18,$2a,$11,$68,$19,$0e,$10,$11,$1b,$22,$1b,$41
	.byt $2a,$70,$2a,$09,$18,$11,$48,$11,$18,$11,$13,$32,$0b,$12,$39,$1a
	.byt $80,$32,$10,$09,$12,$09,$68,$11,$0b,$4a,$11,$10,$0e,$11,$22,$80
	.byt $2a,$18,$22,$09,$58,$19,$0b,$1a,$19,$1a,$11,$18,$09,$32,$78,$2a
	.byt $18,$09,$22,$11,$40,$21,$12,$31,$1a,$09,$18,$42,$68,$09,$22,$0b
	.byt $18,$09,$0a,$0d,$1a,$09,$38,$71,$12,$20,$1a,$09,$22,$09,$58,$19
	.byt $12,$13,$18,$09,$2a,$09,$30,$89,$18,$1a,$11,$1a,$11,$50,$11,$0e
	.byt $11,$13,$28,$19,$0a,$09,$38,$69,$30,$1a,$08,$19,$0a,$19,$48,$0b
	.byt $21,$13,$48,$11,$40,$41,$50,$12,$18,$21,$58,$33,$f8,$f8,$38,$00
	.byt $f8,$f8,$20,$33,$38,$41,$50,$12,$18,$21,$58,$33,$30,$13,$11,$0a
	.byt $09,$13,$28,$69,$30,$1a,$08,$19,$0a,$19,$48,$0b,$21,$13,$28,$0b
	.byt $2a,$09,$0b,$28,$89,$18,$1a,$11,$1a,$11,$50,$11,$0e,$11,$13,$20
	.byt $0b,$0a,$0d,$1a,$09,$0b,$30,$71,$12,$20,$1a,$09,$22,$09,$58,$19
	.byt $12,$13,$18,$0b,$22,$11,$0b,$38,$21,$12,$31,$1a,$09,$18,$42,$68
	.byt $09,$22,$0b,$18,$0b,$1a,$09,$0b,$08,$0b,$40,$19,$0b,$1a,$19,$1a
	.byt $11,$18,$09,$32,$78,$2a,$18,$0b,$12,$09,$13,$58,$11,$0b,$4a,$11
	.byt $10,$0e,$11,$22,$80,$2a,$18,$2b,$60,$11,$13,$32,$0b,$12,$39,$1a
	.byt $80,$32,$80,$0e,$10,$11,$1b,$22,$1b,$41,$2a,$70,$2a,$09,$80,$29
	.byt $0b,$2a,$13,$51,$22,$19,$0b,$19,$08,$19,$18,$2a,$11,$88,$21,$13
	.byt $1a,$13,$61,$12,$0b,$0f,$09,$23,$09,$08,$39,$22,$09,$0b,$98,$11
	.byt $0b,$1a,$13,$69,$12,$23,$10,$13,$08,$39,$1a,$11,$0b,$a0,$13,$0a
	.byt $0b,$12,$0b,$71,$1a,$09,$13,$20,$41,$12,$11,$0b,$40,$0b,$60,$0b
	.byt $0a,$0f,$0a,$13,$71,$12,$19,$13,$08,$51,$0a,$11,$13,$40,$0b,$0a
	.byt $58,$0b,$0a,$1b,$a9,$0b,$08,$69,$0b,$40,$09,$13,$0a,$20,$0b,$18
	.byt $33,$b1,$10,$69,$0b,$38,$09,$12,$0b,$1a,$08,$0a,$13,$08,$13,$f9
	.byt $59,$0b,$30,$09,$12,$09,$13,$2a,$1b,$f9,$61,$0b,$30,$12,$1b,$2a
	.byt $1b,$f9,$69,$0b,$28,$09,$52,$0b,$0f,$f9,$69,$13,$28,$32,$09,$12
	.byt $23,$f9,$41,$08,$0e,$19,$0b,$28,$09,$2a,$19,$12,$13,$41,$0a,$f1
	.byt $18,$19,$0b,$28,$2a,$21,$12,$0b,$41,$1a,$e9,$18,$19,$0b,$28,$0a
	.byt $13,$0a,$29,$1b,$39,$2a,$49,$12,$89,$18,$19,$0b,$28,$09,$0b,$0f
	.byt $81,$32,$39,$22,$81,$18,$19,$13,$28,$0b,$79,$0a,$09,$32,$31,$2a
	.byt $81,$20,$19,$13,$20,$0b,$79,$0a,$09,$0e,$2a,$31,$32,$79,$20,$21
	.byt $0b,$28,$79,$0a,$11,$2a,$29,$42,$49,$0b,$21,$20,$19,$13,$30,$69
	.byt $42,$31,$22,$09,$1a,$49,$13,$21,$18,$13,$09,$0b,$38,$39,$10,$21
	.byt $0a,$13,$2a,$31,$0a,$10,$0a,$09,$1a,$51,$13,$19,$18,$0b,$19,$40
	.byt $29,$18,$29,$0a,$13,$1a,$39,$12,$08,$0a,$08,$12,$61,$1b,$09,$18
	.byt $0b,$19,$48,$21,$18,$31,$13,$22,$39,$0a,$18,$0a,$79,$0b,$09,$18
	.byt $1b,$09,$50,$09,$28,$29,$13,$32,$21,$0c,$09,$10,$1a,$71,$13,$09
	.byt $20,$13,$09,$78,$29,$13,$2a,$20,$19,$0e,$08,$1a,$79,$0b,$0f,$09
	.byt $28,$0b,$11,$58,$09,$08,$29,$1b,$1a,$58,$12,$81,$1b,$28,$0b,$0f
	.byt $09,$10,$23,$20,$51,$0b,$12,$68,$49,$12,$39,$0b,$09,$30,$13,$10
	.byt $0b,$0d,$09,$23,$59,$13,$88,$29,$12,$11,$0a,$29,$0b,$09,$50,$13
	.byt $09,$23,$61,$0b,$90,$21,$12,$09,$12,$41,$50,$21,$13,$61,$0b,$98
	.byt $09,$22,$08,$12,$41,$58,$89,$13,$90,$1a,$18,$0a,$49,$60,$81,$0c
	.byt $98,$0a,$18,$1a,$41,$0a,$68,$69,$20,$0b,$38,$0b,$58,$22,$49,$12
	.byt $68,$59,$20,$1b,$28,$1b,$40,$22,$51,$22,$68,$49,$28,$11,$0b,$28
	.byt $0b,$0f,$40,$1a,$61,$22,$68,$49,$28,$19,$70,$12,$31,$10,$29,$2a
	.byt $09,$58,$51,$20,$29,$58,$49,$20,$11,$3a,$09,$58,$59,$18,$29,$50
	.byt $49,$30,$2a,$09,$12,$11,$50,$99,$50,$31,$1b,$28,$12,$18,$0e,$09
	.byt $0b,$0a,$11,$48,$a9,$48,$23,$09,$13,$0a,$13,$20,$12,$20,$09,$13
	.byt $11,$40,$b1,$40,$13,$12,$1b,$12,$09,$0b,$20,$0a,$20,$1b,$21,$30
	.byt $a9,$0a,$11,$30,$11,$3a,$09,$13,$48,$0b,$0a,$29,$28,$21,$0b,$0a
	.byt $79,$12,$11,$30,$09,$42,$13,$50,$0b,$12,$21,$20,$21,$13,$12,$69
	.byt $22,$09,$30,$22,$23,$0a,$0b,$60,$12,$21,$20,$21,$1b,$12,$59,$2a
	.byt $09,$28,$09,$0a,$0b,$2a,$0b,$0a,$13,$30,$0b,$18,$1a,$21,$20,$19
	.byt $13,$0f,$09,$1a,$41,$3a,$09,$0e,$20,$09,$13,$0a,$0b,$1a,$0b,$12
	.byt $13,$0a,$20,$23,$12,$31,$18,$21,$1b,$1a,$41,$4a,$20,$22,$13,$12
	.byt $0b,$1a,$0b,$12,$20,$0b,$1a,$39,$18,$0a,$09,$12,$13,$22,$39,$52
	.byt $20,$2a,$13,$0a,$1b,$22,$18,$13,$09,$0a,$41,$18,$1a,$13,$22,$49
	.byt $4a,$20,$09,$0a,$0b,$1a,$0b,$12,$09,$0b,$0a,$0b,$0a,$2b,$59,$18
	.byt $22,$0b,$1a,$21,$18,$29,$3a,$28,$0a,$1b,$2a,$2b,$79,$20,$32,$19
	.byt $48,$42,$28,$12,$0b,$0f,$12,$13,$0a,$11,$0b,$38,$59,$28,$22,$09
	.byt $70,$22,$40,$2b,$70,$19,$18,$19,$f8,$f8,$f8,$f8,$28,$00,$f8,$f8
	.byt $28,$19,$0a,$09,$d8,$19,$78,$21,$1a,$30,$09,$2a,$09,$68,$09,$12
	.byt $09,$48,$11,$0d,$11,$60,$31,$1a,$28,$09,$0a,$0d,$1a,$09,$58,$09
	.byt $1a,$23,$48,$19,$58,$31,$22,$28,$09,$22,$09,$50,$09,$2a,$0b,$0f
	.byt $19,$a8,$29,$0b,$09,$0a,$0b,$1a,$18,$09,$22,$09,$50,$09,$3a,$31
	.byt $90,$21,$3b,$12,$18,$11,$12,$09,$50,$09,$12,$0b,$22,$41,$70,$31
	.byt $1b,$0f,$13,$22,$28,$19,$40,$1b,$0a,$09,$0b,$1a,$51,$58,$41,$12
	.byt $0b,$09,$0b,$2a,$80,$09,$0a,$23,$12,$61,$18,$81,$3a,$11,$78,$19
	.byt $12,$0b,$12,$61,$18,$12,$81,$2a,$11,$80,$21,$2a,$59,$10,$09,$12
	.byt $89,$1a,$19,$78,$29,$3a,$0b,$31,$28,$1a,$a9,$68,$49,$1a,$0b,$12
	.byt $0b,$29,$28,$22,$a9,$60,$49,$22,$23,$29,$20,$09,$2a,$99,$38,$11
	.byt $20,$41,$13,$0a,$23,$49,$52,$69,$50,$21,$20,$0e,$39,$1b,$0f,$0b
	.byt $51,$5a,$49,$68,$29,$20,$41,$13,$71,$4a,$09,$18,$19,$78,$31,$18
	.byt $39,$13,$81,$0b,$0a,$11,$22,$b0,$79,$13,$59,$12,$19,$13,$1a,$09
	.byt $12,$60,$19,$40,$61,$0b,$11,$0b,$49,$22,$0b,$0a,$09,$2b,$22,$60
	.byt $09,$12,$40,$21,$0a,$5b,$61,$0a,$23,$1a,$23,$0c,$58,$11,$1a,$38
	.byt $21,$1a,$13,$0a,$0b,$22,$0b,$39,$1a,$0e,$09,$12,$13,$22,$18,$0b
	.byt $10,$0b,$09,$38,$11,$22,$38,$29,$1a,$0b,$1a,$0b,$0f,$13,$31,$6a
	.byt $30,$13,$11,$28,$11,$32,$38,$21,$4a,$13,$29,$6a,$40,$13,$28,$11
	.byt $3a,$38,$29,$2a,$0b,$0a,$13,$39,$62,$78,$09,$42,$38,$29,$22,$23
	.byt $49,$3a,$09,$12,$80,$19,$32,$38,$29,$1a,$13,$69,$22,$21,$0a,$90
	.byt $21,$12,$48,$19,$1a,$13,$b9,$a8,$0e,$0a,$50,$11,$1a,$13,$39,$40
	.byt $21,$f8,$38,$09,$2a,$0b,$21,$80,$19,$50,$1b,$a8,$09,$12,$11,$0a
	.byt $88,$41,$40,$13,$0f,$13,$b0,$19,$80,$49,$0c,$09,$40,$0b,$09,$0b
	.byt $f8,$50,$29,$22,$11,$0e,$98,$11,$12,$09,$30,$12,$98,$21,$22,$08
	.byt $12,$90,$11,$12,$0b,$2a,$20,$1a,$18,$0e,$09,$68,$19,$2a,$20,$12
	.byt $70,$0b,$09,$12,$13,$12,$13,$0a,$28,$22,$19,$68,$11,$42,$08,$1a
	.byt $09,$50,$11,$13,$42,$1b,$28,$22,$09,$70,$11,$2a,$11,$10,$12,$11
	.byt $48,$19,$0b,$2a,$13,$12,$0b,$0f,$0b,$20,$11,$22,$70,$19,$4a,$19
	.byt $48,$19,$0b,$1a,$0b,$12,$13,$1a,$0b,$18,$21,$32,$50,$31,$2a,$31
	.byt $38,$0a,$19,$13,$12,$0b,$1a,$13,$12,$0b,$18,$11,$52,$79,$1a,$41
	.byt $28,$12,$21,$0b,$12,$0b,$32,$13,$18,$09,$6a,$c9,$12,$08,$12,$21
	.byt $13,$12,$2b,$12,$0b,$20,$11,$22,$10,$12,$13,$12,$c1,$12,$10,$12
	.byt $19,$13,$3a,$0b,$09,$12,$28,$11,$12,$18,$0a,$09,$0f,$0b,$0a,$c9
	.byt $12,$08,$12,$21,$0b,$12,$09,$1b,$12,$1b,$09,$28,$19,$28,$11,$0b
	.byt $c1,$1a,$10,$12,$21,$13,$09,$13,$09,$13,$1a,$0b,$09,$68,$09,$1b
	.byt $b1,$22,$08,$12,$31,$1b,$19,$13,$0a,$1b,$68,$13,$08,$13,$69,$30
	.byt $11,$0a,$20,$12,$61,$22,$09,$70,$09,$0b,$10,$13,$08,$49,$60,$22
	.byt $71,$12,$11,$70,$09,$13,$20,$49,$58,$1a,$a1,$70,$11,$0b,$08,$59
	.byt $60,$b9,$90,$51,$20,$13,$11,$30,$51,$1a,$49,$70,$71,$20,$09,$13
	.byt $21,$20,$41,$1a,$18,$09,$13,$21,$70,$71,$18,$19,$13,$21,$20,$31
	.byt $12,$38,$0b,$21,$70,$71,$20,$19,$0b,$09,$1b,$09,$18,$31,$12,$38
	.byt $0b,$0a,$21,$20,$13,$40,$61,$28,$19,$1b,$0f,$1b,$10,$29,$1a,$11
	.byt $18,$11,$0b,$12,$19,$20,$0b,$11,$38,$59,$38,$31,$0b,$09,$20,$11
	.byt $2a,$0e,$09,$1b,$09,$1a,$29,$18,$0b,$19,$30,$51,$a0,$32,$19,$0b
	.byt $2a,$31,$18,$0b,$09,$0e,$11,$20,$0a,$51,$0e,$a0,$32,$1b,$09,$1a
	.byt $39,$18,$0b,$19,$42,$61,$90,$32,$0b,$59,$20,$13,$09,$5a,$71,$23
	.byt $60,$81,$28,$13,$52,$79,$0b,$11,$13,$68,$71,$30,$13,$3a,$41,$33
	.byt $31,$23,$70,$61,$30,$13,$22,$21,$3b,$20,$13,$09,$13,$29,$0f,$0b
	.byt $90,$39,$50,$0a,$11,$23,$58,$1b,$28,$11,$0b,$b8,$11,$f8,$f8,$20
	.byt $00

        ; extra (unused) data:
        .byt $f2,$e9,$ee,$f4,$8d,$a0,$e1,$a5

