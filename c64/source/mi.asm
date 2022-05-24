; MI

loadFile = $c480
saveFile = $c483
loadSpecial = $c486
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
VicScreenCtrlReg1 = $d011
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
VicBorderColor = $d020
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
SETLFS = $ffba
SETNAM = $ffbd
OPEN = $ffc0
CLOSE = $ffc3
CHKIN = $ffc6
CHKOUT = $ffc9
CLRCHN = $ffcc
CHRIN = $ffcf
CHROUT = $ffd2
LOAD = $ffd5
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
        .word $7400
        * = $7400

l7400   jmp l8c9e
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$03
        .byt $00,$00,$00,$07,$1f,$7f,$ff,$ff,$07,$3f,$ff,$ff,$ff,$ff,$ff,$ff
        .byt $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$80
        .asc "p|"
        .byt $ff,$ff,$ff,$ff,$ff
        .byt $00,$00,$00,$80
        .asc "@p|"
        .byt $ff,$00,$00,$00,$00,$00,$00,$00,$00
        l744d = * + 10
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        l7461 = * + 14
        .byt $03,$0f,$0f,$1f,$3f,$7f,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        l7465 = * + 2
        l7469 = * + 6
        .byt $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
l7473   .byt $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byt $80
        .asc "@"
l7485   cpx #$f0
        beq l7485
        .asc "~~"
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$02,$03,$07,$07
        .byt $07,$0f,$7f,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byt $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byt $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byt $ff,$ff
        .asc "~"
        .byt $ff,$ff,$ff,$ff,$ff,$ff,$ff,$00,$80,$80
        .asc "@@@"
        .asc "@@"
        .byt $0f,$0f,$0f,$0f,$0f,$1f,$1f,$1f,$ff,$ff,$ff,$ff,$ff,$ff
        .byt $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byt $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byt $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byt $ff,$ff
        .asc "``````@@"
        .byt $1f,$1f,$1f,$0f,$0f,$0f
        .byt $0f,$0f,$ff,$ff,$ff,$ff
l752f   inc $f0f8,x
        l7533 = * + 1
        beq l7533
        .byt $ff
        .asc "x"
        .byt $80,$00,$00,$00,$00,$ff,$ff,$7f,$3f,$1f,$17,$0f,$0f,$ff
        .byt $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .asc "|"
l754d   beq l752f
l754f   cpx #$e0
        cpx #$c0
        .byt $ff,$7f,$01,$00,$00,$00,$00,$00,$ff,$ff,$ff,$7f,$7f,$1f,$1f,$1f
        .asc "@@@"
        .byt $80,$80,$80,$80,$80,$07,$07,$07,$07,$07,$03,$03,$03
        .asc "p"
l7574   l7575 = * + 1
; Instruction parameter jumped to.
        cpx #$e0
l7576   l7577 = * + 1
; Instruction parameter jumped to.
        cpx #$e0
l7578   cpx #$f0
        beq l757c
l757c   .byt $00,$00,$00,$00,$00,$00,$00,$03,$07,$07,$07,$0f,$1f,$7f,$ff,$ff
        .byt $ff,$ff,$ff,$ff,$ff,$ff,$ff
l7593   cpy #$c0
        cpy #$c0
        cpy #$e0
        beq l7593
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$1f,$1f,$1f,$1f,$1f,$1f,$3f,$3f
        .byt $80,$80,$80
        .asc "@@@@@"
        .byt $03,$03,$03,$03,$03,$03,$03,$03
        .asc "px|~"
        .byt $ff,$ff,$ff,$ff,$01,$07,$0f,$1f,$ff,$ff,$ff,$ff
        .byt $ff,$ff,$ff
        .asc "~~||x7"
        .byt $83,$03,$01,$01,$00,$00,$00
        .asc "~"
        .byt $ff,$ff,$ff,$ff,$ff,$ff,$ff,$00,$80
        .asc "`"
        .byt $ff,$ff,$ff,$ff,$ff
        .asc ""
        .byt $3f,$7f,$ff,$ff,$ff,$ff,$ff,$ff
        .asc "@@@@@@@"
        .byt $80
        .byt $03,$03,$01,$01,$01,$00,$00,$00,$ff,$ff,$ff,$ff,$ff,$ff,$7f,$7f
        .byt $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .asc "xxppxx"
        .byt $ff,$ff
        .byt $00,$00,$00,$00,$00
        .asc "!"
        .byt $ff,$ff,$7f,$7f,$7f,$7f,$ff,$ff,$ff,$ff
        .byt $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .asc "~~|"
        .byt $78
        .byt $80,$80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .asc ""
        .byt $3f,$3f,$1e,$1f,$0f,$0f,$0f,$07,$ff
        .asc "wOOOGGO"
        l7665 = * + 10
        .byt $ff,$ff,$ff,$ff,$ff,$ff,$ff
        .asc "{"
        .byt $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byt $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .asc "oaqqsssw"
        .asc "xpp`````"
        .byt $00,$00,$00,$00,$00,$00,$00,$00
        l768c = * + 1
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$07,$07,$07,$07,$07,$03,$03,$03
        .byt $ff
        .asc "{k{"
        .byt $ff
        .asc "}zzo"
        .byt $52,$52,$52
        .asc "b"
        .byt $7e
        .asc "g$"
        .asc ""
        .byt $79,$79,$11,$11,$11,$17
        .asc "|"
        .byt $92,$ff,$35,$01,$05,$15,$7f
        .asc "M"
        .byt $4d
        .byt $ff,$9f
        .asc "/??"
        .byt $ff
        .asc "o"
        .byt $5f
        .asc "````@@@@"
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $03,$01,$01,$00,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$7f,$7f,$3f,$1f
        .asc "$l"
        .byt $ff,$ff,$ff,$ff,$ff,$ff,$96,$96,$97
        .asc "o"
        .byt $ff,$ff,$ff,$ff
        .asc ""
        .byt $49
        .asc "KO"
        .byt $7f,$ff,$ff,$ff,$ff,$7f,$ff,$ff,$ff
l7707   inc $f8fc,x
        beq l768c
        .byt $80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0f
        .byt $07,$03,$00,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$3f,$0f,$00,$00,$ff
        l7741 = * + 5
        .byt $ff,$ff,$ff,$ff,$ff,$00,$00,$ff,$ff,$ff
        .asc "~|"
l7748   beq l774a
l774a   l7754 = * + 10
        .byt $00
        .asc "`@"
        .byt $80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00

l7763
_strTableRace
        .aasc "lizar",$e4
        .aasc "huma",$ee
        .aasc "el",$e6
        .aasc "dwar",$e6
        .aasc "bobbi",$f4
        .aasc "hand",$f3
        .aasc "dagge",$f2
        .aasc "mac",$e5
        .aasc "ax",$e5
        .aasc "rope & spike",$f3
        .aasc "swor",$e4
        .aasc "great swor",$e4
        .aasc "bow & arrow",$f3
        .aasc "amule",$f4
        .aasc "wan",$e4
        .aasc "staf",$e6
        .aasc "triangl",$e5
        .aasc "pisto",$ec
        .aasc "light swor",$e4
        .aasc "phazo",$f2
        .aasc "blaste",$f2
        .aasc "hand",$f3
        .aasc "dagge",$f2
        .aasc "mac",$e5
        .aasc "ax",$e5
        .aasc "rop",$e5
        .aasc "swor",$e4
        .aasc "g swor",$e4
        .aasc "bo",$f7
        .aasc "amule",$f4
        .aasc "wan",$e4
        .aasc "staf",$e6
        .aasc "triangl",$e5
        .aasc "pisto",$ec
        .aasc "l swor",$e4
        .aasc "phazo",$f2
        .aasc "blaste",$f2
