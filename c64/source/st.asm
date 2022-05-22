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
	.word $0c00
	* = $0c00

; tileset

0c00:
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

l1200
	.byt $00,$01,$02,$03,$04,$05
l1206	asl $07
	rti
	l1210 = * + 7
	.asc ""
	.byt $41,$42,$43,$44,$45,$46,$47,$80,$81,$82,$83,$84,$85,$86,$87
	.asc "@"
	.asc "ABCDEFG"
	.byt $00,$01,$02,$03,$04,$05
l1226	asl $07
	rti
	.asc ""
	.byt $41,$42,$43,$44,$45,$46,$47,$80,$81,$82,$83,$84,$85,$86,$87
	.asc "@"
	.asc "ABCDEFG"
	.byt $00,$01,$02,$03,$04,$05
l1246	asl $07
	rti
	.asc ""
	.byt $41,$42,$43,$44,$45,$46,$47,$80,$81,$82,$83,$84,$85,$86,$87
	.asc "@"
	.asc "ABCDEFG"
	.byt $00,$01,$02,$03,$04,$05
l1266	asl $07
	rti
	.asc ""
	.byt $41,$42,$43,$44,$45,$46,$47,$80,$81,$82,$83,$84,$85,$86,$87
	.asc "@"
	.asc "ABCDEFG"
	.byt $00,$01,$02,$03,$04,$05
l1286	asl $07
	rti
	.asc ""
	.byt $41,$42,$43,$44,$45,$46,$47,$80,$81,$82,$83,$84,$85,$86,$87
	.asc "@"
	.asc "ABCDEFG"
	.byt $00,$01,$02,$03,$04,$05
l12a6	asl $07
	rti
	.asc ""
	.byt $41,$42,$43,$44,$45,$46,$47,$80,$81,$82,$83,$84,$85,$86,$87
	.asc "@"
	.asc "ABC"
l12bc	cpy $c5
	dec $c7
l12c0	jsr $2020
l12c3	jsr $2020
l12c6	jsr $2120
	l12d0 = * + 7
	.asc ""
	.byt $21,$21,$21,$21,$21,$21,$21,$22,$22,$22,$22,$22,$22,$22,$22,$23
	.asc ""
	.byt $23,$23,$23,$23,$23,$23,$23,$25,$25,$25,$25,$25,$25,$25,$25,$26
	.asc ""
	.byt $26,$26,$26,$26,$26,$26,$26,$27,$27,$27,$27,$27,$27,$27,$27,$28
	.asc ""
	.byt $28,$28,$28,$28,$28,$28,$28,$2a,$2a,$2a,$2a,$2a,$2a,$2a,$2a,$2b
	.asc ""
	.byt $2b,$2b,$2b,$2b,$2b,$2b,$2b,$2c,$2c,$2c,$2c,$2c,$2c,$2c,$2c,$2d
	.asc ""
	.byt $2d,$2d,$2d,$2d,$2d,$2d,$2d,$2f,$2f,$2f,$2f,$2f,$2f,$2f,$2f
l1328	bmi l135a
l132a	bmi l135c
l132c	bmi l135e
l132e	bmi l1360
	.asc ""
	.byt $31,$31,$31,$31,$31,$31,$31,$31,$32,$32,$32,$32,$32,$32,$32,$32
	.asc ""
	.byt $34,$34,$34,$34,$34,$34,$34,$34,$35,$35,$35,$35,$35,$35,$35,$35
	l135a = * + 10
	l135c = * + 12
	l135e = * + 14
	.asc ""
	.byt $36,$36,$36,$36,$36,$36,$36,$36,$37,$37,$37,$37,$37,$37,$37,$37
l1360	and $3939,y
	and $3939,y
	and $3a39,y
	.asc ""
	.byt $3a,$3a,$3a,$3a,$3a,$3a,$3a,$3b,$3b,$3b,$3b,$3b,$3b,$3b,$3b,$3c
	.asc ""
	.byt $3c,$3c,$3c,$3c,$3c,$3c,$3c
l1380	cpy #$60
	bmi l139c
	.byt $0c
l1385	asl $03
	ora ($c0,x)
	rts
l138a	bmi l13a4
	.byt $0c
l138d	asl $03
	ora ($c0,x)
	rts
l1392	bmi l13ac
	.byt $0c
l1395	asl $03
	ora ($c0,x)
	rts
l139a	bmi l13b4
l139c 	.byt $0c
l139d	asl $03
	ora ($c0,x)
	rts
l13a2	bmi l13bc
l13a4 	.byt $0c
l13a5	asl $03
	ora ($c0,x)
	rts
l13aa	bmi l13c4
l13ac 	.byt $0c
l13ad	asl $03
	ora ($c0,x)
	rts
l13b2	bmi l13cc
l13b4 	.byt $0c
l13b5	asl $03
	ora ($c0,x)
	rts
l13ba	bmi l13d4
l13bc 	.byt $0c
l13bd	asl $03
	ora ($c0,x)
	rts
l13c2	bmi l13dc
l13c4 	.byt $0c
l13c5	asl $03
	ora ($c0,x)
	rts
