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
        beq _enterTownJ1        ; male? ->
        ldx #$05
_enterTownL1
        lda _strLecher,x        ; replace "Wench" by "Lecher"
        sta _strBeggar,x
        dex
        bpl _enterTownL1
_enterTownJ1
        lda #$00                ; karma: good
        sta _karma              ; when entering town, karma is good
        sta $81c8
        sta lad38
        lda statsLocation
_enterTownL2
        cmp #21                 ; place = statsLocation % 21
        bcc _enterTownJ2
        sbc #21
        bne _enterTownL2
_enterTownJ2
        sec
        sbc #13                 ; make 0-based town layout id
        sta _townLayoutId
        pha                     ; store town layout id
        ldx #$00
        jsr loadFile            ; load "TC",$4000
        ldx #$01
        jsr loadFile            ; load "MA",$c700
        pla                     ; restore town layout id
        asl                     ; as 16 bit pointer
        tax
        lda $4004,x             ; get town map data pointer
        sta l8cf6
        lda $4005,x
        sta l8cf7
        ldy #$03
        ldx #$00
_enterTownL3
        l8cf6 = * + 1
        l8cf7 = * + 2
        lda $ffff,x
        l8cfa = * + 2
        sta townMap,x
        dex
        bne _enterTownL3
        inc l8cf7
        inc l8cfa
        dey
        bne _enterTownL3
l8d07   jsr la51a
l8d0a   jmp _mainLoopTown

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
        jsr la273
        jsr l8e15
        lda lad29
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

_mainLoopTown
l8d51   lda statsHp
        ora statsHp+1
        beq _townPlayerDead     ; -> starving
        lda statsFood
        ora statsFood+1
        bne _mainLoopTownJ1
_townPlayerDead
l8d61   jsr $1649               ; dead!
        jmp $8c5b
_mainLoopTownJ1
        jsr l8d0d               ; wait for command / check command key
        lda _commandTable,x
        sta _cmdJmpPtr
        lda _commandTable+1,x
        sta _cmdJmpPtr+1
_cmdJmpPtr = * + 1
        jsr $ffff
        jsr la273
        jmp _mainLoopTown

_commandTable
l8d7f
        .word cmdTwNorth        ; north
        .word cmdTwSouth        ; south
        .word cmdTwEast         ; east
        .word cmdTwWest         ; west
        .word cmdTwPass         ; pass
        .word cmdTwAttack       ; attack
        .word cmdInvalid        ; board
        .word cmdTwCast         ; cast
        .word cmdTwDrop         ; drop
        .word cmdInvalid        ; enter
        .word cmdInvalid        ; fire
        .word cmdTwGet          ; get
        .word cmdInvalid        ; hyper jump
        .word cmdTwInform       ; inform & search
        .word cmdInvalid        ; klimb
        .word cmdNoise          ; noise
        .word cmdInvalid        ; open
        .word cmdTwQuit         ; quit (and save to disk)
        .word cmdTwReady        ; ready
        .word cmdTwSteal        ; steal
        .word cmdTwTransact     ; transact
        .word cmdTwUnlock       ; unlock
        .word cmdInvalid        ; view change
        .word cmdInvalid        ; x-it
        .word cmdTwZtats        ; ztats

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
        jsr la5eb               ; ?? get tile ??
        bcs l8dff               ; is tile empty? -> yes
        lda $2c                 ; target location x
        cmp #38                 ; >= 38?
        bcs l8de6               ; yes, outside town ->
        lda $2d                 ; target location y
        cmp #18                 ; >= 18?
        bcc l8de9               ; no ->
l8de6   jmp $8c5e               ; ?? leave town ??
l8de9   lda #$0e
        jsr playSoundEffect
        jsr $83f6
        jsr print
        .aasc "Blocked",$00
        jmp l8e15
l8dff   ldx zpLongitude
        ldy zpLatitude
        lda #$20                ; char: empty field
        jsr la5d3
l8e08   ldx $2c
        stx zpLongitude
        ldy $2d
        sty zpLatitude
        lda #$7b                ; char: player (?)
        jsr la5d3

cmdTwPass
l8e15   ldy #$01
        lda #$10
        jsr $863c
l8e1c   jsr $1688
        bne l8e1c
l8e21   rts

cmdTwAttack
l8e22   jsr print
        .aasc "with ",$00
        ldx statsWeapon
        jsr printFromTable
        .word strTableWeapons
        ldx statsWeapon
        cpx #WEAPON_ROPE        ; weapon == Rope? -> invalid
        beq _townAttackInvalid
        cpx #WEAPON_AMULET      ; weapon < Amulet? -> OK
        bcc _townAttackJ1
        cpx #WEAPON_TRIANGLE    ; weapon >= Triangle? -> OK
        bcs _townAttackJ1
_townAttackInvalid
        jmp cmdInvalid          ; can't attack with current weapon!

_townAttackJ1
        jsr print               ; print prompt (direction)
        .aasc ": ",$00
        jsr $8d45
        beq _townAttackNothing
        ldx #$00
        ldy #$00
        cmp #KEY_NORTH
        bne _townAttackJ2
        dey
        bne _townAttackJ6