_strTableAttributes
l7842
        .aasc "Hit point",$f3
        .aasc "Strengt",$e8
        .aasc "Agilit",$f9
        .aasc "Stamin",$e1
        .aasc "Charism",$e1
        .aasc "Wisdo",$ed
        .aasc "Intelligenc",$e5
        .aasc "Gol",$e4
        .aasc "Rac",$e5
        .aasc "Typ",$e5
_strTableSpell
        .aasc "Praye",$f2
        .aasc "Ope",$ee
        .aasc "Unloc",$eb
        .aasc "Magic Missil",$e5
        .aasc "Stea",$ec
        .aasc "Ladder Dow",$ee
        .aasc "Ladder U",$f0
        .aasc "Blin",$eb
        .aasc "Creat",$e5
        .aasc "Destro",$f9
        .aasc "Kil",$ec
        .aasc "ski",$ee
        .aasc "leather armou",$f2
        .aasc "chain mai",$ec
        .aasc "plate mai",$ec
        .aasc "vacuum sui",$f4
        .aasc "reflect sui",$f4
l7911
_strTableClass
        .aasc "peasan",$f4
        .aasc "fighte",$f2
        .aasc "cleri",$e3
        .aasc "wizar",$e4
        .aasc "thie",$e6
        .aasc "foo",$f4
        .aasc "hors",$e5
        .aasc "car",$f4
        .aasc "raf",$f4
        .aasc "frigat",$e5
        .aasc "airca",$f2
        .aasc "shuttl",$e5
        .aasc "phanto",$ed
        .aasc "star cruise",$f2
        .aasc "battle bas",$e5
        .aasc "time machin",$e5
_strTableDirection
        .aasc "Nort",$e8
        .aasc "Sout",$e8
        .aasc "Eas",$f4
        .aasc "Wes",$f4
        .aasc "Pas",$f3
        .aasc "Attack",$a0
        .aasc "Board",$a0
        .aasc "Cast",$a0
        .aasc "Dro",$f0
        .aasc "Ente",$f2
        .aasc "Fire",$a0
        .aasc "Ge",$f4
        .aasc "HyperJum",$f0
        .aasc "Inform and searc",$e8
        .aasc "K-lim",$e2
        .aasc "Nois",$e5
        .aasc "Ope",$ee
        .aasc "Quit- saving game..",$ae
        .aasc "Ready Weapon,Armour,Spell:",$a0
        .aasc "Stea",$ec
        .aasc "Transac",$f4
        .aasc "Unloc",$eb
        .aasc "Vie",$f7
        .aasc "X-i",$f4
        .aasc "Ztat",$f3
l7a30
        .aasc "Red Ge",$ed
        .aasc "Green Ge",$ed
        .aasc "Blue Ge",$ed
        .aasc "White Ge",$ed

        .byt $0a,$05,$04,$03,$02,$01,$04,$06,$08,$0a,$01,$02,$04,$06,$08
        l7a69 = * + 9
        l7a6a = * + 10
        l7a6f = * + 15
        .byt $02,$04,$06,$08,$09,$0a,$02,$02,$03,$03,$03,$04,$04,$04,$05,$05
        .byt $05,$06,$06,$06,$07,$07,$07,$08,$08,$08,$09,$09,$09,$0a,$0a
        .asc " "
        .asc "     "
l7a85
        .aasc "Ness creatur",$e5
        .aasc "giant squi",$e4
        .aasc "dragon turtl",$e5
        .aasc "pirate shi",$f0
        .aasc "hoo",$e4
        .aasc "bea",$f2
        .aasc "hidden arche",$f2
        .aasc "dark knigh",$f4
        .aasc "evil tren",$f4
        .aasc "thie",$e6
        .aasc "or",$e3
        .aasc "knigh",$f4
        .aasc "necromance",$f2
        .aasc "evil range",$f2
        .aasc "wandering warloc",$eb
        .aasc "range",$f2
        .aasc "skeleto",$ee
        .aasc "thie",$e6
        .aasc "giant ra",$f4
        .aasc "ba",$f4
        .aasc "giant spide",$f2
        .aasc "vipe",$f2
        .aasc "or",$e3
        .aasc "cyclop",$f3
        .aasc "gelatinous cub",$e5
        .aasc "etti",$ee
        .aasc "mimi",$e3
        .aasc "lizard ma",$ee
        .aasc "minotau",$f2
        .aasc "carrion creepe",$f2
        .aasc "tangle",$f2
        .aasc "gremli",$ee
        .aasc "wandering eye",$f3
        .aasc "wrait",$e8
        .aasc "lic",$e8
        .aasc "invisible seeke",$f2
        .aasc "mind whippe",$f2
        .aasc "zor",$ee
        .aasc "daemo",$ee
        .aasc "balro",$ee
        .aasc "Lord Britis",$e8
        .aasc "the Feudal Lord",$f3
        .aasc "the Dark Unknow",$ee
        .aasc "Danger and Despai",$f2

l7c18
        .byt $1f,$14,$03,$02,$06,$24,$16,$35,$1e,$04,$2a,$0f,$3d
l7c25   jsr $3622
        l7c2e = * + 6
        .byt $15,$38,$1b,$38,$0f,$5e,$56,$7b,$5a,$48,$43,$5d,$71,$53,$66,$74
        .asc ""
        .byt $6b,$5c,$5d,$78,$4f,$64,$6a,$48,$7c
l7c41   ror $a1,x
        lda #$84
        lda $b7
        ldy $a28e,x
        ldy l8b99
        sty $a3,x
        ldx #$87
        bcs l7bee
        .byt $95
        .asc "7"
        .byt $83,$89
        .asc "_TCBFdVu^DjO"
        .asc "}`bvUx[xO"
        .byt $1e,$16,$3b,$1a,$08,$03,$31
        l7c77 = * + 4
        .byt $1d,$13,$26,$34,$2b,$1c,$1d,$38,$0f,$24,$2a,$08,$3c,$36,$1f,$14
        .byt $03,$02,$06,$24,$35,$16,$1e,$04,$2a,$0f,$3d
l7c8e   jsr $3622
        .byt $15,$38,$1b,$38,$0f,$1f,$14,$03,$02,$06,$24,$16,$35,$1e,$04,$2a
        .byt $0f,$3d
l7ca3   jsr $3622
        .byt $15,$38,$1b,$38,$0f,$21,$29,$04,$25,$37,$3c,$0e,$22,$2c,$19,$0b
        .byt $14,$23,$22,$07
l7cba   bmi l7cd7
l7cbc   ora $37,x
        .byt $03,$09,$54,$68,$65
l7cc3   jsr $6143
        .asc ""
        .byt $73,$74
l7cc8   jmp ($2065)
        .asc ""
        .byt $6f
l7ccc   ror $20
        jmp $726f
        .asc ""
        .byt $64