l13ca	bmi l13e4
l13cc 	.byt $0c
l13cd	asl $03
	ora ($c0,x)
	rts
l13d2	bmi l13ec
l13d4 	.byt $0c
l13d5	asl $03
	ora ($c0,x)
	rts
l13da	bmi l13f4
l13dc 	.byt $0c
l13dd	asl $03
	ora ($c0,x)
	rts
l13e2	bmi l13fc
l13e4 	.byt $0c
l13e5	asl $03
	ora ($c0,x)
	rts
l13ea	bmi l1404
l13ec 	.byt $0c
l13ed	asl $03
	ora ($c0,x)
	rts
l13f2	bmi l140c
l13f4 	.byt $0c
l13f5	asl $03
	ora ($c0,x)
	rts
l13fa	bmi l1414
l13fc 	.byt $0c
l13fd	asl $03
	ora ($c0,x)
	rts
l1402	bmi l141c
l1404 	.byt $0c
l1405	asl $03
	ora ($c0,x)
	rts
l140a	bmi l1424
l140c 	.byt $0c
l140d	asl $03
	ora ($c0,x)
	rts
l1412	bmi l142c
l1414 	.byt $0c
l1415	asl $03
	ora ($c0,x)
	rts
l141a	bmi l1434
l141c 	.byt $0c
l141d	asl $03
	ora ($c0,x)
	rts
l1422	bmi l143c
l1424 	.byt $0c
l1425	asl $03
	ora ($c0,x)
	rts
l142a	bmi l1444
l142c 	.byt $0c
l142d	asl $03
	ora ($c0,x)
	rts
l1432	bmi l144c
l1434 	.byt $0c
l1435	asl $03
	ora ($c0,x)
	rts
l143a	bmi l1454
l143c 	.byt $0c
l143d	asl $03
	ora ($c0,x)
	rts
l1442	bmi l145c
l1444 	.byt $0c
l1445	asl $03
	ora ($c0,x)
	rts
l144a	bmi l1464
l144c 	.byt $0c
l144d	asl $03
	ora ($c0,x)
	rts
l1452	bmi l146c
l1454 	.byt $0c
l1455	asl $03
	ora ($c0,x)
	rts
l145a	bmi l1474
l145c 	.byt $0c
l145d	asl $03
	ora ($c0,x)
	rts
l1462	bmi l147c
l1464 	.byt $0c
l1465	asl $03
	ora ($c0,x)
	rts
l146a	bmi l1484
l146c 	.byt $0c
l146d	asl $03
	ora ($c0,x)
	rts
l1472	bmi l148c
l1474 	.byt $0c
l1475	asl $03
	ora ($c0,x)
	rts
l147a	bmi l1494
l147c 	.byt $0c
l147d	asl $03
	l1480 = * + 1
	ora ($00,x)
	jsr $6040
l1484 	.byt $80
l1485	ldy #$c0
	cpx #$00
	jsr $6040
l148c 	.byt $80
l148d	ldy #$c0
	cpx #$00
	jsr $6040
l1494 	.byt $80
l1495	ldy #$c0
	cpx #$00
	jsr $6040
	.byt $80
l149d	ldy #$c0
	cpx #$00
	jsr $6040
	.byt $80
l14a5	ldy #$c0
	cpx #$00
	jsr $6040
	.byt $80
l14ad	ldy #$c0
	cpx #$00
	jsr $6040
	.byt $80
l14b5	ldy #$c0
	cpx #$00
	jsr $6040
	.byt $80
	.asc " @`"
l14c0   .word lc0c,lc0c,lc0c,lc0c
	.byt $0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0e,$0e,$0e,$0e,$0e,$0e,$0e,$0e
	.byt $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
l14e0	bpl l14f2
l14e2	bpl l14f4
l14e4	bpl l14f6
l14e6	bpl l14f8
	l14f2 = * + 10
	l14f4 = * + 12
	l14f6 = * + 14
	.byt $11,$11,$11,$11,$11,$11,$11,$11,$12,$12,$12,$12,$12,$12,$12,$12
l14f8 	.byt $13,$13,$13,$13,$13,$13,$13,$13
l1500	rts
l1501	bvc l1553
l1503	beq l1515
l1505	bpl l1517
l1507	beq l1519
l1509	bpl l151b
l150b	bpl l151d
l150d	bpl l151f
l150f	bpl l1521
l1511	bpl l1563
l1513	bvc l1525
l1515	bpl l1527
l1517	bpl l1529
l1519	bpl l152b
l151b	bpl l156d
l151d	bvc l152f
l151f	bpl l1571
l1521	bvc l1533
l1523	bpl l1535
l1525	bpl l1537
l1527	bpl l1539
l1529	bpl l153b
l152b	bpl l153d
l152d	bpl l155f
l152f	l1530 = * + 1
	ldy #$60
	rts
	.asc ""
	.byt $60
l1533	rts
	.asc ""
	.byt $60
l1535	rts
	.asc ""
	.byt $60
l1537	rts
	.asc ""
	.byt $60
l1539	rts
	.asc ""
	.byt $60
l153b	rts
	.asc ""
	.byt $60
l153d	rts
	.asc ""
	.byt $60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60