_townAttackJ2
        cmp #KEY_SOUTH
        bne _townAttackJ3
        iny
        bne _townAttackJ6
_townAttackJ3
        cmp #KEY_EAST
        bne _townAttackJ4
        inx
        bne _townAttackJ6
_townAttackJ4
        cmp #KEY_WEST
        beq _townAttackJ5
_townAttackNothing
        jsr print               ; no direction selected, cancel attack
        .aasc "Nothing",$00
        rts
_townAttackJ5
        dex
_townAttackJ6
        stx $24
        sty $25
        jsr checkCommandKey     ; check command (again), print direction
        jsr $83ed
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
        jsr print
        .aasc "Missed!",$00
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
        cmp $4d
        bcs l8ec3
        lda #$01                ; karma: bad
        sta _karma              ; set karma to bad!
        lda #$06
        jsr playSoundEffect
        jsr print
        .aasc "Hit ",$00
        ldx zpTwMapTile
        jsr printFromTable
        .word _strTableNpc
        jsr print
        .aasc "! ",$00
        lda statsStrength       ; max damage = strength + 3 * weapon
        clc
        adc statsWeapon
        adc statsWeapon
        adc statsWeapon
        sta $4d
l8f18   jsr randomNumber        ; damage = random [0..max damage]
        cmp #$00                ; damage > 0?
        beq l8f18               ; no -> repeat
        cmp $4d                 ; damage < max damage?
        bcs l8f18               ; no -> repeat
        sta $4d
        lda #$02
        jsr playSoundEffect
        ldx lad2e               ; current NPC index
        lda npcHpLb,x           ; subtract damage from NPC's HP
        sec
        sbc $4d
        sta npcHpLb,x
        lda npcHpHb,x
        sbc #$00
        sta npcHpHb,x
        bcc l8f56               ; underflow? ->
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
        sta npcTile,x
        sta npcLon,x
        sta npcLat,x
        sta npcHpHb,x
        jsr print
        .aasc "Killed!",$00
        lda zpMapPtr
        cmp #$04
        bne l8f7c
l8f75   lda #$01                ; 1 XP
        ldx #$00
        jmp l8f96
l8f7c   cmp #$05                ; 5 XP
        bne l8f87
        lda #$02
        ldx #$00
        jmp l8f96
l8f87   cmp #$01
        bne l8f92
        lda #$01                ; 1 XP
        ldx #$00
        jmp l8f96

l8f92   lda #$0f
        ldx #$00
l8f96   clc
        adc statsXp
        sta statsXp
        txa
        adc statsXp+1
        sta statsXp+1
        lda statsXp
        cmp #<9999
        lda statsXp+1
        sbc #>9999
        bcc l8fba
l8fb0   lda #<9999
        sta statsXp
        lda #>9999
        sta statsXp+1
l8fba   ldx $2c
        ldy $2d
        lda #$20
        jmp la5d3

cmdTwCast
l8fc3   jsr print
        .aasc "-- Hmmmm... no effect?",$00
        lda #$08
        jmp playSoundEffect

cmdTwDrop
l8fe2   jsr print
        .aasc " Pence,Weapon,Armour: ",$00
        jsr $8d45
        ldx #$06
        stx zpCursorCol
        ldx #$03
l9005   cmp _dropCmdChoices-1,x
        beq l900d
l900a   dex
        bne l9005
l900d   txa
        asl
        tay
        lda _dropCmdTable+1,y     ; drop command table
        pha
        lda _dropCmdTable,y
        pha
        jsr printFromTable
        .word _strTableDropItem
        jsr $164f
        inc zpCursorCol
_cmdTwDropNothing
l9022   rts

_dropCmdChoices
l9023
        .aasc "PWA"

_dropCmdTable
l9026
        .word _cmdTwDropNothing-1
        .word _cmdTwDropPence-1
        .word _cmdTwDropWeapon-1
        .word _cmdTwDropArmour-1

_cmdTwDropPence
l902e   jsr print
        .aasc $7e,"How much? ",$00
        jsr _enterNumber
        lda _numEntry
        ora _numEntry+1
        bne _townDropPenceJ1
        rts
_townDropPenceJ1
        lda statsCoin           ; owned coins >= entered number?
        cmp _numEntry
        lda statsCoin+1
        sbc _numEntry+1
        bcs _townDropPenceJ2    ; yes ->
        jsr print
        .aasc $7e,"Thou hast not that much!",$00
        jmp $8772
_townDropPenceJ2
        lda statsCoin           ; subtract coins to drop
        sec
        sbc _numEntry
        sta statsCoin
        lda statsCoin+1
        sbc _numEntry+1
        sta statsCoin+1
        ldx zpLongitude         ; get town tile at player location
        ldy zpLatitude
        jsr _getTownTile
        cmp #$61                ; nearby some water?
        beq _townDropPenceJ3    ; yes ->
        jsr print
        .aasc $7e,"Ok!",$00
        rts
_townDropPenceJ3
l909e   lda _numEntry
        sta zpMapPtr
        lda _numEntry+1
        lsr
        sta $4d
        ror zpMapPtr
        lda zpMapPtr
        clc
        adc _numEntry
        sta zpMapPtr
        lda $4d
        adc _numEntry+1
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
        .aasc $7e,"Shazam!",$00
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
        dec invSpells,x         ; prevent overflow
