import sys
import os
import json

from PIL import Image

JSON_FILE = sys.argv[1]
LIST = False

if os.path.isfile("./" + JSON_FILE):
    with open(JSON_FILE) as f:
        data = f.read()
    LIST = json.loads(data)
else:
    print(JSON_FILE + " couldn't found.")

if LIST:
    COLOR_TABLE = LIST['color_table']

    fileout = './lvls.bullshit'
    OUTPUT = ''

    for i in range(len(LIST['list'])):
        level = LIST['list'][i]
        n = level['n']
        f = level['f']
        
        img = Image.open(f)
        pixels = img.load()

        w, h = img.size

        OUTPUT += '\n{ "name": "' + n + '", "arr": {'

        for y in range(h):
            OUTPUT += '\n\t{ '
            for x in range(w):
                p = pixels[x, y]
                
                key = str(p[0]) + "-" + str(p[1]) + "-" + str(p[2])
                index = COLOR_TABLE[key]
                
                OUTPUT += index

                if x != w - 1:
                    OUTPUT += ','

                OUTPUT += ' '

            OUTPUT += '}'

            if y != h - 1:
                OUTPUT += ','
        
        OUTPUT += '\n}}'

        if i < len(LIST['list']) - 1:
            OUTPUT += ','

    OUTPUT += ''

    with open(fileout, "w", encoding="utf8") as f:
        f.write(OUTPUT)