l154a	bpl l155c
l154c	bpl l155e
l154e	bpl l1500
l1550	bpl l1562
l1552	l1553 = * + 1
; Instruction parameter jumped to.
	bpl l1564
l1554	l1555 = * + 1
; Instruction parameter jumped to.
	bpl l1566
l1556	l1557 = * + 1
; Instruction parameter jumped to.
	bpl l1568
l1558	l1559 = * + 1
; Instruction parameter jumped to.
	bpl l156a
l155a	l155b = * + 1
; Instruction parameter jumped to.
	bpl l156c
l155c	l155d = * + 1
; Instruction parameter jumped to.
	bpl l156e
l155e	l155f = * + 1
; Instruction parameter jumped to.
	bpl l1570
l1560	l1561 = * + 1
; Instruction parameter jumped to.
	bpl l1572
l1562	l1563 = * + 1
; Instruction parameter jumped to.
	bpl l1574
l1564	l1565 = * + 1
; Instruction parameter jumped to.
	bpl l1576
l1566	l1567 = * + 1
; Instruction parameter jumped to.
	bpl l1578
l1568	l1569 = * + 1
; Instruction parameter jumped to.
	bpl l157a
l156a	l156b = * + 1
; Instruction parameter jumped to.
	bpl l157c
l156c	l156d = * + 1
; Instruction parameter jumped to.
	bpl l157e
l156e	l156f = * + 1
; Instruction parameter jumped to.
	bpl l1580
l1570	l1571 = * + 1
; Instruction parameter jumped to.
	bpl l1582
l1572	l1573 = * + 1
; Instruction parameter jumped to.
	bpl l1584
l1574	l1575 = * + 1
; Instruction parameter jumped to.
	bpl l1586
l1576	l1577 = * + 1
; Instruction parameter jumped to.
	bpl l1588
l1578	l1579 = * + 1
; Instruction parameter jumped to.
	bpl l158a
l157a	l157b = * + 1
; Instruction parameter jumped to.
	bpl l158c
l157c	l157d = * + 1
; Instruction parameter jumped to.
	bpl l158e
l157e	l157f = * + 1
; Instruction parameter jumped to.
	bpl l1590
l1580	l1581 = * + 1
; Instruction parameter jumped to.
	bpl l1592
l1582	l1583 = * + 1
; Instruction parameter jumped to.
	bpl l1594
l1584	l1585 = * + 1
; Instruction parameter jumped to.
	bpl l1596
l1586	l1587 = * + 1
; Instruction parameter jumped to.
	bpl l1598
l1588	l1589 = * + 1
; Instruction parameter jumped to.
	bpl l159a
l158a	l158b = * + 1
; Instruction parameter jumped to.
	bpl l159c
l158c	l158d = * + 1
; Instruction parameter jumped to.
	bpl l159e
l158e	l158f = * + 1
; Instruction parameter jumped to.
	bpl l15a0
l1590	l1591 = * + 1
; Instruction parameter jumped to.
	bpl l15a2
l1592	l1593 = * + 1
; Instruction parameter jumped to.
	bpl l15a4
l1594	l1595 = * + 1
; Instruction parameter jumped to.
	bpl l15a6
l1596	l1597 = * + 1
; Instruction parameter jumped to.
	bpl l15a8
l1598	l1599 = * + 1
; Instruction parameter jumped to.
	bpl l15aa
l159a	l159b = * + 1
; Instruction parameter jumped to.
	bpl l15ac
l159c 	.byt $10
l159d	l159e = * + 1
; Instruction parameter jumped to.
	bpl l15af
l159f	l15a0 = * + 1
; Instruction parameter jumped to.
	bpl l15b1
l15a1	l15a2 = * + 1
; Instruction parameter jumped to.
	bpl l15b3
l15a3	l15a4 = * + 1
; Instruction parameter jumped to.
	bpl l15b5
l15a5	l15a6 = * + 1
; Instruction parameter jumped to.
	bpl l15b7
l15a7	l15a8 = * + 1
; Instruction parameter jumped to.
	bpl l15b9
l15a9	l15aa = * + 1
; Instruction parameter jumped to.
	bpl l15bb
l15ab	l15ac = * + 1
; Instruction parameter jumped to.
	bpl l15bd
l15ad	bpl l15bf
l15af	l15b0 = * + 1
	bpl l15b1
l15b1	php
l15b2	l15b3 = * + 1
; Instruction parameter jumped to.
	bpl l15cc
l15b4	l15b5 = * + 1
; Instruction parameter jumped to.
	l15b6 = * + 2
; Instruction parameter jumped to.
	jsr $3028
l15b7	sec
l15b8	rti
l15b9	pha
l15ba	l15bb = * + 1
; Instruction parameter jumped to.
	bvc l1614
l15bc	rts
l15bd	pla
l15be	l15bf = * + 1
; Instruction parameter jumped to.
	bvs l1638
	.byt $80
l15c1	dey
	bcc l155c
l15c4	ldy #$a8
	bcs l1580
l15c8	cpy #$c8
	bne l15a4
l15cc	cpx #$e8
	beq l15c8
	.byt $00
l15d1	php
	bpl l15ec