l7cd2   jsr $7242
l7cd5   adc #$74
l7cd7   adc #$73
        inx
        .asc ""
        .byt $54,$68,$65
l7cdd   jsr $6143
        .asc ""
        .byt $73,$74
l7ce2   jmp ($2065)
        .asc ""
        .byt $6f,$66
l7ce7   jsr $6874
l7cea   adc $20
        jmp $736f
        .asc ""
        .byt $74
l7cf0   jsr $694b
        .asc ""
        .byt $6e
        .asc "g"
        .byt $54,$68,$65
l7cf8   jsr $6f54
        .asc ""
        .byt $77
l7cfc   adc $72
        jsr $666f
l7d01   jsr $6e4b
        .asc ""
        .byt $6f,$77
l7d06   jmp ($6465)
        .asc ""
        .byt $67
l7d0a   sbc $54
        pla
        adc $20
        bvc l7d7a
l7d11   jmp ($616c)
        .asc ""
        .byt $72,$73
l7d16   jsr $666f
l7d19   jsr $7250
        .asc ""
        .byt $6f,$74,$65,$63,$74,$69,$6f
        .asc "n"
        .byt $54,$68,$65,$20,$44,$75,$6e,$67
l7d2c   adc $6f
        ror $6f20
        ror $20
        bvc l7d9a
        .asc ""
        .byt $72,$69,$6e,$69
l7d39   sbc ($54,x)
        pla
        adc $20
        jmp $736f
        .asc ""
        .byt $74
l7d42   jsr $6143
        .asc ""
        .byt $76
l7d46   adc $72
        ror $54f3
        pla
        adc $20
        eor $6e69
        adc $73
        jsr $666f
l7d56   jsr l744d
        .asc ""
        .byt $2e
l7d5a   jsr $7244
        .asc ""
        .byt $61,$73
        .asc "h"
        .byt $54
l7d61   pla
        adc $20
        eor $6e69
        adc $73
        jsr $666f
        .asc ""
        .byt $20
l7d6d   eor $2e74
        jsr $7244
l7d73   adc ($73,x)
        pla
        jsr $c949
        l7d7a = * + 1
        .asc ""
        .byt $4d,$6f,$6e,$64
l7d7d   adc ($69,x)
        ror $7327
        jsr $6147
        .asc ""
        .byt $74,$65
l7d87   jsr $6f74
l7d8a   jsr $6548
l7d8d   jmp ($54ec)
        .asc ""
        .byt $68,$65
l7d92   jsr $6e55
        .asc ""
        .byt $68,$6f
l7d97   jmp ($2079)
l7d9a   pha
        .asc ""
        .byt $6f
l7d9c   jmp ($54e5)
        .asc ""
        .byt $68,$65,$20,$44,$75,$6e,$67,$65,$6f,$6e
l7da9   jsr $666f
l7dac   jsr $6f44
        .asc ""
        .byt $75,$62
        .asc "t"
        .byt $54,$68,$65,$20,$44,$75,$6e,$67,$65,$6f,$6e
l7dbd   jsr $666f
l7dc0   jsr $6f4d
        .asc ""
        .byt $6e,$74,$6f
        .asc "r"
        .byt $44,$65,$61,$74,$68,$27,$73
l7dce   jsr l7741
        .asc ""
        .byt $61,$6b,$65,$6e,$69,$6e
        .asc "g"
        .byt $42,$72,$69,$74,$61,$69
        .asc "n"
        .byt $4d,$6f
        .asc ""
        .byt $6f
        .asc "n"
        .byt $46,$61,$77
        .asc "n"
l7de7   bvc l7e4a
        .asc ""
        .byt $77
        .asc "s"
        .byt $4d,$6f,$6e,$74,$6f
        .asc "r"
        .byt $59,$65
        .asc "w"
        .byt $54,$75,$6e
        .asc "e"
        .byt $47
        .asc ""
        .byt $72,$65
        .asc "y"
        .byt $54,$68,$65
l7dff   jsr $6143
        .asc ""
        .byt $73,$74
l7e04   jmp ($2065)
        .asc ""
        .byt $42,$61,$72,$61,$74,$61,$72,$69
        .asc "a"
        .byt $54,$68,$65
l7e13   jsr $6143
        .asc ""
        .byt $73,$74
l7e18   jmp ($2065)
        .asc ""
        .byt $52,$6f,$6e,$64,$6f,$72
l7e21   jmp ($ee69)
        .asc ""
        .byt $54
l7e25   pla
        adc $20
        bvc l7e93
l7e2a   jmp ($616c)
        .asc ""
        .byt $72
l7e2e   jsr $666f
l7e31   jsr l7a4f
        .asc ""
        .byt $79,$6d,$61,$6e,$64,$69,$61
        .asc "s"
        .byt $54
l7e3d   pla
        adc $20
        bvc l7eab
l7e42   jmp ($616c)
        .asc ""
        .byt $72,$73
l7e47   jsr $666f
l7e4a   jsr $6874
        .asc ""
        .byt $65
l7e4e   jsr $7241
        .asc ""
        .byt $67,$6f,$6e,$61,$75,$74
        .asc "s"
        .byt $53,$63,$6f,$72
l7e5c   bvs l7ec7
        .asc ""
        .byt $6f,$6e
l7e60   jsr $6f48
l7e63   jmp ($54e5)
        .asc ""
        .byt $68,$65
l7e68   jsr $6153
        .asc ""
        .byt $76
l7e6c   adc ($67,x)
        adc $20
        bvc l7ede
        .asc ""
        .byt $61,$63
        .asc "e"
        .byt $54,$68,$65
l7e78   jsr $6f48
        .asc ""
        .byt $72,$72,$6f,$72
l7e7f   jsr $666f
l7e82   jsr $6874
l7e85   adc $20
        pha
        adc ($72,x)
        bvs l7ef5
        .asc ""
        .byt $65
        .asc "s"
        .byt $54,$68,$65
l7e91   l7e93 = * + 2
        jsr $6f48
        .asc ""
        .byt $72,$72,$6f,$72
l7e98   jsr $666f
l7e9b   jsr $6874
l7e9e   adc $20
        pha
        adc ($72,x)
        bvs l7f0e
l7ea5   adc $73
        jsr $c949
        l7eab = * + 1
        .asc ""
        .byt $41,$64,$76,$61,$72,$69,$27,$73
l7eb2   jsr $6f48
l7eb5   jmp ($54e5)
l7eb8   pla
        adc $20
        jmp $6261
        .asc ""
        .byt $79,$72,$69,$6e,$74
        .asc "h"
        .byt $54,$68,$65
l7ec7   jsr $6f47
        .asc ""
        .byt $72,$67,$6f
l7ecd   ror $7327
        jsr $6f48
l7ed3   jmp ($57e5)
        .asc ""
        .byt $68,$65,$72,$65
l7eda   jsr $6548
        l7ede = * + 1
        .asc ""
        .byt $72,$63
l7edf   adc $6c,x
        adc $73
        jsr $6944
        .asc ""
        .byt $65
        .asc "d"
        .byt $54,$68,$65
l7eeb   jsr $6544
l7eee   adc ($64,x)
        jsr $6157
        .asc ""
        .byt $72,$72
l7ef5   adc #$6f
        .asc ""
        .byt $72,$27,$73