l9110   jsr print
        .aasc $7e,"Alakazot!",$00
        lda #$0a
        jmp playSoundEffect

_cmdTwDropWeapon
l9123   jsr l91a1
        .byt $0f
        .word invWeapons
        .word strTableLongWeapons
        bmi _cmdTwDropItemEnd
        tax                     ; selected weapon type as index
        lda #$00
        sta invWeapons,x        ; drop weapon, i.e. drop all of that kind
        cpx statsWeapon         ; weapon currently wielded?
        bne _cmdTwDropItemEnd   ; no ->
        sta statsWeapon         ; wield nothing (hands)
_cmdTwDropItemEnd
        jmp _drawTownMap

_cmdTwDropArmour
l913e   jsr l91a1
        .byt $05
        .word invArmour
        .word strTableArmour
        bmi _cmdTwDropItemEnd
        tax                     ; selected armour type as index
        lda #$00
        sta invArmour,x         ; drop armour, i.e. drop all of that kind
        cpx statsArmour
        bne _cmdTwDropItemEnd
l9153   sta statsArmour
        jmp _drawTownMap

_limitFood
l9159   lda statsFood           ; check that food <= 9999
        cmp #<9999
        lda statsFood+1
        sbc #>9999
        bcc _limitFoodEnd       ; food <= 9999? -> OK
        lda #<9999              ; else, set food to max: 9999
        sta statsFood
        lda #>9999
        sta statsFood+1
_limitFoodEnd
        rts

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
_strTableDropItem
        .aasc "nothin",$e7
        .aasc "penc",$e5
        .aasc "weapon",$ba
        .aasc "armour",$ba

l91a1   pla
        sta $83b5
        pla
        sta $83b6
        jsr $83ac               ; fetch parameter byte
l91ac   sta l9267
        jsr $83ac               ; fetch parameter byte
        sta $41
        jsr $83ac               ; fetch parameter byte
        sta $42
        jsr $83ac               ; fetch parameter byte
l91bc   sta l9263               ; (string table lb)
        jsr $83ac               ; fetch parameter byte
l91c2   sta l9264               ; (string table hb)
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
        lda ($41),y             ; # of this item in inventory
        bne l925d
l9250   ldy #$ff
        jsr print
        .aasc "none",$00
        tya
        tax
        rts
l925d   tya
l925e   tax
        pha
        jsr printFromTableCap
l9263   l9264 = * + 1
        .word $0000
l9265   pla
        rts
l9267   .byt $0a

cmdTwGet
l9268   jsr print
        .aasc " what",$00
        jmp cmdInvalid

cmdTwQuit
l9274   lda #18
        sta zpCursorCol
        jsr print
        .aasc " is",$7e
        .aasc "only allowed outdoors!",$00
        jmp $8772

cmdTwReady
l9299   jsr l8d45
        cmp #$53                ; 'S'
        beq _cmdTwReadyJ1
        cmp #$57                ; 'W'
        beq _cmdTwReadyJ1
        cmp #$41                ; 'A'
        beq _cmdTwReadyJ1
        rts
_cmdTwReadyJ1
        jsr $87d0
        jmp _drawTownMap

cmdTwSteal
l92af   ldx zpLongitude
        ldy zpLatitude
        jsr _getTownTile
        cmp #TW_TILE_HIDDEN_ARMOUR
        beq _stealJ1
        cmp #TW_TILE_HIDDEN_FOOD
        beq _stealJ1
        cmp #TW_TILE_HIDDEN_WEAPON
        beq _stealJ1
        jsr print
        .aasc $7e
        .aasc "Nothing here",$00
        jmp cmdInvalid
_stealJ1
        sta zpTwMapTile         ; store map tile
        jsr randomNumber
        cmp #$26                ; random < $26?
        bcc _stealFail          ; yes -> fail
        ldy _karma              ; bad karma?
        bne _stealFail          ; karma is bad -> fail
        ldy statsClass
        cpy #CLASS_THIEF        ; class = thief?
        beq _stealSuccess       ; yes -> success!
        cmp #$4d                ; random > $4d?
        bcs _stealSuccess       ; yes -> success!
_stealFail
        jsr print
        .aasc $7e,"Oh no! Thou wert caught!",$00
        lda #$01
        sta _karma
        rts
_stealSuccess
        jsr print
        .aasc $7e,"Thou dost find",$7e,$00
        lda zpTwMapTile
        cmp #TW_TILE_HIDDEN_ARMOUR
        bne _stealFood
_stealArmourL1
l932c   jsr la718
        lsr
        lsr
        lsr
        and #$07
        beq _stealArmourL1
        cmp #$06
        bcs _stealArmourL1
        tax
        inc invArmour,x         ; add to inventory
        bne _stealJ2            ; < 256 ->
        dec invArmour,x         ; else, limit to 256
        jmp _stealArmourL1      ; steal another armour instead
_stealJ2
        jsr printFromTable
        .word strTableArmour
        rts

