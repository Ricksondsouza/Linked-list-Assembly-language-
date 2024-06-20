	AREA RAM,DATA,ALIGN=4
	EXPORT head [DATA,SIZE=4]
	EXPORT nodes [DATA,SIZE=4]
choice SPACE 12
head SPACE 4
nodes SPACE 48
	 AREA MYCODE,CODE,READONLY
	 ENTRY
	 EXPORT __main
__main
	;Initialise head with the address of the first node
	LDR R0,=head
	LDR R1,=nodes
	LDR R6,=choice
	STR R1,[R0]
	MOV R9,R6
	MOV R11,R6
	MOV R8,#0x01
loop
	ADD R2,R1,#4
	ADD R3,R2,#4
	STR R3,[R2]
	ADD R4,R3,#8
	LDR R5,[R4]
	MOV R1,R3
	MOV R12,R3
	CMP R5,#0x00
	BNE loop
operations
	CMP R8,#0x04
	BGT STOP
	LDR R1,[R6]
	CMP R1,#1
	BEQ add_new_node
	CMP R1,#2
	BEQ delete_node
	B STOP
add_new_node
	MOV R3,R12
	ADD R4,R3,#8
	ADD R7,R3,#4
	STR R4,[R7]
	ADD R6,#4
	MOV R5,R4
	ADD R8,#1
	B operations
delete_node
	MOV R9,R11
	CMP R6,R9
	BEQ NODE1
	ADD R9,#4
	CMP R6,R9
	BEQ NODE2
	ADD R9,#4
	CMP R6,R9
	BEQ NODE3
	B operations
NODE1
	MOV R4,#0x00
	LDR R1,=nodes
	STR R4,[R1]
	ADD R1,#4
	STR R4,[R1]
HEAD
	ADD R1,#4
	STR R1,[R0]
	ADD R6,#4
	ADD R8,#1
	B operations
NODE2
	MOV R4,#0x00
	LDR R1,=nodes
	ADD R1,#8
	STR R4,[R1]
	SUB R2,R1,#4
	LDR R10,[R2]
	ADD R1,#4
	STR R4,[R1]
	CMP R10,#0x00
	BEQ HEAD
	ADD R1,#4
	STR R1,[R2]
	ADD R6,#4
	ADD R8,#1
	B operations
NODE3
	MOV R4,#0x00
	LDR R1,=nodes
	ADD R1,#16
	STR R4,[R1]
	SUB R2,R1,#4
	LDR R10,[R2]
	ADD R1,#4
	STR R4,[R1]
	CMP R10,#0x00
	BEQ CMP_NODE2
CMP_NODE2
	SUB R2,#8
	LDR R10,[R2]
	STR R4,[R1]
	CMP R10,#0x00
	BEQ HEAD
	ADD R1,#4
	STR R1,[R2]
	ADD R6,#4
	ADD R8,#1
	B operations
STOP
	B STOP
	ALIGN
	END