l7efa   jsr $6946
        .asc ""
        .byt $67,$68
        .asc "t"
        .byt $41,$72,$6e,$6f
l7f04   jmp ($4ce4)
        .asc ""
        .byt $69
l7f08   ror $e164
        pha
        adc $6c
l7f0e   adc $ee
        .asc ""
        .byt $4f,$77,$65
        .asc "n"
        .byt $4a,$6f,$68
        .asc "n"
        .byt $47,$65,$72,$72
l7f1c   sbc $6f57,y
        jmp ($54e6)
        .asc ""
        .byt $68,$65
l7f24   jsr $6e53
        .asc ""
        .byt $61,$6b
        .asc "e"
        .byt $54,$68,$65
l7f2d   jsr $6143
        .asc ""
        .byt $73,$74
l7f32   jmp ($2065)
        .asc ""
        .byt $6f,$66
l7f37   jsr $6c4f
        .asc ""
        .byt $79,$6d
l7f3c   bvs l7fb3
        .asc "s"
        .byt $54,$68,$65
l7f42   jsr $6c42
        .asc ""
        .byt $61,$63,$6b
l7f48   jsr $7244
        .asc ""
        .byt $61,$67,$6f
l7f4e   ror $7327
        jsr $6143
        .asc ""
        .byt $73,$74
l7f56   jmp ($54e5)
        .asc ""
        .byt $68,$65
l7f5b   jsr $6953
        .asc ""
        .byt $67,$6e
l7f60   jsr $6f50
        .asc ""
        .byt $73
        .asc "t"
        .byt $54,$68,$65
l7f68   jsr $6f53
        .asc ""
        .byt $75,$74,$68,$65,$72,$6e
l7f71   jsr $6953
        .asc ""
        .byt $67,$6e
l7f76   jsr $6f50
        .asc ""
        .byt $73
        .asc "t"
        .byt $54
l7f7c   pla
        adc $20
        eor l7465
        adc ($6c,x)
        jsr l7754
        .asc ""
        .byt $69,$73,$74,$65
        .asc "r"
        .byt $54,$68,$65
l7f8f   jsr $7254
        .asc ""
        .byt $6f
l7f93   jmp ($276c)
        .asc ""
        .byt $73
l7f97   jsr $6f48
l7f9a   jmp ($54e5)
l7f9d   pla
        adc $20
        lsr $69,x
        bvs l8009
        .asc ""
        .byt $72,$27,$73
l7fa7   jsr $6950
        .asc "t"
        .byt $54
l7fac   pla
        adc $20
        lsr $69,x
        bvs l8018
l7fb3   .asc ""
        .byt $72,$27,$73
l7fb6   jsr $6950
        .asc ""
        .byt $74
l7fba   jsr $c949
        .asc ""
        .byt $54,$68,$65,$20,$47
l7fc2   adc $69,x
        jmp ($2064)
        .asc ""
        .byt $6f,$66
l7fc9   jsr $6544
        .asc ""
        .byt $61,$74
        .asc "h"
        .byt $54,$68,$65
l7fd2   jsr $6e45
        .asc ""
        .byt $64,$2e,$2e
        .asc "."
        .byt $54,$68,$65
l7fdc   jsr $7254
l7fdf   adc ($6d,x)
        bvs l8003
        .asc ""
        .byt $6f,$66
l7fe5   jsr $6f44
        .asc ""
        .byt $6f
l7fe9   sbc $6854
        adc $20
        jmp $6e6f
        .asc ""
        .byt $67
l7ff2   jsr $6544
        .asc ""
        .byt $61,$74
        .asc "h"
        .byt $54,$68,$65
l7ffb   jsr $6c53
        .asc ""
        .byt $6f,$77
l8000   jsr $6544
l8003   adc ($74,x)
        inx
        lsr $7361
l8009   .asc ""
        .byt $73,$61
l800b   sbc $43,x
        jmp ($6165)
        .asc ""
        .byt $72
l8011   jsr $614c
        l8018 = * + 4
        .asc ""
        .byt $67,$6f,$6f
        .asc "n"
        .byt $53,$74,$6f,$75
        .asc "t"
        .byt $47,$61,$75,$6e,$74
l8022   jmp ($f465)
        .asc ""
        .byt $49,$6d,$61,$67,$69,$6e,$61,$74,$69,$6f
        .asc "n"
l8030   bvc l80a1
        .asc ""
        .byt $6e,$64,$65
        .asc "r"
        .byt $57
l8037   adc $61
        jmp ($e874)
l803c   bvc l80ad
        .asc ""
        .byt $6f
        .asc "r"
        .byt $54,$68,$65
l8043   jsr $6857
        .asc ""
        .byt $69,$74,$65
l8049   jsr $7244
        .asc ""
        .byt $61,$67,$6f
l804f   ror $7327
        jsr $6143
        .asc ""
        .byt $73,$74
l8057   jmp ($54e5)
        .asc ""
        .byt $68,$65
l805c   jsr $6143
        .asc ""
        .byt $73,$74
l8061   jmp ($2065)
        .asc ""
        .byt $6f,$66
l8066   jsr $6853
        .asc ""
        .byt $61,$6d,$69,$6e
        .asc "o"
        .byt $54,$68,$65
l8071   jsr $7247
        .asc ""
        .byt $61
l8075   ror $65,x
        jsr $666f
l807a   jsr $6874
l807d   adc $20
        jmp $736f
        .asc ""
        .byt $74
l8083   jsr $6f53
        .asc ""
        .byt $75
        .asc "l"
        .byt $45,$61,$73,$74,$65,$72,$6e
l808f   jsr $6953
        .asc ""
        .byt $67,$6e
l8094   jsr $6f50
        .asc ""
        .byt $73
        .asc "t"
        .byt $53
l809a   bvs l8105
l809c   ror $2065
        .asc ""
        .byt $42,$72
l80a1   adc $61
        .asc ""
        .byt $6b
l80a4   adc $f2
        lsr $72
        adc $65
        jsr $6544
l80ad   adc ($74,x)
        pla
        jsr $6f48
l80b3   jmp ($54e5)
        .asc ""
        .byt $68,$65
l80b8   jsr $6544
l80bb   adc ($64,x)
        jsr $6143
        .asc ""
        .byt $74,$27,$73
l80c3   jsr $694c
        .asc ""
        .byt $66
        .asc "e"
        .byt $54,$68,$65
l80cb   jsr $6544
l80ce   adc ($64,x)
        jsr $6143
        .asc ""
        .byt $74,$27,$73
l80d6   jsr $694c
l80d9   ror $65
        jsr $c949
        .asc ""
        .byt $54,$68,$65
l80e1   jsr $6f4d
        .asc ""
        .byt $72,$62
l80e6   adc #$64
        jsr $6441
        .asc ""
        .byt $76,$65,$6e,$74,$75,$72
        .asc "e"
        .byt $54,$68,$65
l80f5   jsr $6b53
l80f8   adc $6c,x
        jmp ($5320)
        .asc ""
        .byt $6d,$61,$73,$68,$65
        .asc "r"
        .byt $44,$65
l8105   adc ($64,x)
        jsr $614d
l810a   ror $7327
        jsr $6157
l8110   jmp ($54eb)
        .asc ""
        .byt $68,$65,$20,$44,$75,$6e,$67,$65,$6f,$6e