_stealFood
l934c   cmp #TW_TILE_HIDDEN_FOOD
        bne _stealWeapon
_stealFoodL1
        jsr randomNumber
        and #$1f                ; steal between 2 and 31 bags of food
        cmp #$02
        bcc _stealFoodL1
        cmp #$1f
        bcs _stealFoodL1
        pha                     ; store number of food bags
        ldx #$00
        stx $85be
        jsr $8582               ; print number of bags
        jsr print
        .aasc " bags of food!",$00
        pla                     ; restore number of food bags
        clc
        adc statsFood           ; increase food
        sta statsFood
        bcc _stealFoodJ1
        inc statsFood+1
_stealFoodJ1
        jmp _limitFood

_stealWeapon
l9388   jsr la723
        lsr
        and #$0f
        beq _stealWeapon
        cmp #$0c
        bcc _stealWeaponJ1
        sta zpMapPtr
        jsr randomNumber
        cmp #$30
        bcs _stealWeapon
        lda zpMapPtr
_stealWeaponJ1
        pha
        lda #$61                ; 'a'
        jsr printChar
        pla
        pha
        cmp #WEAPON_AXE         ; steal an axe?
        beq _stealWeaponJ2      ; yes -> print article "an"
        cmp #WEAPON_AMULET      ; steal an amulet?
        bne _stealWeaponJ3      ;  no ->
_stealWeaponJ2
        lda #$6e                ; 'n'
        jsr printChar
_stealWeaponJ3
        lda #$20                ; ' '
        jsr printChar           ; print blank
        pla                     ; restore wepaon
        tax
        inc invWeapons,x        ; add to inventory
        bne _stealWeaponJ4      ; < 256 ->
        dec invWeapons,x        ; else, limit to 255
_stealWeaponJ4
        jsr printFromTable
        .word strTableLongWeapons
        rts

cmdTwTransact
l93c9   lda _karma              ; player's karma good?
        beq _transactJ1         ; yes ->
        jsr print
        .aasc $7e,"None will talk to thee!",$00
        rts
_transactJ1
        ldx zpLongitude
        ldy zpLatitude
        jsr _getTownTile
        cmp #$64                ; transact fields (start)
        bcc _transactJ2
        cmp #$6d                ; transact fields (end)
        bcs _transactJ2
        sec
        sbc #$64
        tax
        lda lada6,x
        sta zpMapPtr
        jmp _transactJ3
_transactJ2
        jsr print
        .aasc $7e
        .aasc "Thou art not by a counter!",$00
        rts
_transactJ3
        jsr print
        .aasc "-Buy, Sell: ",$00
        jsr l8d45
        ldx #$09
        stx zpCursorCol
        cmp #$42                ; 'B'
        beq _transactBuy
        cmp #$53                ; 'S'
        bne _transactJ4
        jmp _transactSell
_transactJ4
        jsr print
        .aasc "-none",$00
        jmp $164f
_transactBuy
l9454   jsr print
        .aasc "-Buy: ",$00
        jsr l9493
l9461   lda ladd2,x
        sta l946e
        lda ladd3,x
        sta l946f
        l946e = * + 1
        l946f = * + 2
        jsr $ffff
l9470   jmp _drawTownMap

_transactSell
        jsr print
        .aasc "-Sell: ",$00
        jsr l9493
        lda ladde,x
        sta l948e
        lda laddf,x
        sta l948f
        l948e = * + 1
        l948f = * + 2
        jsr $ffff
l9490   jmp _drawTownMap


l9493   jsr $164f
l9496   lda zpMapPtr            ; ?? shop id ??
        jsr $8788
l949b   dec zpWndWdth
        jsr l94ab
        jsr $83f3               ; newline in window
        jsr $83f3               ; newline in window
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
_townLayoutId = * + 1
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
        jsr $857c               ; print number ??
l950b   jsr $83f3               ; newline in window
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
        .aasc "nothing",$00
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
        sta _strFoodPrice
        jsr print
        .aasc $7e
        .aasc " Packs of 10 food cost "
_strFoodPrice
        .aasc "X pence",$7e
        .aasc "  each.  How many dost thou",$7e,$7f
        .aasc $06,"wish to purchase?",$00

l9609   jsr $870c
l960c   jsr $165b
l960f   lda #23
        sta zpCursorRow
        lda #15
        sta zpCursorCol
        jsr _enterNumber
l961a   jsr $8701
l961d   lda _numEntry+1
        cmp #$1a
        bcc l9627
l9624   jmp l9580
l9627   lda _numEntry
        ora _numEntry+1
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
        adc _numEntry
        sta zpMapPtr
        lda $4d
        adc _numEntry+1
        sta $4d
        dex
        bne l963b
l964d   asl _numEntry
        rol _numEntry+1
        lda _numEntry+1
        pha
        lda _numEntry
        pha
        asl _numEntry
        rol _numEntry+1
        asl _numEntry
        rol _numEntry+1
        pla
        clc
        adc _numEntry
        sta _numEntry
        pla
        adc _numEntry+1
        sta _numEntry+1
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
        adc _numEntry
        sta statsFood
        lda statsFood+1
        adc _numEntry+1
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
l96c7   jmp _limitFood

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
l9700   lda _townLayoutId
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
        jsr $857c               ; print number ??