l15d4	jsr $3028
	l15d8 = * + 1
	.asc ""
	.byt $38,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	l15ec = * + 5
	l15f0 = * + 9
	.byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byt $00,$01
l15f9	ora ($01,x)
	ora ($01,x)
	ora ($01,x)
	l1600 = * + 1
	ora ($00,x)
	plp
l1602	bvc l167c
l1604	ldy #$c8
	beq l1620
l1608	rti
l1609	pla
	bcc l15c4
l160c	cpx #$08
	bmi l1668
	.byt $80
l1611	tay
	bne l160c
l1614	jsr $7048
	l1619 = * + 2
	l161b = * + 4
	.byt $98
	.asc "@"
	.byt $04,$04,$04,$04,$04,$04,$04
l1620	ora $05
	ora $05
	ora $05
	asl $06
	asl $06
	asl $06
	asl $07
	l1632 = * + 4
	l1637 = * + 9
	l1638 = * + 10
	l1639 = * + 11
	.byt $07,$07,$07,$07
	.asc " ;:/@"
	.byt $02,$ff,$10
l163a	jmp l178f
l163d	jmp l17ec
l1640	jmp l171f
l1643	jmp l1722
l1646	jmp l1723
l1649	jmp l1910
l164c	jmp l199e
l164f	jmp l19a6
l1652	jmp l1a48
l1655	jmp l1a2c
l1658	jmp l1a15
l165b	jmp l1a0d
l165e	jmp l1a3a
l1661	jmp l16ad
l1664	jmp l1700
l1667	l1668 = * + 1
; Instruction parameter jumped to.
	jmp l1a78
l166a	jmp l1c8a
l166d	jmp l1e2c
l1670	jmp l1e9e
l1673	jmp l1e08
l1676	jmp l1e3e
l1679	jmp l1e44
l167c	jmp l1e50
l167f	jmp l1e8c
l1682	jmp l1b51
l1685	jmp l1b89
l1688	jmp l1b72
l168b	jmp l1773
l168e	jmp l17ed
l1691	jmp l1866
l1694	jmp l186a
l1697	jmp l16ac
l169a	jmp l16ac
l169d	jmp l1c81
l16a0	sec
l16a1	pha
l16a2	sbc #$01
	bne l16a2
l16a6	pla
	sbc #$01
	bne l16a1
l16ab	rts
l16ac	rts
l16ad	lda #$21
	eor $5c
	sta $61
	lda #$48
	sta $60
	ldx #$11
l16b9	ldy #$00
	tya
l16bc	sta ($60),y
	iny
	bne l16bc
l16c1	inc $61
	ldy #$2f
l16c5	sta ($60),y
	dey
	bpl l16c5
l16ca	lda $60
	clc
	adc #$40
	sta $60
	bcc l16d5
l16d3	inc $61
l16d5	dex
	bpl l16b9
l16d8	lda #$29
	sta $60
	lda #$04
	ldx $5c
	beq l16e4
l16e2	lda #$60
l16e4	ldx #$11
	sta $61
l16e8	ldy #$25
	lda #$10
l16ec	sta ($60),y
	dey
	bpl l16ec
l16f1	lda $60
	clc
	adc #$28
	sta $60
	bcc l16fc
l16fa	inc $61
l16fc	dex
	bpl l16e8
l16ff	rts
l1700	jsr l1c81
l1703	lda $5c
	tax
	beq l170a
l1708	ldx #$01
l170a	eor $5d
	sta $5c
	lda l1e28,x
	sta Cia2PortA
	lda l1e2a,x
	sta VicMemCtrlReg
l171a	jsr l1b72
l171d	bne l171a

l171f	rts

	.asc ""
	.byt $60,$60
l1722	rts

l1723	lda #$20
	tax
	eor $5c
	sta l1737
	eor $5d
	sta l1734
	ldy #$00
l1732	l1734 = * + 2
	lda $4000,y
	l1737 = * + 2
	sta $2000,y
	iny
	bne l1732
l173b	inc l1734
	inc l1737
	dex
	bne l1732
l1744	lda #$00
	sta $60
	sta $62
	lda l1734
	cmp #$60
	beq l1753
l1751	lda #$04
l1753	sta $61
	lda l1737
	cmp #$60
	beq l175e
l175c	lda #$04
l175e	sta $63
	ldx #$04
	ldy #$00
l1764	lda ($60),y
	sta ($62),y
	iny
	bne l1764
l176b	inc $61
	inc $63
	dex
	bne l1764
l1772	rts
l1773	sta l1788
	ldx #$ff
	cmp #$00
	bne l1782
l177c	tax
	lda #$10
	sta l1788
l1782	stx l1786
	rts
l1786 	l1788 = * + 2
	l1789 = * + 3
	l178a = * + 4
	l178b = * + 5
	l178c = * + 6
	l178d = * + 7
	l178e = * + 8
	.byt $ff,$60,$06,$00,$00,$01,$03,$02,$01

l178f	lda #$01
	sta SidVoice3FreqLb
	lda #$0f
	sta SidVoice3AttackDecay
	lda #$41
	sta SidVoice3CtrlReg
	lda #$8f
	sta l1c80
	sta l1c7e
	lda #$ff
	sta SidVoice3SustainRelease
	lda #$00
	sta $56
	sta $5b
	sta $1f
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
	lda #$10