l811d   jsr $666f
l8120   jsr $6f44
        .asc ""
        .byt $6f
l8124   sbc $6f48
        jmp ($2065)
        .asc ""
        .byt $74,$6f
l812c   jsr $6148
        .asc ""
        .byt $64,$65
        .asc "s"
        .byt $47,$6f,$72
l8135   jmp ($e261)
        .asc ""
        .byt $44,$65,$78,$74,$72,$6f
        .asc "n"
        .byt $4d,$61,$67,$69
        .asc "c"
        .byt $57
l8145   pla
        adc $65
        jmp ($f265)
        .asc ""
        .byt $42
l814c   adc $6c,x
        jmp ($6f64)
        .asc ""
        .byt $7a,$65
        .asc "r"
        .byt $54,$68,$65
l8157   jsr $7242
        .asc ""
        .byt $6f,$74,$68,$65
        .asc "r"
        .byt $54,$68,$65,$20,$54,$75,$72,$74
l8167   jmp ($4ce5)
        .asc ""
        .byt $6f,$73,$74
l816d   jsr $7246
l8170   adc #$65
        ror $f364
l8175   bcc l818e
l8177   jsr _print
        .byt $7d
        .byt $44,$69,$73,$6b
l817f   jsr $7265
        .asc ""
        .byt $72,$6f,$72
l8185   jsr $2000
        .asc ""
        .byt $64,$8b
l818a   jsr $164f
l818d   sec
l818e   rts

l818f   lda $5c
        bne l8196
l8193   jsr $1646
l8196   lda #$97
        sta Cia2PortA
        lda #$18
        sta VicMemCtrlReg
        lda #$00
        sta $5c
        sta $5d
        rts
l81a7   l81ad = * + 6
        .byt $00,$28,$00,$18,$00,$00,$00,$2f,$55
l81b0   and ($2e),y
        bvc l8200
        l81c3 = * + 15
        .asc ""
        .byt $41,$59,$45,$52,$2f,$55,$31,$2e,$56,$41,$52,$53,$00,$00,$00,$00
l81c4   l81c5 = * + 1
        .byt $00,$05
l81c6   l81c7 = * + 1
; Instruction opcode accessed.
        bvc l81c8
l81c8   l81c9 = * + 1
        .byt $00,$40,$2f,$3b,$3a
l81cd   jsr $4241
        .asc ""
        .byt $43,$44,$45,$46,$47,$48,$49,$4b,$4e,$4f,$51,$52,$53,$54,$55,$56
        l81e7 = * + 7
        .asc ""
        .byt $58,$5a
        .asc "J"
        .byt $01,$00,$00,$ff,$ff
l81e8   l81ea = * + 2
        jsr $0020
        l81ee = * + 3
        l81ef = * + 4
        l81f0 = * + 5
        l81f1 = * + 6
        .byt $00,$00,$00,$00,$00,$00,$00
l81f2   ora ($01,x)
        ora ($01,x)
        ora ($01,x)
l81f8   ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
l8200   ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
l8208   ora ($03,x)
        l8213 = * + 9
        .byt $03,$03,$00,$03,$03,$03,$03,$03,$03,$01,$01,$01,$01,$01,$01,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$ff,$ff,$ff,$ff
        l822b = * + 1
        .byt $00,$00
l822c   l822d = * + 1
; Instruction opcode accessed.
        ora ($47,x)
        jmp ($6e69)
        l823b = * + 10
        l823c = * + 11
        .asc ""
        .byt $64,$61,$00,$00,$00,$00,$00,$00,$00,$00,$84,$03,$5a,$00,$5a,$00
        l8249 = * + 8
        l824a = * + 9
        l824b = * + 10
        l824d = * + 12
        l824f = * + 14
        l8250 = * + 15
        .byt $0f,$00,$0f,$00,$32,$00,$0f,$00,$38,$08,$02,$00,$02,$00,$00,$00
        l8259 = * + 8
        l825a = * + 9
        l825b = * + 10
        l825c = * + 11
        l825d = * + 12
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$95,$59,$00,$37,$02
        .asc "h"
        .byt $03
        .asc "h"
        .byt $03,$00,$ff
        .asc "o>"
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
l83ac   inc l83b5
        bne l83b4
l83b1   inc l83b6
l83b4   l83b5 = * + 1
        l83b6 = * + 2
        lda $0200
        rts

l83b8   l83b9 = * + 1
; Instruction parameter accessed.
        l83ba = * + 2
; Instruction parameter accessed.
        lda $0200
        inc l83b9
        bne l83c3
l83c0   inc l83ba
l83c3   rts
l83c4   pha
        lsr
        lsr
        lsr
        lsr
        jsr l83cd
l83cc   pla
l83cd   and #$0f
        ora #$30
        cmp #$3a
        bcc l83d7
l83d5   adc #$06
l83d7   jsr $1667
l83da   inc zpCursorCol
l83dc   rts
l83dd   and #$7f
        cmp #$7c
        bcc l83d7
l83e3   beq l83fe
l83e5   cmp #$7e
        beq l83f3
l83e9   cmp #$7d
        bne l83dc
l83ed   lda zpCursorCol
        cmp #$02
        bcc l83f6
l83f3   jsr l83fe
l83f6   lda #$01
        sta zpCursorCol
        rts

l83fb   jsr $164f
l83fe   inc zpCursorRow
        lda zpCursorRow
        cmp $31
        bcc l8411
l8406   tya
        pha
        txa
        pha
        jsr $1649
l840d   pla
        tax
        pla
        tay
l8411   lda #$00
        sta zpCursorCol
        rts

l8416   inc $30
        dec $31
        inc $2e
        dec $2f
        dec $2f
        lda $30
        sta zpCursorRow
        bne l8411

l8426   sec
        ror l81ad
        bit !$00a2


_printTableString
l842d   pla
        sta l83b5               ; set data pointer to data after RTS call
        pla
        sta l83b6
        jsr l83ac               ; read data byte
l8438   sta l83b9
        jsr l83ac               ; read data byte
l843e   sta l83ba
        lda l83b6               ; update return address
        pha
        lda l83b5
        pha

        txa
        beq l8455
l844c   jsr l83b8
l844f   asl
        bcc l844c
l8452   dex
        bne l844c

l8455   jsr l83b8               ; read character from object table
l8458   cmp #$7f                ; newline?
        beq l847f
l845c   pha
        bit l81ad
        bpl l8475
l8462   and #$7f
        cmp #$7c
        bcs l8475
l8468   cmp #$61
        bcc l8472
l846c   cmp #$7b
        bcs l8472
l8470   eor #$20
l8472   sta l81ad
l8475   jsr l83dd               ; print character
l8478   pla
        bpl l8455               ; more characters in string?
l847b   lsr l81ad
        rts

l847f   jsr l83b8
l8482   clc
        adc zpCursorCol
        sta zpCursorCol
        jmp l8455

_printAtPos
l848a   stx zpCursorCol
        sty zpCursorRow

_print
l848e   pla
        sta l83b5
        pla
        sta l83b6
l8496   jsr l83ac
l8499   beq l84b0
l849b   cmp #$7f
        beq l84a5
l849f   jsr l83dd
l84a2   jmp l8496
l84a5   jsr l83ac
l84a8   clc
        adc zpCursorCol
        sta zpCursorCol
        jmp l8496