l975e   jsr $83f3               ; newline in window
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
        jsr print
        .aasc ") ",$00
l97f2   ldx lad34
        jsr printFromTable
        .word strTableLongWeapons
l97fa   lda #$17
        sta zpCursorCol
        jsr print
l9801   and !zpLongitude
        ldx lad34
        lda statsCharisma
        clc
        adc #$28
        sta zpMapPtr
        lda _priceList,x
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
        jsr $857c               ; print number ??
l982d   jsr $83f3               ; newline in window
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
        lda statsCharisma       ; price unit = Charisma + 40
        clc
        adc #40
        sta zpMapPtr
        lda _priceList,x
        tax
        jsr la23f
l988a   lda lad31               ; sell price = price / 256 + 1
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
        lda _townLayoutId
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
        jsr $857c               ; print number ??
l993a   jsr $83f3               ; newline in window
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
l9989   lda statsXp+1
        bne l9998
l998e   lda statsXp
        cmp #$0a
        bcs l9998
l9995   jmp l957d
l9998   lda statsXp
        sec
        sbc #$0a
        sta statsXp
        bcs l99a6
l99a3   dec statsXp+1
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
        .aasc $7f
        .aasc $07,"Thou art broke!",$7e,$7e,$7f
        .aasc $03,"Come back when thou hast",$7e,$7f
        .aasc $05,"some money to spend.",$00
        jsr $85e1
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
        .aasc $7f
        .aasc $05,"about space travel!",$7e,$7f
        .aasc $05,"Thou must destroy at",$7e,$7f
        .aasc $04,"least 20 enemy vessels",$7e,$7f
        .aasc $06,"to become an ace!",$00
        rts

l9b8c   jsr print
        .aasc $7f
        .aasc $05,"to watch the ",$00
        ldx #$05                ; Wench / Lecher
        jsr printFromTable
        .word _strTableNpc
        lda #$2e                ; '.'
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

l9c40
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
        .aasc $7f
        .aasc $05,"this is a great game!",$00
        rts

l9cc3   jsr print
        .aasc "  that over 1000 years ago,",$7e
        .aasc "Mondain the Wizard created an",$7e
        .aasc " evil gem.  With this gem, he",$7e
        .aasc "  is immortal and cannot be",$7e,$7f
        .aasc $0a,"defeated.",$00
        jsr $85e1
        jsr la85a
        lda #$08
        sta zpCursorRow
        jsr print
        .aasc "The quest of --Ultima-- is to",$7e
        .aasc " traverse the lands in search",$7e,$7f
        .aasc $03,"of a time machine.  Upon",$7e
        .aasc " finding such a device, thou",$7e
        .aasc "should go back in time to the",$7e
        .aasc " days before Mondain created",$7e
        .aasc "the evil gem and destroy him.",$00
        jmp $85e1

l9e23
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
        .aasc $7f
        .aasc $06,"Closed for the day",$00
        jsr $85e1
        jmp l9580

l9e7a   lda lad36
        ora lad37
        beq l9eb2
l9e82   jsr print
        .aasc $7f
        .aasc $07,"a) Horse   - ",$00
        ldx #$01
        jsr l9fb0
        jsr print
        .aasc $7f
        .aasc $07,"b) Cart    - ",$00
        ldx #$02
        jsr l9fb0
l9eb2   lda lad35
        beq l9ee7
        jsr print
        .aasc $7f
        .aasc $07,"c) Raft    - ",$00
        ldx #$03
        jsr l9fb0
        jsr print
        .aasc $7f
        .aasc $07,"d) Frigate - ",$00
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
        .aasc $7f
        .aasc $07,"e) Air Car - ",$00
l9f15   ldx #$05
        jsr l9fb0
l9f1a   lda $8219
        bne l9f37
l9f1f   jsr print
        .aasc $7f
        .aasc $07,"f) Shuttle - ",$00
        ldx #$06
        jsr l9fb0
l9f37   jsr la190
l9f3a   cmp #$41                ; 'A'
        bcc l9f4b
        cmp #$47                ; 'F'
        bcs l9f4b
        sec
        sbc #$40                ; convert to 0-based transport id
        tax
        lda $ae62,x             ; item for sale at this shop (?)
        bne l9f4e
l9f4b   jmp l9580
l9f4e   stx $4d
        jsr la22b               ; calculate price for transport
l9f53   jsr la183               ; have enough gold?
l9f56   bcs l9f5b               ; yes ->
l9f58   jmp l957d
l9f5b   ldx $4d                 ; selected item
        inc invTransport,x
        cpx #TRANSPORT_SHUTTLE
        bne l9f74
l9f64   lda #<1000              ; initial shield value
        sta $825e
        sta $8260
        lda #>1000
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
        jsr $857c               ; print number ??
        jmp $83f3               ; newline in window

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
        .aasc ") ",$00
l9fef   ldx lad34
        jsr printFromTable
        .word strTableArmour
        lda #23
        sta zpCursorCol
        jsr print
        .aasc "- ",$00
        ldx lad34
        lda statsCharisma       ; sell price unit = charisma / 4
        lsr
        lsr
        sta zpMapPtr
        jsr la23f
