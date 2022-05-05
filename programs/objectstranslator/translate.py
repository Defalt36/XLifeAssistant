import sys
from googletrans import Translator

target = 'pt_br'
inputfile = 'output/default_names.txt'
outputfile = 'output/translated_names.txt'

if (len(sys.argv) == 2):
    target = sys.argv[1]
elif (len(sys.argv) == 3):
    target = sys.argv[1]
    inputfile = sys.argv[2]

translator = Translator()

file = open(inputfile, mode = 'r')
lines = file.read().splitlines()
file.close()

output_file = open(outputfile, mode = 'w')
# parse intructions file
for line in lines:
    linearr = line.split(';')
    
    object_name = linearr[1]
    string = ''
    for character in object_name:
        if character.isalnum() or character.isspace() or character == '-':
            string += character
        else:
            break
    
    if ( len(string) == 0 ):
        continue
    
    newstring = translator.translate(string, dest=target, src='en').text
    newline = linearr[0]+';'+object_name.replace( string.strip(), newstring.strip().title() )+'\n'
    output_file.write(newline)
output_file.close()