l84b0   lda l83b6
        pha
        lda l83b5
        pha
        rts

l84b9   jsr l83d7
l84bc   dex
        bne l84b9
l84bf   rts
l84c0   jsr $1655
l84c3   jsr $1652
l84c6   jsr $1655
l84c9   lda #$10
        jsr l83d7
l84ce   ldx #$26
        lda #$04
        jsr l84b9
l84d5   lda #$12
        jsr $1667
l84da   inc zpCursorRow
        jsr l8411
l84df   lda #$0a
        jsr $1667
l84e4   lda #$27
        sta zpCursorCol
        lda #$08
        jsr $1667
l84ed   jsr $1673
l84f0   lda zpCursorRow
        eor #$12
        bne l84da
l84f6   sta zpCursorCol
        inc zpCursorRow
        lda #$04
        jsr l83d7
l84ff   ldx #$26
        lda #$06
        jsr l84b9
l8506   lda #$04
        jsr $1667
l850b   lda #$1e
        sta zpCursorCol
        lda #$02
        jsr $1667
l8514   lda #$0c
l8516   inc zpCursorRow
        jsr $1667
l851b   ldx zpCursorRow
        cpx #$17
        bcc l8516
l8521   rts
l8522   stx $3f
        sta $40
        ldx #$00
        stx $3c
        stx $3d
        stx $3e
        stx l857b
        stx l857a
        inx
        stx l8579
        sed
l8539   lsr $40
        ror $3f
        bcc l8555
l853f   clc
        lda $3c
        adc l8579
        sta $3c
        lda $3d
        adc l857a
        sta $3d
        lda $3e
        adc l857b
        sta $3e
l8555   clc
        lda l8579
        adc l8579
        sta l8579
        lda l857a
        adc l857a
        sta l857a
        lda l857b
        adc l857b
        sta l857b
        lda $3f
        ora $40
        bne l8539
l8577   cld
        rts
l8579   l857a = * + 1
        l857b = * + 2
        .byt $01,$00,$00
l857c   jsr l8522
l857f   inx
        bne l8588
l8582   tax
        lda #$00
        jsr l8522
l8588   sta l85bd
        jmp l8597
l858e   lda $3c,x
        lsr
        lsr
        lsr
        lsr
        jsr l85a6
l8597   txa
        bne l859d
l859a   inc l85bd
l859d   lda $3c,x
        jsr l85a6
l85a2   dex
        bpl l858e
l85a5   rts
l85a6   and #$0f
        bne l85b7
l85aa   cmp l85bd
        bne l85ba
l85af   lda l85be
        beq l85a5
l85b4   jmp l83d7
l85b7   sta l85bd
l85ba   jmp l83cd
l85bd   l85be = * + 1
        .byt $00,$00
l85bf   ldy #$ff
        sec
l85c2   iny
        sbc #$0a
        bcs l85c2
l85c7   tya
        rts
l85c9   sta $43
        jsr $1670
l85ce   cmp $43
        bcc l85d6
l85d2   sbc $43
        bcs l85ce
l85d6   cmp #$00
        sta $43
        rts
l85db   jsr $1673
l85de   lda $56
        rts
l85e1   jsr l8777
l85e4   ldy #$3d
        sty l85fc
l85e9   jsr $1ed5
l85ec   nop
        nop
        nop
        cmp #$00
        bne l85fb
l85f3   jsr $16a0
l85f6   dec l85fc
        bne l85e9
l85fb   rts
l85fc   .asc ""
        .byt $40
l85fd   ldx #$18
l85ff   cmp l81c9,x
        beq l8614
l8604   dex
        bpl l85ff

l8607   jsr _print
        .aasc "Huh?",$00
        jsr l8772
        sec
        rts

l8614   txa
        pha
        cmp #$04
        bcs l8630
l861a   lda l81c8
        beq l8630
l861f   sta l862c
        lda l81c7
        sta l862b
        jsr _printTableString
l862b   l862c = * + 1
        .byt $7f,$79
l862d   jmp l8635

l8630   jsr _printTableString
        .word _strTableDirection
        pla
        asl
        tax
        clc
        rts

l863a   clc
        bcs l8675
l863d   sty l81c5
        sta l81c6
        bcc l864a
l8645   lda #$00
        jsr $1685
l864a   sed
        sec
        lda l8259
        sbc l81c5
        sta l8259
        bcs l866a
l8657   lda l825a
        ora l825b
        beq l866a
l865f   lda l825a
        bne l8667
l8664   dec l825b
l8667   dec l825a
l866a   clc
        lda l824f
        adc l81c6
        sta l824f
        l8675 = * + 1
        bcs l8678
l8676   cld
        rts
l8678   sed
        sec
        ldx #$00
l867c   lda l8250,x
        adc #$00
        sta l8250,x
        inx
        bcs l867c
l8687   cld
        rts

l8689   jsr l870c
l868c   jsr $1658
l868f   jsr _print
        .aasc "Hits ",$7c
        .aasc "Food ",$7c
        .aasc "Exp. ",$7c
        .aasc "Coin ",$00
        jmp l68c9

l86ad   cmp #$01
        bcs l86bb
l86b1   cpx #$64
        bcs l86bb
l86b5   pha
        lda #$ff
        sta $1f
        pla
l86bb   jsr l857c
l86be   jsr l83fb
l86c1   lda #$00
        sta $1f
        rts
l86c6   jsr l870c
l86c9   jsr $1658
l86cc   sta l85be
        l86d0 = * + 1
; Instruction parameter jumped to.
        lda #$24
l86d1   l86d2 = * + 1
; Instruction parameter jumped to.
        sta $2e
l86d3   lda #$04
        sta $2f
        lda l823c
        ldx l823b
        jsr l86ad
l86e0   lda l825b
        ldx l825a
        jsr l86ad
l86e9   lda l825d
        ldx l825c
        jsr l857c
l86f2   jsr l83fb
l86f5   lda l824a
        ldx l8249
        jsr l857c
l86fe   jsr $164f
l8701   ldx #$05
l8703   lda l81a7,x
        sta $2e,x
        dex
        bpl l8703
l870b   rts

l870c   ldx #$05
l870e   lda $2e,x
        sta l81a7,x
        dex
        bpl l870e
l8716   rts

l8717   ldx l81ee
        jsr _printTableString
        .word _strTableSpell
        rts

l8720   lda zpCursorRow
        asl
        asl
        asl
        tax
l8726   ldy zpCursorCol
        beq l874d
l872a   dey
        lda bmpLinePtrLb,x
        clc
        adc bmpColOffLb,y
        sta $36
        lda bmpLinePtrHb,x
        eor $5c
        adc bmpColOffHb,y
        sta $37
        ldy #$07
        lda #$00
l8742   ora ($36),y
        bne l874d
l8746   dey
        bpl l8742
l8749   dec zpCursorCol
        bne l8726
l874d   rts

l874e   jsr _print
        .aasc $7d
        .aasc "Hmmmm... no effect?",$00

l8766   lda #$08
        bne l8774

l876a   jsr l8720
l876d   lda #$3f
        jsr $1667
l8772   lda #$10
l8774   jsr $1682
l8777   nop
        nop
        nop
        jsr GETIN