la00e   lda #$00
        sta $85be
        ldx lad30
        lda lad31
        jsr $857c               ; print number ??
la01c   jsr $83f3               ; newline in window
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
        .aasc $7e,$7f
        .aasc $04,"Used food?  No thanks!",$00
        jsr $85e1
        jmp l9597

la0eb   jsr print
        .aasc $7e,$7f
        .aasc $03,"Sorry, we don't deal in",$7e,$7f
        .aasc $09,"used stuff.",$00
        jsr $85e1
        jmp l9597

la11d   jsr print
        .aasc $7e,$7f
        .aasc $05,"We don't buy spells!",$00
        jsr $85e1
        jmp l9597

la13e   jsr print
        .aasc $7e,$7f
        .aasc $03,"We have plenty of booze",$7e,$7f
        .aasc $0a,"already!",$00,"
        jsr $85e1
        jmp l9597

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
        jsr print
        .aasc $7f
        .aasc $0b,"Sold!",$00
        rts

la1b6   jsr la85a
la1b9   la1ba = * + 1
; Instruction parameter jumped to.
        jsr print
        .aasc $7f
        .aasc $0b,"Done!",$00
        rts

la1c5   jsr la85a
la1c8   jsr print
        .aasc "  Thou canst not afford it!   ",$00
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
        lda _priceList,x
        tax
        jsr la23f
la21c   lda lad31
        clc
        adc #$05
        sta lad30
        lda #$00
        sta lad31
        rts

la22b   lda #200
        sec
        sbc statsIntelligence
        ldy #$00                ; price unit = (200 - INT) / 5 + 1
la233   iny
        sec
        sbc #$05
        bcs la233
la239   sty zpMapPtr            ; price unit
        lda _priceList,x        ; price of item in price units
        tax
la23f   lda #$00
        sta lad30               ; price = 0
        sta lad31
la247   dex
        cpx #$ff
        beq la260
la24c   lda lad30
        clc
        adc zpMapPtr            ; price += price unit
        sta lad30
        lda lad31
        adc #$00
        sta lad31
        jmp la247
la260   rts


cmdTwUnlock
la261   jsr print
        .aasc " what",$00
        jmp cmdInvalid

cmdTwZtats
la26d   jsr $890c
        jmp _drawTownMap

la273   lda _karma
        bne la27b
la278   jmp la3ea
la27b   ldx #$0f
        stx lad2b
la280   ldx lad2b
        lda npcTile,x
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
        cmp npcLon,x
        beq la2b0
la2aa   bmi la2af
la2ac   iny
        bne la2b0
la2af   dey
la2b0   sty $24
        ldy #$00
        lda zpLatitude
        cmp npcLat,x
        beq la2c1
la2bb   bmi la2c0
la2bd   iny
        bne la2c1
la2c0   dey
la2c1   sty $25
        lda npcLat,x
        clc
        adc $25
        sta $2d
        lda npcLon,x
        clc
        adc $24
        sta $2c
        jsr randomNumber
la2d6   ora #$01
        sta la346
la2db   lda la346
        bmi la2f9
la2e0   ldx lad2b
        lda npcLon,x
        tax
        ldy $2d
        jsr la5eb
la2ec   bcc la331
la2ee   ldx lad2b
        lda npcLon,x
        sta $2c
        jmp la30e
la2f9   ldx lad2b
        ldy npcLat,x
        ldx $2c
        jsr la5eb
la304   bcc la331
la306   ldx lad2b
        ldy npcLat,x
        sty $2d
la30e   ldx lad2b
        ldy npcLat,x
        lda npcLon,x
        tax
        lda #$20
        jsr la5d3
la31d   ldx lad2b
        lda $2d
        sta npcLat,x
        tay
        lda $2c
        sta npcLon,x
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
        lda #$17
        sta zpCursorRow
        jsr print
        .aasc $7e
        .aasc "Attacked by guard!",$7e,$00
        lda #$04
        jsr playSoundEffect
        lda statsStamina
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
        .aasc "Missed!",$00
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
        .aasc "Hit... ",$00
        ldx #$00
        stx $85be
        lda $4d
        jsr $8582
la3c1   jsr print
la3c4   jsr $6164
la3c7   adc $6761
        adc $00
        lda #$02                ; sound effect: player hit
        jsr playSoundEffect
        lda statsHp
        sec
        sbc $4d
        sta statsHp
        lda statsHp+1
        sbc #$00
        sta statsHp+1
        bcs la3e7
la3e4   jmp _townPlayerDead
la3e7   jmp la33d

la3ea   ldy #$0f
        sty lad2b
la3ef   lda npcTile,y
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
        lda #23
        sta zpCursorRow
        inc lad29
        jsr print
        .aasc $7e
        .aasc "Iolo the Bard sings:",$7e
        .aasc "Ho eyoh he hum!",$00
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
        lda #23
        sta zpCursorRow
        inc lad29
        jsr print
        .aasc $7e
        .aasc "Iolo stole something!",$00
