; architecture specific constants

CHAR_COLUMNS = 40

COL_BLACK = $00
COL_WHITE = $01
COL_RED = $02
COL_CYAN = $03
COL_PURPLE = $04
COL_GREEN = $05
COL_BLUE = $06
COL_YELLOW = $07
COL_ORANGE = $08
COL_BROWN = $09
COL_LIGHTRED = $0a
COL_DARKGREY = $0b
COL_MIDGREY = $0c
COL_LIGHTGREEN = $0d
COL_LIGHTBLUE = $0e
COL_LIGHTGREY = $0f

KEY_NORTH = $40                 ; '@' (North)
KEY_SOUTH = $2f                 ; '/' (South)
KEY_EAST = $3b                  ; ';' (East)
KEY_WEST = $3a                  ; ':' (West)
KEY_ARROW_UP = $91              ; arrow up
KEY_ARROW_DOWN = $11            ; arrow down
KEY_ARROW_LEFT = $9d            ; arrow left
KEY_ARROW_RIGHT = $1d           ; arrow right

LF = $7c
CR = $7f

FA = $ba
FNADR = $bb

KEYLOG = $028f
IMAIN = $0302
NMINV = $0318
ILOAD = $0330

screenRAM = $0400
charset = $0800
tileset = $0c00
bmpLinePtrLb = $1200
bmpLinePtrHb = $12c0
bmpColOffLb = $15b0
bmpColOffHb = $15d8
bitmapRAM = $2000
bitmap2RAM = $4000
hello = $8000
roster = $b000

race = $824b

printAtPos = $848a
print = $848e

loadFile = $c480
saveFile = $c483
loadSpecial = $c486

SCNPNT = $e716
SETLFS = $ffba
SETNAM = $ffbd
LOAD = $ffd5

VicScreenCtrlReg1 = $d011
VicBorderColor = $d020
