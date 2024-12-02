with open("customio.asm", 'r') as r:
    data = r.read()

out = ""

for i in data.split('\n'):
    if i.startswith('; '):
        out += "|" + i[2:] + '\n'
        if i[2:] == "--------------------------------------------------------":
            out += '\n\n'

with open("customioDocs.txt", 'w') as w:
    w.write(out)