l877d   cmp #$00
        bne l8777
l8781   lda #$00
        sta $5b
        sta $56
        rts
l8788   jsr l870c
l878b   lda #$04
        sta $30
        sta $2e
        lda #$10
        sta $31
        lda #$20
        sta $2f
        jsr $1652
l879c   jsr l83f3
l879f   lda #$60
        jsr $168b
l87a4   jsr l87c9
l87a7   ldx #$04
        ldy #$12
        stx $26
        sty $27
        ldx #$fa
        jsr $1691
l87b4   ldx $26
        ldy #$6d
        jsr $1691
l87bb   ldx #$04
        ldy $27
        jsr $1691
l87c2   ldx $26
        ldy #$12
        jsr $1691
l87c9   lda $5c
        eor $5d
        sta $5c
        rts
l87d0   pha
        lda #$07
        sta zpCursorCol
        pla
        ldx #$03
l87d8   cmp l87f5,x
        beq l87e0
l87dd   dex
        bne l87d8
l87e0   txa
        asl
        tay
        lda l87fa,y
        pha
        lda l87f9,y
        pha
        jsr _printTableString
        .asc ""
        .byt $2e
l87ef   dey
        jsr $164f
l87f3   inc zpCursorCol
l87f5   rts
        l87f9 = * + 3
        l87fa = * + 4
        .asc ""
        .byt $53,$57,$41
        .asc "t"
        .byt $87,$00,$88,$0f,$88,$1e
l8800   dey
        lda l81ee
        jsr l8849
        .byt $0a,$08,$82
l880a   dey
        sei
        sta l81ee
        rts
l8810   lda l81ef
        jsr l8849
        .byt $0f
        .asc "x"
        .byt $81,$7c,$77
l881b   sta l81ef
        rts
l881f   lda l81f0
        jsr l8849
l8825   ora $f2
        sta ($d4,x)
        sei
        sta l81f0
        rts
        .asc ""
        .byt $6e,$6f,$74,$68,$69
l8833   ror $73e7
        bvs l889d
l8838   jmp ($ba6c)
        .asc ""
        .byt $77
l883c   adc $61
        bvs l88af
        .asc ""
        .byt $6e
        .asc ":"
        .byt $61,$72,$6d,$6f
l8846   adc $72,x
        tsx

l8849   sta $46
        pla
        sta l83b5
        pla
        sta l83b6
        jsr l83ac
l8856   sta l890b
        jsr l83ac
l885c   sta $41
        jsr l83ac
l8861   sta $42
        jsr l83ac
l8866   sta l8907
        jsr l83ac
l886c   sta l8908
        lda l83b6
        pha
        lda l83b5
        pha
        jsr l870c
l887a   jsr $165e
l887d   ldx #$0e
        ldy #$00
        lda $5d
        sta l81c3
        sty $5d
        jsr l848a
        .byt $0e
l888c   jsr $6552
        .asc ""
        .byt $61,$64,$79
l8892   jsr $0018
l8895   jsr $1652
l8898   ldy l890b
        ldx #$01
l889d   lda ($41),y
        beq l88a2
l88a1   inx
l88a2   dey
        bne l889d
l88a5   stx $43
        sec
        lda #$14
        sbc $43
        lsr
        sta zpCursorRow
l88af   lda #$61
        sta l88bf
        ldy #$00
l88b6   tya
        pha
        lda #$0d
        sta zpCursorCol
        jsr _print
l88bf; Instruction opcode accessed.
        adc ($29,x)
        jsr $6800
l88c4   jsr l8902
l88c7   tay
        inc zpCursorRow
l88ca   cpy l890b
        bcs l88d9
l88cf   inc l88bf
        iny
        lda ($41),y
        bne l88b6
l88d7   beq l88ca
l88d9   jsr l8701
l88dc   lda l81c3
        sta $5d
        jsr $1664
l88e4   jsr $1676
l88e7   pha
        jsr l8ad6
l88eb   sec
        pla
        sbc #$41
        beq l8902
l88f1   bmi l88ff
l88f3   cmp l890b
        bcc l88fa
l88f8   bne l88ff
l88fa   tay
        lda ($41),y
        bne l8901
l88ff   ldy $46
l8901   tya
l8902   tax
        pha
        jsr l8426
l8907   l8908 = * + 1
        .byt $00,$00
l8909   pla
        rts
l890b   .byt $0a
l890c   jsr $1661
l890f   jsr l870c
l8912   jsr $165e
l8915   jsr l8416
l8918   ldx #$0c
        ldy #$00
        sty l85be
        lda $5d
        sta l81c3
        sty $5d
        jsr l848a
        .byt $0e
l892a   jsr $6e49
        .asc ""
        .byt $76,$65,$6e,$74,$6f,$72,$79,$20,$18,$7c,$7c
l8938   bvc l89a6
l893a   adc ($79,x)
        adc $72
        .asc ""
        .byt $3a
l893f   jsr $2000
l8942   lda ($8b,x)
        jsr _print
        .asc ""
        .byt $7c
l8948   eor ($20,x)
        jmp (l7665)
l894d   adc $6c
        jsr $ae00
        .asc ""
        .byt $5c,$82
l8954   lda l825d
        jsr l8522
l895a   lda $3d
        lsr
        lsr
        lsr
        lsr
        clc
        adc #$01
        jsr l8582
l8966   inc zpCursorCol
        lda l822c               ; gender
        beq l8973
        jsr _print
        .aasc "fe",$00
l8973   jsr _print
        .aasc "male ",$00
l897c   ldx l824b               ; race
        jsr _printTableString
        .word _strTableRace
l8984   inc zpCursorCol

        ldx l824d               ; class
        jsr _printTableString
        .word _strTableClass

        jsr l8b10
l8991   dec zpCursorRow
        ldx #$00
        stx l81c4
l8998   stx $46
        txa
        asl
        tay
        ldx l823b,y
        lda l823c,y
        bne l89a9
l89a5   l89a6 = * + 1
        cpx #$00
        beq l89ae
l89a9   jsr l8b25
        .asc ""
        .byt $42
l89ad   sei
l89ae   ldx $46
        inx
        cpx #$07
        bcc l8998
l89b5   ldx l8249
        lda l824a
        jsr l8522
l89be   lda $3c
        and #$0f
        beq l89e0
l89c4   jsr l8adc
l89c7   jsr _print
        .aasc "Copper pence....",$00

        lda $3c
        jsr l83cd
l89e0   lda $3c
        lsr
        lsr
        lsr
        lsr
        beq l8a04
l89e8   pha
        jsr l8adc
l89ec   jsr _print
        .aasc "Silver pieces...",$00

        pla
        jsr l83cd
l8a04   lda $3d
        beq l8a41
l8a08   jsr l8adc
l8a0b   jsr _print
        .asc ""
        .byt $47,$6f
l8a10   jmp ($2064)
        .asc ""
        .byt $43,$72,$6f,$77,$6e,$73
l8a19   rol $2e2e
        rol $a500
        and $10c9,x
        bcs l8a3e
l8a24   lda #$2e
        jsr l83d7
l8a29   lda $3d
        jsr l83cd
l8a2e   jmp l8a41
        .asc ""
        .byt $45,$6e,$65,$6d,$79
l8a36   jsr $6576
        .asc ""
        .byt $73,$73,$65