la4a3   rts
la4a4   ldy lad2b
        ldx npcLon,y
        lda npcLat,y
        tay
        lda #$20
        jsr la5d3
la4b3   ldy lad2b
        lda $2c
        sta npcLon,y
        tax
        lda $2d
        sta npcLat,y
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
        ldx npcLon,y
        lda npcLat,y
        tay
        lda #$20
        jsr la5d3
la4e8   ldy lad2b
        lda $2c
        sta npcLon,y
        tax
        lda $2d
        sta npcLat,y
        tay
        lda #$5f
        jmp la5d3

cmdTwInform
la4fc   ldx #0
        ldy #23
        jsr printAtPos
        .aasc $7e
        .aasc "the city of ",$00
        ldx statsLocation
        jsr printFromTable
        .word strTablePlaces
        rts

_drawTownMap
la51a   lda #1                  ; skip upper frame border
        sta zpCursorRow
        jsr $165e
        jsr la553               ; switch to town map charset
        lda #<townMap
        sta _townMapSrcPtr      ; set town map source pointer
        lda #>townMap
        sta _townMapSrcPtr+1
_drawTownMapL1
la52e   jsr printCR
_drawTownMapL2
_townMapSrcPtr = * + 1
        lda townMap             ; read a town map byte
        jsr printChar           ; print it
        inc _townMapSrcPtr      ; inc town map source pointer
        bne _drawTownMapJ1
        inc _townMapSrcPtr+1
_drawTownMapJ1
        lda zpCursorCol
        cmp #38                 ; repeat for 38 columns
        bne _drawTownMapL2
        inc zpCursorRow
        lda zpCursorRow
        cmp #19                 ; repeat for 18 rows
        bne _drawTownMapL1
        jsr la553               ; switch to regular character set
        jmp la59d

la553   ldx #$00
la555   lda charsetBackup,x
        ldy charset,x
        sta charset,x
        tya
        sta charsetBackup,x
        lda charsetBackup+$0100,x
        ldy charset+$0100,x
        sta charset+$0100,x
        tya
        sta charsetBackup+$0100,x
        lda charsetBackup+$0200,x
        ldy charset+$0200,x
        sta charset+$0200,x
        tya
        sta charsetBackup+$0200,x
        lda charsetBackup+$0300,x
        ldy charset+$0300,x
        sta charset+$0300,x
        tya
        sta charsetBackup+$0300,x
        dex
        bne la555
la58c   lda charColors,x
        ldy _charColorsTown,x
        sta _charColorsTown,x
        tya
        sta charColors,x
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
la5b1   lda npcLon,y
        sta zpCursorCol
        lda npcLat,y
        sta zpCursorRow
        inc zpCursorRow
        lda npcTile,y
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

la5eb   jsr _getTownTile
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

_getTownTile
la604   cpx #38
        bcc la60c
la608   lda #$60
        clc
        rts
la60c   cpy #18
        bcs la608
la610   lda twMapRowOffLb,y
        clc
        adc #<townMap
        sta la622
        lda twMapRowOffHb,y
        adc #>townMap
        sta la623
        la622 = * + 1
        la623 = * + 2
        lda $ffff,x
        cmp #$60                ; can player step on tile?
        bcs la629               ; yes ->
la628   rts
la629   stx zpMapPtr
        sty $4d
        ldx #$0f
        tay
la630   lda npcLon,x
        cmp zpMapPtr            ; compare with target x
        bne la648
la637   lda npcLat,x
        cmp $4d                 ; compare with target y
        bne la648
la63e   stx lad2e
        lda npcTile,x             ; read npc tile
        clc                     ; NPC found
        adc #$30
        rts
la648   dex
        bpl la630
la64b   tya                     ; background tile
        sec                     ; no NPC here
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
        adc npcLon,y
        sta $2c
        jsr la64e
la66e   clc
        adc npcLat,y
        sta $2d
        rts

_enterNumber
la675   lda #$00
        sta _numEntry           ; entered number, lb
        sta _numEntry+1         ; entered number, hb
        sta _numEntryStack+4    ; clear previous number
        sta _numEntryStack+5
        sta _numEntryDigit
_enterNumberL1
        jsr getKey
        beq _enterNumberL1
        cmp #KEY_RETURN         ; finish entry?
        bne _enterNumberJ1      ; yes ->
        lda _numEntryDigit
        bne _enterNumberEnd
        jsr print
        .aasc "0",$00
_enterNumberEnd
        rts

_enterNumberJ1
        cmp #KEY_BACKSPACE
        bne _enterNumberJ2      ; no backspace ->
        lda _numEntryDigit
        beq _enterNumberL1
        dec _numEntryDigit
        ldx #$05
_enterNumberL2
        lda _numEntryStack,x    ; restore previous number from entry stack
        sta _numEntryStack+2,x
        dex
        bpl _enterNumberL2
        dec zpCursorCol
        jmp _enterNumberL1

_enterNumberJ2
        cmp #$30                ; entry < '0'?
        bcc _enterNumberL1      ; yes -> ignore
        cmp #$3a                ; entry > '9'
        bcs _enterNumberL1      ; yes -> ignore
        pha                     ; store key entry
        jsr printChar           ; echo entry
        pla                     ; restore entry
        sec
        sbc #$30                ; convert to 0-based number
        pha                     ; store digit
        ldx #$00
