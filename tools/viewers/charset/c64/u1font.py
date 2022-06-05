from PIL import Image, ImageDraw, ImageColor
import inspect
import sys
import math
#import vic2

def convertByte(b, bgcol, fgcol):
    """Print a byte of C64 bitmap as 8 pixels"""
    pixels = []
    for i in range(8):
        pixel = 1 & (b >> (7-i))
        pixels.append((bgcol,fgcol)[pixel])
    return pixels

def drawChar(draw, charset, ch, x, y, col0, col1):
    print("Char:", ch, "draw", draw, "x", x, "y", y, "col0", col0, "col1", col1)
    for py in range(8):
        px = 0
        b = charset[ch * 8 + py]
        for pixel in convertByte(b, col0, col1):
            draw.point((x+px, y+py), pixel)
            px += 1


if __name__ == "__main__":
    width = 8 * 16
    height = 8 * 8

    # open and read C64 character set file
    file = open("TEXT", "rb")
    charset = file.read()
    file.close()

    # create a blank image
    image = Image.new("RGB", (width, height))

    # get a drawing context
    draw = ImageDraw.Draw(image)

    #palette = vic2.makePalette()

    # draw character set
    for ch in range(128):
        x = (ch % 16) * 8
        y = (ch // 16) * 8
        print("Character", ch)
        drawChar(draw, charset, ch, x, y, "black", "white")

    image.show()
    image.save("u1_character_font.png")

