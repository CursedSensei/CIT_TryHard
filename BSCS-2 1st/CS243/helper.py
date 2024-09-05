name = "Exer5.asm"
input = """John Zillon Reyes, Computer Science
Test helper"""



fpOut = """; Filename: """ + name + """
; Displaying single-characters, numbers, and symbols
; JOHN ZILLION REYES
; Date: August 30, 2024

.model small
.code
.stack 100
start:
	"""

for i in input:
	fpOut += """

	mov ah, 02h
	mov dl, """ + str(ord(i)) + """
	int 21h"""

fpOut += """
int 27h
end start"""


with open(name, "w") as w:
	w.write(fpOut)