_enterNumberL3
        lda _numEntryStack+2,x  ; store current number on entry stack
        sta _numEntryStack,x
        inx
        cpx #$06
        bne _enterNumberL3

        asl _numEntry           ; number = number * 10
        rol _numEntry+1         ; (calculate number * 2) 
        lda _numEntry+1         ;
        pha                     ; (store number * 2)
        lda _numEntry
        pha
        asl _numEntry           ; (calculate number * 8)
        rol _numEntry+1
        asl _numEntry
        rol _numEntry+1
        pla
        clc
        adc _numEntry           ; (add number * 2)
        sta _numEntry           ; (equals number * 10)
        pla
        adc _numEntry+1
        sta _numEntry+1
        pla                     ; restore recently entered digit
        clc
        adc _numEntry           ; add to number
        sta _numEntry
        bcc _enterNumberJ3
        inc _numEntry+1
_enterNumberJ3
        inc _numEntryDigit
        lda _numEntryDigit
        cmp #$04
        bcs _enterNumberJ4
        jmp _enterNumberL1
_enterNumberJ4
        rts

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
        lda npcLon,x
        cmp #$ff
        beq la7f0
la778   lda zpLongitude
        cmp #$ff
        beq la7f0
la77e   sec
        sbc npcLon,x
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
        sbc npcLat,x
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

_charColorsTown
la887
        .byt $60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60
        .byt $60,$60,$60,$60,$60,$60,$60,$60,$50,$50,$10,$a0,$70,$70,$70,$70
        .byt $70,$70,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10
        .byt $10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10
        .byt $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0
        .byt $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$10,$10,$10,$10,$10,$10
        .byt $10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10
        .byt $10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10

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
lad29
        .byt $00

_karma
        .byt $00
lad2b
        .byt $00

_numEntryDigit
lad2c
        .byt $00
lad2d
        .byt $00
lad2e
        lad2f = * + 1
        lad30 = * + 2
        lad31 = * + 3
        lad33 = * + 5
        lad34 = * + 6
        lad35 = * + 7
        lad36 = * + 8
        lad37 = * + 9
        lad38 = * + 10
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

_strTableNpc
lad39
        .aasc "Kin",$e7
        .aasc "Merchan",$f4
        .aasc "Princes",$f3
        .aasc "Guar",$e4
        .aasc "Jeste",$f2
_strBeggar
lad58
        .aasc "Wenc",$e8,$00
_strLecher
lad5e
        .aasc "Leche",$f2

twMapRowOffLb
lad64
        .byt $00,$26,$4c,$72,$98,$be,$e4,$0a
        .byt $30,$56,$7c,$a2,$c8,$ee,$14,$3a
        .byt $60,$86

twMapRowOffHb
lad76
        .byt $00,$00,$00,$00,$00,$00,$00,$01
        .byt $01,$01,$01,$01,$01,$01,$02,$02
        .byt $02,$02

lad88
        .byt $01,$01,$01,$01,$01,$01,$01,$03,$01,$01,$01,$01,$03
        lad98 = * + 3
        .byt $01,$03,$03,$1e,$5f,$5f,$2f,$5c,$5f,$02,$07,$08,$07,$03,$0c,$04
        lada6 = * + 1
        ladaf = * + 10
        .byt $0b,$00,$00,$01,$01,$02,$02,$03,$04,$05,$01,$01,$01,$00,$00,$01
ladb5
        .byt $01

_priceList
ladb6
        .byt $00,$01,$04,$09,$10,$19,$24,$31,$40,$51,$64,$79,$90

        .byt $a9,$c4,$e1

ladc6


   ladc7 = * + 1
        .byt $17
        .asc "+"
        .byt $71
        .asc ",U+"
        .byt $67
        .asc "*U)"

        .word la907

                                ; transact: buy
ladd2
        ladd3 = * + 1
        .word l94c3
        .word l959e             ; buy food
        .word l96ca
        .word l98d2             ; buy spells
        .word l99c1
        .word l9e23             ; buy transport

                                ; transact: sell
ladde   laddf = * + 1
        ladea = * + 12
        ladeb = * + 13
        .word l9fc7
        .word la0c8             ; "Used food?  No thanks!"
        .word l97b7
        .word la11d             ; "We don't buy spells!"
        .word la13e             ; "We have plenty of booze"
        .word la0eb             ; "Sorry, we don't deal in used stuff..."
        .word l9b2e             ; "about space travel..."
        .word l9b8c             ; "to watch the..."
        .word l9bab             ; "that the princess will give..."
        .word l9c1f             ; "thou must go back in time..."
        .word $9c40             ; "thou should destroy..."
        .word l9c6a             ; "that many lakes..."
        .word l9ca7             ; "this is a great game..."
        .word l9cc3             ; "that over 1000 years ago,..."
        lae00 = * + 6
        .byt $00,$01,$00,$01,$00,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$01,$00,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$00,$00,$00,$00
        .byt $00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01
        .byt $00,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00

_numEntryStack
        _numEntry = * + 6
lae5a   .byt $8d