l17cd	sta $0400,x
	sta $0500,x
	sta $0600,x
	sta $0700,x
	sta $6000,x
	sta $6100,x
	sta $6200,x
	sta $6300,x
	inx
	bne l17cd
l17e8	cli
	rts
l17ea	clc
	rts

l17ec	rts

l17ed	ldy $27
	bmi l1864
l17f1	ldx $26
	lda l12d0,y
	eor $5c
	sta $63
	lda l1210,y
	sta $62
l17ff	sty $5e
	tya
	lsr
	lsr
	lsr
	tay
	lda l1602,y
	sta $60
	lda l161b,y
	ldy $5c
	beq l1815
l1812	clc
	adc #$5c
l1815	sta $61
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
	adc l15b0,y
	sta $34
	lda $63
	adc l15d8,y
	sta $35
	ldy #$00
	lda l1786
	eor ($34),y
	and l1380,x
	eor ($34),y
	sta ($34),y
	inx
	beq l1862
l1847	txa
	and #$07
	bne l1862
l184c	ldy #$08
	lda l1786
	eor ($34),y
	and #$80
	eor ($34),y
	sta ($34),y
	ldy l1865
	iny
	lda l1788
	sta ($60),y
l1862	ldy $5e
l1864	rts
l1865 	.byt $00
l1866	stx $28
	sty $29
l186a	jsr l17ed
l186d	lda $28
	cmp $26
	bne l1879
l1873	lda $29
	cmp $27
	beq l1864
l1879	lda #$01
	sta $2a
	sta $2b
	ldx #$ff
	sec
	lda $28
	sbc $26
	bcs l188f
l1888	sec
	lda $26
	sbc $28
	stx $2a
l188f	sta $24
	sec
	lda $29
	sbc $27
	bcs l189f
l1898	sec
	lda $27
	sbc $29
	stx $2b
l189f	sta $25
	cmp $24
	bcc l18ce
l18a5	sta $3a
	lsr
	sta $3b
l18aa	clc
	lda $3b
	adc $24
	sta $3b
	sec
	sbc $25
	bcc l18bf
l18b6	sta $3b
	clc
	lda $26
	adc $2a
	sta $26
l18bf	clc
	lda $27
	adc $2b
	sta $27
l18c6; Instruction opcode accessed.
; Instruction opcode accessed.
	jsr l17ed
l18c9	dec $3a
	bne l18aa
l18cd	rts
l18ce	lda $24
	sta $3a
	lsr
	sta $3b
l18d5	clc
	lda $26
	adc $2a
	sta $26
	tax
	clc
	lda $3b
	adc $25
	sta $3b
	bcc l18eb
l18e6	sbc $24
	jmp l18f0
l18eb	sec
	sbc $24
	bcc l1908
l18f0	sta $3b
	clc
	lda $27
	adc $2b
	sta $27
	tay
	bmi l190b
l18fc	lda l1210,y
	sta $62
	lda l12d0,y
	eor $5c
	sta $63
l1908	jsr l17ff
l190b	dec $3a
	bne l18d5
l190f	rts

l1910	ldx $31
	dex
	txa
	sta $33
	sec
	sbc $30
l1919	sta $43
	lda $30
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
l1935	lda l1200,x
	ldy $2e
	clc
	adc l15b0,y
	sta l197f
	sta l1982
	lda l12c0,x
	adc l15d8,y
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
	lda $2f
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
l1979	ldy #$ff
l197b	l197c = * + 1
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
l1989	ldy $5e
	inc l1980
	inc l1983
	dec $5f
	bpl l197b
l1995	txa
	clc
	adc #$08
	tax
	dec $43
	bne l1935
l199e	lda $33
l19a0	ldx #$00
	stx $32
	beq l19ae
l19a6	ldx $32
	cpx $2f
	bcs l1a0a
l19ac	lda $33
l19ae	asl
	asl
	asl
	tax
	lda $2e
	clc
	adc $32
	tay
	lda l1200,x
	clc
	adc l15b0,y
	sta l19f4
	sta l19f7
	lda l12c0,x
	adc l15d8,y
	eor $5c
	sta l19f5
	eor $5d
	sta l19f8
	lda #$00
	sta $5f
	lda $2f
	sec
	sbc $32
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
l19ef	ldy #$ff
l19f1	lda $1f
l19f3	l19f4 = * + 1
	l19f5 = * + 2
	sta $2000,y
	l19f7 = * + 1
	l19f8 = * + 2
	sta $4000,y
	dey
	cpy #$ff
	bne l19f3
l19fe	ldy $5e
	inc l19f5
	inc l19f8
	dec $5f
	bpl l19f3
l1a0a	jmp l1e08
l1a0d	lda #$1e
	sta $2f
	lda #$00
	beq l1a1b
l1a15	lda #$0a
	sta $2f
	lda #$1f
l1a1b	sta $2e
	lda #$18
	sta $31
	lda #$14
l1a23	sta $30
	sta $33
	lda #$00
	sta $32
	rts
