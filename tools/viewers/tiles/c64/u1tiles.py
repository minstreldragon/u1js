from PIL import Image, ImageDraw, ImageColor
import inspect
import sys
import math
import vic2

tileColors = [
        0x60,0x50,0x50,0xf0,0x10,0x10,0x10,0xf0,
        0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,
        0x10,0x10,0x50,0x50,0x10,0x10,0x10,0x10,
        0x10,0x10,0x10,0x10,0x50,0x50,0x10,0x10,
        0x50,0x50,0x10,0x10,0x10,0x10,0x10,0x10,
        0x10,0x10,0x10,0x10,0x10,0x10,0x30,0xa0
        ]

def convertByte(b, bgcol, fgcol):
    """Print a byte of C64 bitmap as 8 pixels"""
    pixels = []
    for i in range(8):
        pixel = 1 & (b >> (7-i))
        pixels.append((bgcol,fgcol)[pixel])
    return pixels

def drawTile(draw, tileset, tile, x, y, col0, col1):
    print("Tile:", tile, "draw", draw, "x", x, "y", y, "col0", col0, "col1", col1)
    for py in range(16):
        px = 0
        #b = tileset[tile * 2 + py * 128]
        b = tileset[tile * 32 + (py // 8) * 16 + py % 8]
        for pixel in convertByte(b, col0, col1):
            draw.point((x+px, y+py), pixel)
            px += 1
        px = 0
        #b = tileset[tile * 2 + py * 128 + 1]
        b = tileset[tile * 32 + (py // 8) * 16 + py % 8 + 8]
        for pixel in convertByte(b, col0, col1):
            draw.point((x+px+8, y+py), pixel)
            px += 1

if __name__ == "__main__":

    width = 8 * 16
    height = 6 * 16

    # open and read C64 tile set file
    file = open("st", "rb")
    # skip load address
    tileset = file.read()[2:]
    file.close()

    # create a blank image
    image = Image.new("RGB", (width, height))

    # get a drawing context
    draw = ImageDraw.Draw(image)

    # create the VIC Palette
    palette = vic2.makePalette()

    # draw character set
    for tile in range(48):
        x = (tile % 8) * 16
        y = (tile // 8) * 16
        col0 = palette[tileColors[tile] & 0x0f]
        col1 = palette[tileColors[tile] // 16]
        print("Character", tile)
        drawTile(draw, tileset, tile, x, y, col0, col1)

    image.show()
    image.save("u1_tiles.png")