l8a3c   l8a3e = * + 2
; Instruction parameter jumped to.
        jmp ($20f3)
        .asc "D"
        .byt $83
l8a41   lda l822b
        beq l8a4f
l8a46   ldx #$00
        stx $46
        jsr l8b22
l8a4d   and ($8a),y
l8a4f   lda l81f0
        sta l81c4
        ldx #$01
l8a57   stx $46
        lda l81f2,x
        beq l8a63
l8a5e   jsr l8b22
        .asc "T"
l8a62   sei
l8a63   ldx $46
        inx
        cpx #$06
        bcc l8a57
l8a6a   lda l81f1
        sta l81c4
        ldx #$01
l8a72   stx $46
        lda l8213,x
        beq l8a7e
l8a79   jsr l8b22
l8a7c   bmi l8af7
l8a7e   ldx $46
        inx
        cpx #$0b
        bcc l8a72
l8a85   ldx #$00
        stx l81c4
l8a8a   stx $46
        lda l81ea,x
        beq l8a96
l8a91   jsr l8b22
l8a94   bmi l8b10
l8a96   ldx $46
        inx
        cpx #$04
        bcc l8a8a
l8a9d   lda l81ef
        sta l81c4
        ldx #$01
l8aa5   stx $46
        lda l81f8,x
        beq l8ab1
l8aac   jsr l8b22
        .asc ""
        .byt $7c,$77
l8ab1   ldx $46
        inx
        cpx #$10
        bcc l8aa5
l8ab8   lda l81ee
        sta l81c4
        ldx #$01
l8ac0   stx $46
        lda l8208,x
        beq l8acc
l8ac7   jsr l8b22
l8aca   dey
        sei
l8acc   ldx $46
        inx
        cpx #$0b
        bcc l8ac0
l8ad3   jsr l8b56
l8ad6   jsr l84c6
l8ad9   jmp l8701
l8adc   ldx #$00
        stx zpCursorCol
        ldy zpCursorRow
        iny
        cpy #$12
        bcc l8af5
l8ae7   ldy $30
        lda #$12
        sta $2f
        adc $2e
        cmp #$26
        bcs l8af8
l8af3   sta $2e
l8af5   sty zpCursorRow
l8af7   rts
l8af8   ldx #$0d
        ldy #$12
        jsr l848a
l8aff   adc $726f
        adc $00
        jsr l8b56
l8b07   lda #$00
        sta $5d
        inc zpCursorCol
        jsr l870c
l8b10   lda #$05
        sta $30
        lsr
        sta $2e
        lda #$24
        sta $2f
        lda #$13
        sta $31
        jmp $1652
l8b22   tax
        lda #$00
l8b25   pha
        txa
        pha
        jsr l8adc
l8b2b   lda #$03
        sta zpCursorCol
        ldx #$09
        lda #$2e
        sta l85be
        jsr l84b9
l8b39   pla
        tax
        pla
        jsr l857c
l8b3f   jsr l8411
l8b42   ldx $46
        lda l81c4
        beq l8b53
l8b49   cpx l81c4
        bne l8b53
l8b4e   lda #$1b
        jsr l83d7
l8b53   jmp l8426
l8b56   lda l81c3
        sta $5d
        jsr $1664
l8b5e   jsr $1646
l8b61   jsr l8701
l8b64   jsr _print
        .asc ""
        .byt $7d
l8b68   bvc l8bdc
        .asc ""
        .byt $65,$73,$73
l8b6d   jsr $7053
        .asc ""
        .byt $61,$63,$65
l8b73   jsr $6f74
l8b76   jsr $6f63
        .asc ""
        .byt $6e,$74,$69,$6e,$75
l8b7e   adc $3a
        jsr $2000
        .asc ""
        .byt $77,$87
l8b85   jsr $1676
l8b88   cmp #$0d
        beq l8b94
l8b8c   cmp #$1b
        beq l8b94
l8b90   cmp #$20
        bne l8b85
l8b94   jsr $164c
l8b97   inc zpCursorCol
l8b99; Instruction opcode accessed.
        dec zpCursorRow
        jsr l8777
l8b9e   jmp l870c
l8ba1   ldx #$00
l8ba3   lda l822d,x
        beq l8bae
l8ba8   jsr l83d7
l8bab   inx
        bne l8ba3
l8bae   rts
        .asc ""
        .byt $60
l8bb0   jsr _print
        .aasc " off",$00
        rts
l8bb9   lda $1638
        eor #$ff
        sta $1638
        sta l81e7
        beq l8bb0
l8bc6   jsr _print
        .aasc " on",$00
        rts

l8bce   jsr l83ed
l8bd1   jsr l8ba1
l8bd4   jsr _print
        .asc ""
        .byt $2c
l8bd8   jsr $6874
        .asc ""
        .byt $6f
l8bdc   adc $20,x
        adc ($72,x)
        .asc ""
        .byt $74
l8be1   jsr $6564
l8be4   adc ($64,x)
        rol $2000
        lsr $16
        lda #$00
        sta l8249
        sta l824a
        sta l825a
        sta l825b
        sta l823b
        sta l823c
        ldy $5d
        sty l81c3
        sta $5d
        jsr l86c6
l8c09   jsr $1661
l8c0c   lda #$03
        sta $60
        lda #$74
        sta $61
        lda #$80
        sta $62
        lda #$25
        eor $5c
        sta $63
        ldx #$0c
l8c20   ldy #$47
l8c22   lda ($60),y
        sta ($62),y
        dey
        bpl l8c22
l8c29   lda $60
        clc
        adc #$48
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
        bne l8c20
l8c46   lda #$02
        jsr $1685
l8c4b   lda #$02
        jsr $1685
l8c50   lda l81c3
        sta $5d
        jsr $1664
l8c58   jmp l8777
l8c5b   jsr l8bce

l8c5e   lda #$01

l8c60   ldx #$ff
        txs                     ; reset stack
        cmp #$07
        bcs l8c6a               ; first time: load and start Character Generator
l8c67   tax
        bne l8c74
l8c6a   ldx #$04
        jsr loadFile            ; load "GE",$8c9e
        bcs l8c6a
        jmp l8c9e               ; jump into "GE"

l8c74   clc                     ; second time: start game
        adc #$04                ; 1+4 = 5
        sta l8c97
l8c7a   jsr l8777
l8c7d   ldx l8c97
        jsr loadFile            ; copy $e000 to $8c9e (file OU)
l8c83   jsr l8175
l8c86   bcs l8c7a
l8c88   jsr l818f
l8c8b   jsr l8689
l8c8e   jsr l84c6
l8c91   jsr l8701
l8c94   jmp l8c9e

l8c97   .byt $04
l8c98   jsr $163d
        .byt $4c,$9b,$8c

l8c9e   sei
        ldx #$ff                ; reset stack
        txs
        ldx #$0b
        jsr loadFile            ; load "ST",$0c00
        ldx #$0f
        jsr loadFile            ; load "PR",$12c0
        jsr $1655
        jsr $163a
l8cb2   lda #$60
        sta $5c
        sta $5d
        jsr $1664
l8cbb   jsr l818f
l8cbe   lda #$96
        sta Cia2PortA
        lda #$80
        sta VicMemCtrlReg
        lda #$00
        jmp l8c60
        .asc "H"