l1a2c	lda #$28
	sta $2f
	lda #$18
	sta $31
	lda #$00
	sta $2e
	beq l1a23
l1a3a	lda #$26
	sta $2f
	lda #$13
	sta $31
	lda #$01
	sta $2e
	bne l1a23
l1a48	ldy $30
	sty $33
l1a4c	tya
	pha
	lda l1600,y
	sta $60
	lda l1619,y
	ldx $5c
	beq l1a5d
l1a5a	clc
	adc #$5c
l1a5d	sta $61
	ldx $2f
	ldy $2e
	lda #$10
l1a65	sta ($60),y
	iny
	dex
	bne l1a65
l1a6b	pla
	pha
	jsr l19a0
l1a70	pla
	tay
	iny
	cpy $31
	bcc l1a4c
l1a77	rts
l1a78	pha
	stx l1b05
	ldx $32
	cpx $2f
	bcs l1b00
l1a82	and #$7f
	sta $5e
	lda $33
	asl
	asl
	asl
	tax
	lda $2e
	clc
	adc $32
	tay
	lda l1200,x
	clc
	adc l15b0,y
	sta l1acc
	sta l1acf
	lda l12c0,x
	adc l15d8,y
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
l1ac6	l1ac7 = * + 1
	l1ac8 = * + 2
	lda $0800,x
	eor $1f
	l1acc = * + 1
	l1acd = * + 2
	sta $2000,x
	l1acf = * + 1
	l1ad0 = * + 2
	sta $4000,x
	dex
	bpl l1ac6
l1ad4	ldx $33
	lda l1600,x
	sta $60
	sta $62
	lda l1619,x
	ldx $5c
	beq l1ae7
l1ae4	clc
	adc #$5c
l1ae7	sta $61
	ldx $5d
	beq l1aef
l1aed	eor #$64
l1aef	sta $63
	lda $32
	clc
	adc $2e
	tay
	ldx $5e
	lda l1530,x
	sta ($60),y
	sta ($62),y
l1b00	ldx l1b05
	pla
	rts
l1b05 	.byt $00
l1b06	jsr l1b13
l1b09	ldx #$0f
	jsr l1b26
l1b0e	ldx #$1f
	jsr l1b26
l1b13	ldx #$07
l1b15	lda lc08,x
	ldy lc10,x
	sta lc10,x
	tya
	sta lc08,x
	dex
	bpl l1b15
l1b25	rts
l1b26	lda lc00,x
	pha
l1b2a	dex
	lda lc00,x
	inx
	sta lc00,x
	dex
	bmi l1b39
l1b35	cpx #$0f
	bne l1b2a
l1b39	inx
	pla
	sta lc00,x
	rts
l1b3f 	l1b40 = * + 1
	.asc ""
	.byt $4e,$1c
  .word l1c48,l1c2b
	.asc "="
	.byt $1b,$1d,$1c
	.asc "7"
	.byt $1b,$0c,$1c
l1b4d	lda ($1b,x)
	lda ($1b),y
l1b51	stx $43
	tax
	lsr
	bcs l1b6f
l1b57	cpx #$12
	bcs l1b6f
l1b5b	lda l1638
	beq l1b6f
l1b60	php
	sei
	jsr l1b67
l1b65	plp
	rts
l1b67	lda l1b40,x
	pha
	lda l1b3f,x
	pha
l1b6f	ldx $43
	rts
l1b72	lda $5b
	beq l1b88
l1b76	lda $57
	ldx #$01
l1b7a	ldy $57,x
	sty $56,x
	inx
	cpx #$04
	bcc l1b7a
l1b83	jsr l1b51
l1b86	dec $5b
l1b88	rts
l1b89	ldx $5b
	beq l1b9d
l1b8d	ldy $56,x
	bne l1b92
l1b91	dex
l1b92	cpx #$04
	bcc l1b9d
l1b96	pha
	jsr l1b72
l1b9a	pla
	ldx $5b
l1b9d	sta $57,x
	inc $5b
	rts
l1ba2	ldy #$10
	lda #$30
l1ba6	pha
	jsr l16a0
l1baa	jsr l1c70
l1bad	pla
	dey
	bne l1ba6
l1bb1	rts
l1bb2	ldy #$32
	lda #$17
	bne l1ba6
l1bb8	ldx #$40
	ldy #$40
	bne l1bc2
l1bbe	ldx #$e0
	ldy #$06
l1bc2	stx $3a
	stx $2a
	sty $3b
	lda #$01
	sta $2b
l1bcc	lda $3b
	sta $43
l1bd0	ldx $2a
l1bd2	dex
	bne l1bd2
l1bd5	jsr l1c70
l1bd8	ldx $2b
l1bda	dex
	bne l1bda
l1bdd	jsr l1c70
l1be0	dec $43
	bne l1bd0
l1be4	dec $2a
	inc $2b
	lda $2b
	cmp #$1b
	bne l1bcc
l1bee	lda $3b
	sta $43
l1bf2	ldx $2a
l1bf4	dex
	bne l1bf4
l1bf7	jsr l1c70
l1bfa	ldx $2b
l1bfc	dex
	bne l1bfc
l1bff	jsr l1c70
l1c02	dec $43
	bne l1bf2
