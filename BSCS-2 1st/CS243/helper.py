import os

for i in os.listdir():
    if i.lower().startswith("exam1"):
        with open(i, "r") as r:
            data = r.read()
        header = []
        for j in data.split("\n"):
            if j.startswith(";"):
                header.append('"' + j[1:].lstrip() + '"')
            else:
                break
        data = data.split("\n")
        pos = 0
        for j in data:
            if j.lower().startswith(".data"):
                break
            pos += 1
        data.insert(pos + 1, "\tszTitle db " + ", 0Ah, ".join(header) + ", 0Ah, 0Ah, '$'")
        with open(i, "w") as r:
            r.write("\n".join(data))