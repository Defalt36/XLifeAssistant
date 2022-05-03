import sys
from PIL import Image, ImageDraw, ImageFont

format = '32_32'
fontFile = 'files/sample_font.ttf'
fontSize = 24

if (len(sys.argv) == 2):
    format = sys.argv[1]
if (len(sys.argv) == 3):
    format = sys.argv[1]
    fontFile = sys.argv[2]
elif (len(sys.argv) == 4):
    format = sys.argv[1]
    fontFile = sys.argv[2]
    fontSize = int(sys.argv[3])

if (format == '32_64'):
    canvasSize = ( 512, 1024 )
    #new_canvas = Image.new('RGB', canvasSize, color="black" )
    new_canvas = Image.open('files/grid.png')
    distance_x = 32
    distance_y = 64
    offset_x = 8
    offset_y = 32
elif (format == '32_32'):
    canvasSize = ( 512, 512 )
    new_canvas = Image.new('RGB', canvasSize, color="black" )
    distance_x = 32
    distance_y = 32
    offset_x = 8
    offset_y = 0

working_canvas = ImageDraw.Draw(new_canvas)
loadedFont = ImageFont.truetype(fontFile, fontSize)

print("[ Drawing table... ]")

file = open('files/custom_table.txt', mode = 'r')
table = file.read()
file.close()

index = 0
for character in table:
    if (character == '\n'):
        continue
    # Print character table to console
    if index % 16 == 15:
        print(character)
    else:
        print(character,end='')
    
    x_position = ( distance_x * ( index%16 ) ) + offset_x
    y_position = ( distance_y * ( index//16 ) ) + offset_y
    
    working_canvas.text( (x_position, y_position), character, fill='white', font=loadedFont, anchor='mm')
    index += 1

print("[ Done. ]")

new_canvas.save("output/canvas.png")