l1c06	inc $2a
	dec $2b
	bne l1bee
l1c0c	rts
l1c0d	lda #$fb
	sta $3a
l1c11	inx
	bne l1c11
l1c14	jsr l1c70
l1c17	dec $3a
	ldx $3a
	bne l1c11
l1c1d	rts
l1c1e	ldy #$a0
l1c20	tya
	tax
l1c22	dex
	bne l1c22
l1c25	jsr l1c70
l1c28	dey
	bne l1c20
l1c2b	rts
l1c2c	lda #$40
	sta $3a
	lda #$e0
	sta $3b
l1c34	jsr l1e9e
l1c37	ora $3b
	tax
l1c3a	dex
	bne l1c3a
l1c3d	jsr l1c70
l1c40	dec $3b
	lda $3b
	cmp $3a
	bcs l1c34
l1c48	rts
l1c49	lda #$e8
	ldx #$ff
	bne l1c53
l1c4f	lda #$00
	ldx #$08
l1c53	stx $3a
	sta l1c69
	lda #$00
	sta $3b
l1c5c	jsr l1e9e
l1c5f	ora $3b
	tax
l1c62	dex
	bne l1c62
l1c65	jsr l1c70
l1c68	l1c69 = * + 1
; Instruction parameter accessed.
	bit $c0e8
	dec $3a
	bne l1c5c
l1c6f	rts
l1c70	sta $5e
	lda l1c80
	eor #$80
	sta l1c80
	sta SidFilterModeVolume
	l1c7e = * + 1
; Instruction parameter accessed.
	lda $5e
	rts
l1c80 	.byt $8f
l1c81	jsr l1e08
l1c84	lda VicScreenCtrlReg1
	bpl l1c81
l1c89	rts
l1c8a	lda #$08
	sta $45
	sec
	lda $20
	sbc #$09
	sta $46
	sec
	lda $21
	sbc #$04
	sta $47
l1c9c	jsr l1ed5
l1c9f	bpl l1ca4
l1ca1	jsr l1e0d
l1ca4	lda $47
	cmp #$40
	bcs l1cc7
l1caa	lsr
	sta $4d
	lda #$00
	ror
	lsr $4d
	ror
	sta $4c
	lda $4d
	adc #$64
	sta $4d
	ldx #$00
	ldy $46
l1cbf	cpy #$40
	bcc l1cd2
l1cc3	lda #$00
	beq l1cf1
l1cc7	ldx #$12
	lda #$00
l1ccb	sta $66,x
	dex
	bpl l1ccb
l1cd0	bmi l1cfa
l1cd2	lda ($4c),y
	and #$7e
	cmp #$20
	bcc l1cf1
l1cda	cmp #$59
	bcs l1cf1
l1cde	stx $48
	sta $49
	inc l178e
	ldx l178e
	lda $b700,x
	and #$02
	adc $49
	ldx $48
l1cf1	lsr
	sta $66,x
	inx
	iny
	cpx #$13
	bcc l1cbf
l1cfa	lda $47
	inc $47
	cmp $21
	bne l1d08
l1d02	lda l1639
	lsr
	sta $6f
l1d08	ldx $45
	lda l1200,x
	clc
	adc #$28
	sta $60
	lda l12c0,x
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
	lda l1600,y
	sta $64
	lda l1619,y
	ldx $5c
	beq l1d3c
l1d39	clc
	adc #$5c
l1d3c	sta $65
	ldx #$12
l1d40	lda $66,x
	tay
	lda l1500,y
	sta $5e
	lda l1480,y
	sta l1d62
	clc
	adc #$10
	sta l1d67
	lda l14c0,y
	sta l1d63
	adc #$00
	sta l1d68
	ldy #$0f
l1d61	l1d62 = * + 1
	l1d63 = * + 2
	lda lc00,y
	sta ($60),y
	l1d67 = * + 1
	l1d68 = * + 2
	lda lc00,y
	sta ($62),y
	dey
	bpl l1d61
l1d6e	txa
	asl
	tay
	iny
	lda $5e
	sta ($64),y
	iny
	sta ($64),y
	tya
	clc
	adc #$28
	tay
	lda $5e
	sta ($64),y
	dey
	sta ($64),y
	lda $60
	sec
	sbc #$10
	sta $60
	lda $61
	sbc #$00
	sta $61
	lda $62
	sec
	sbc #$10
	sta $62
	lda $63
	sbc #$00
	sta $63
	dex
	bpl l1d40
l1da2	lda $45
	clc
	adc #$10
	sta $45
	lda $45
	cmp #$98
	bcs l1db2
l1daf	jmp l1c9c
l1db2	jsr l1700
l1db5	dec l178b
	bne l1dc4
l1dba	lda #$02
	sta l178b
	ldy #$00
	jsr l1b06
l1dc4	dec l178c
	bne l1dda
l1dc9	lda #$03
	sta l178c
	ldx lc89
	ldy lc8a
	sty lc89
	stx lc8a
l1dda	dec l178d
	bne l1df0
l1ddf	lda #$02
	sta l178d
	ldx lcc3
	ldy lcc4
	sty lcc3
	stx lcc4
l1df0	ldx ld8a
	ldy ld8b
	sty ld8a
	stx ld8b
	ldx ld82
	ldy ld83
	sty ld82
	stx ld83
l1e08	jsr l1ed5
l1e0b	bpl l1e27
l1e0d	cmp #$90
	beq l1e27
l1e11	cmp #$93
	beq l1e27
l1e15	cmp #$a0
	bne l1e1d
l1e19	ldx #$00
	stx $56
l1e1d	ldx $56
	cpx #$08
	bcs l1e27
l1e23	sta $4e,x
	inc $56
l1e27	rts
l1e28 	l1e2a = * + 2
	.byt $97,$96,$18,$80
l1e2c	ldy #$07
l1e2e	jsr l1e08
l1e31	lda $56
	bne l1e27
l1e35	lda #$4f
	jsr l16a0
l1e3a	dey
	bne l1e2e
l1e3d	rts
l1e3e	jsr l1e44
l1e41	beq l1e3e
l1e43	rts
l1e44	jsr l1e83
l1e47	jsr l1e2c
l1e4a	lda $56
	bne l1e5a
l1e4e	beq l1e7a
l1e50	jsr l1e83
l1e53	jsr l1c8a
l1e56	lda $56
	beq l1e7a
l1e5a	lda #$20
	jsr l1a78
l1e5f	lda $4e
	dec $56
	ldx #$01
	cmp #$ff
	bne l1e6b
l1e69	lda #$88
l1e6b	cmp #$e0
	bcc l1e71
l1e6f	eor #$20
l1e71	ldy $4e,x
	sty $4d,x
	inx
	cpx #$08
	bcc l1e71
l1e7a	ldx l1789
	ldy l178a
	and #$7f
	rts
l1e83	stx l1789
	sty l178a
	jsr l16ac
l1e8c	ldx l1e9a
	dex
	cpx #$7c
	bcs l1e96
l1e94	ldx #$7f
l1e96	stx l1e9a
	l1e9a = * + 1
	lda #$7c
	jsr l1a78
l1e9e	clc
	lda l1ed4
	ldx #$0e
l1ea4	adc l1ec5,x
	sta l1ec5,x
	dex
	bpl l1ea4
l1ead	lda l1ed4
	clc
	adc l1ec5
	sta l1ec5
	ldx #$0f
l1eb9	inc l1ec5,x
	bne l1ec1
l1ebe	dex
	bpl l1eb9
l1ec1	lda l1ec5
	rts
l1ec5 	.asc ""
	.byt $64,$76,$85,$54
	.asc "v"
	.byt $5c,$76,$1f
	.asc "g"
	.byt $12
	.asc "'"
	.byt $6b,$93
	.asc "D"
l1ed3	l1ed4 = * + 1
	l1ed5 = * + 2
; Instruction parameter jumped to.
	ror $841b
l1ed6	l1ed7 = * + 1
; Instruction parameter jumped to.
	lsr $ffa9,x
	sta Cia1PortB
	lda Cia1PortA
	sty $5e
	ldy #$04
l1ee3	lsr
	bcs l1eec
l1ee6	lda l1632,y
	bne l1f27
l1eeb	rts
l1eec	dey
	bpl l1ee3
l1eef	jsr SCNKEY
l1ef2	jsr GETIN
l1ef5	cmp #$00
	bne l1f01
l1ef9	sta l1f83
	sta l1f84
	beq l1f7a
l1f01	cmp #$ba
	bne l1f07
l1f05	lda #$40
l1f07	cmp #$91
	bne l1f0d
l1f0b	lda #$40
l1f0d	cmp #$11
	bne l1f13
l1f11	lda #$2f
l1f13	cmp #$3f
	bne l1f19
l1f17	lda #$2f
l1f19	cmp #$9d
	bne l1f1f
l1f1d	lda #$3a
l1f1f	cmp #$1d
	bne l1f25
l1f23	lda #$3b
l1f25	ora #$80
l1f27	cmp l1f83
	sta l1f83
	bne l1f6f
l1f2f	cmp #$c0
	beq l1f46
l1f33	cmp #$af
	beq l1f46
l1f37	cmp #$bb
	beq l1f46
l1f3b	cmp #$ba
	beq l1f46
l1f3f	lda #$00
	sta l1f84
	beq l1f7a
l1f46	ldy l1637
	cpy #$04
	bcs l1f5e
l1f4d	ldy l1f84
	bne l1f67
l1f52	ldy Cia1TimeOfDaySeconds
	bne l1f62
l1f57	ldy Cia1TimeOfDayDseconds
	cpy #$05
	bcs l1f62
l1f5e	lda #$00
	beq l1f7a
l1f62	inc l1f84
	bne l1f6f
l1f67	ldy Cia1TimeOfDayDseconds
	cpy l1637
	bcc l1f5e
l1f6f	ldy #$00
	sty Cia1TimeOfDayHours
	sty Cia1TimeOfDaySeconds
	sty Cia1TimeOfDayDseconds
l1f7a	ldy #$ff
	sty $c5
	ldy $5e
	pha
	pla
	rts
l1f83 	l1f84 = * + 1
	.byt $00,$00
	.asc " "
	.byt $ff