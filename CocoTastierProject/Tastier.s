;5
    LDR     R5, =99999
 LDR R2, =203
 ADD R2, R4, R2, LSL #2
 STR R5, [R2] ; test
; Procedure Subtract
SubtractBody
;5
 LDR R2, =202
 ADD R2, R4, R2, LSL #2
 LDR R5, [R2] ; i
;6
    LDR     R6, =1
    SUB     R5, R5, R6
 LDR R2, =202
 ADD R2, R4, R2, LSL #2
 STR R5, [R2] ; i
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from Subtract
Subtract
    LDR     R0, =2          ; current lexic level
    LDR     R1, =0          ; number of local variables
    BL      enter           ; build new stack frame
    B       SubtractBody

; Procedure Add
AddBody
;5
 LDR R2, =202
 ADD R2, R4, R2, LSL #2
 LDR R5, [R2] ; i
;6
    LDR     R6, =0
    CMP     R5, R6
    MOVGT   R5, #1
    MOVLE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L1              ; jump on condition false
;5
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; sum
;6
 LDR R2, =202
 ADD R2, R4, R2, LSL #2
 LDR R6, [R2] ; i
    ADD     R5, R5, R6
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; sum
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       Subtract
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       Add
    B       L2
L1
L2
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from Add
Add
    LDR     R0, =2          ; current lexic level
    LDR     R1, =0          ; number of local variables
    BL      enter           ; build new stack frame
    B       AddBody

; Procedure SumUp
SumUpBody
;5
 LDR R2, =202
 ADD R2, R4, R2, LSL #2
 LDR R5, [R2] ; i
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; j
;5
    LDR     R5, =0
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; sum
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       Add
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L3
    DCB     "The sum of the values from 1 to ", 0
    ALIGN
L3
;5
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; j
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L4
    DCB     " is ", 0
    ALIGN
L4
;5
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; sum
    MOV     R0, R5
    BL      TastierPrintIntLf
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from SumUp
SumUp
    LDR     R0, =1          ; current lexic level
    LDR     R1, =2          ; number of local variables
    BL      enter           ; build new stack frame
    B       SumUpBody
;OBJECT--Name: j. Local variable of type Integer with address 0
;OBJECT--Name: sum. Local variable of type Integer with address 1
;OBJECT--Name: Subtract. Local procedure with address 0
;OBJECT--Name: Add. Local procedure with address 0

MainBody
;5
    LDR     R5, =4
    ADD     R2, BP, #16
    LDR     R1, =200
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; book1.bookId
;5
    LDR     R5, =3
    ADD     R2, BP, #16
    LDR     R1, =201
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; StackTopTemp
;5
    LDR     R5, =9
    ADD     R2, BP, #16
    LDR     R1, =50
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2, R5, LSL #2] ; value of book1.title[]
    ADD     R2, BP, #16
    LDR     R1, =50
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; book1.title
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L5
    DCB     "Enter value for i (or 0 to stop): ", 0
    ALIGN
L5
    BL      TastierReadInt
 LDR R2, =202
 ADD R2, R4, R2, LSL #2
 STR R0, [R2] ; i
L6
;6
 LDR R2, =202
 ADD R2, R4, R2, LSL #2
 LDR R6, [R2] ; i
;7
    LDR     R7, =0
    CMP     R6, R7
    MOVGT   R6, #1
    MOVLE   R6, #0
    MOVS    R6, R6          ; reset Z flag in CPSR
    BEQ     L7              ; jump on condition false
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       SumUp
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L8
    DCB     "Enter value for i (or 0 to stop): ", 0
    ALIGN
L8
    BL      TastierReadInt
 LDR R2, =202
 ADD R2, R4, R2, LSL #2
 STR R0, [R2] ; i
;5
    LDR     R5, =4
 LDR R2, =314
 ADD R2, R4, R2, LSL #2
 STR R5, [R2] ; randy
;5
    LDR     R5, =7
    ADD     R2, BP, #16
    LDR     R1, =202
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; StackTopTemp
;5
 LDR R2, =314
 ADD R2, R4, R2, LSL #2
 LDR R5, [R2] ; randy
    ADD     R2, BP, #16
    LDR     R1, =202
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; StackTopTemp
    MUL     R5, R5, R5
    ADD     R2, BP, #16
    LDR     R1, =202
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; StackTopTemp
;6
    LDR     R6, =5
    ADD     R2, BP, #16
    LDR     R1, =202
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; StackTopTemp
    LDR     R2, =313
    ADD     R2, R4, R2, LSL #2
    STR     R6, [R2, R5, LSL #2] ; value of testArr[]
 LDR R2, =313
 ADD R2, R4, R2, LSL #2
 STR R6, [R2] ; testArr
;6
;7
    LDR     R7, =7
    ADD     R2, BP, #16
    LDR     R1, =202
    ADD     R2, R2, R1, LSL #2
    STR     R7, [R2]        ; StackTopTemp
;5
 LDR R2, =314
 ADD R2, R4, R2, LSL #2
 LDR R5, [R2] ; randy
    ADD     R2, BP, #16
    LDR     R1, =202
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; StackTopTemp
    MUL     R5, R5, R5
    ADD     R2, BP, #16
    LDR     R1, =202
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; StackTopTemp
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2, #16
    LDR     R1, =313
    ADD     R2, R2, R1, LSL #2
    LDR     R6, [R2, R5, LSL #2] ; value of testArr[]
 LDR R2, =313
 ADD R2, R4, R2, LSL #2
 STR R6, [R2] ; sum
;5
    LDR     R5, =1
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2, #16
    LDR     R1, =314
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; randy
    CMP     R5, R5
    MOVEQ   R5, #1
    MOVNE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L9              ; jump on condition false
;6
    LDR     R6, =1
 LDR R2, =313
 ADD R2, R4, R2, LSL #2
 STR R6, [R2] ; sum
    B       L10
L9
;5
    LDR     R5, =2
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2, #16
    LDR     R1, =314
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; randy
    CMP     R5, R5
    MOVEQ   R5, #1
    MOVNE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L9              ; jump on condition false
;6
    LDR     R6, =2
 LDR R2, =313
 ADD R2, R4, R2, LSL #2
 STR R6, [R2] ; sum
L9
;5
    LDR     R5, =3
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2, #16
    LDR     R1, =314
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; randy
    CMP     R5, R5
    MOVEQ   R5, #1
    MOVNE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L9              ; jump on condition false
;6
    LDR     R6, =3
 LDR R2, =313
 ADD R2, R4, R2, LSL #2
 STR R6, [R2] ; sum
    B       L10
L9
;5
    LDR     R5, =4
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2, #16
    LDR     R1, =314
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; randy
    CMP     R5, R5
    MOVEQ   R5, #1
    MOVNE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L9              ; jump on condition false
;6
    LDR     R6, =4
 LDR R2, =313
 ADD R2, R4, R2, LSL #2
 STR R6, [R2] ; sum
;5
    LDR     R5, =11
    MOV     R0, R5
    BL      TastierPrintInt
    B       L10
L9
;5
    LDR     R5, =5
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2, #16
    LDR     R1, =314
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; randy
    CMP     R5, R5
    MOVEQ   R5, #1
    MOVNE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L9              ; jump on condition false
L9
;6
    LDR     R6, =10
    MOV     R0, R6
    BL      TastierPrintInt
L10
    LDR     R5, =0
    ADD     R2, BP, #16
    LDR     R1, =203
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; j
;6
    LDR     R6, =5
L12
    CMP     R5, R6
    MOVLT   R5, #1
    MOVGE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L11              ; jump on condition false
;5
    LDR     R5, =5
 LDR R2, =314
 ADD R2, R4, R2, LSL #2
 STR R5, [R2] ; randy
    CMP     R5, R-1
    SUB     R5, R5, #1
    B       L12
L11
    B       L6
L7
StopTest
    B       StopTest
Main
    LDR     R0, =1          ; current lexic level
    LDR     R1, =204          ; number of local variables
    BL      enter           ; build new stack frame
    B       MainBody
;OBJECT--Name: book1. Local procedure with address 0
;OBJECT--Name: book1.title. Local procedure with address 50
;OBJECT--Name: book1.author. Local procedure with address 100
;OBJECT--Name: book1.subject. Local procedure with address 200
;OBJECT--Name: book1.bookId. Local variable of type Integer with address 200

;OBJECT--Name: Books. Global procedure with address 0
;OBJECT--Name: title. Global procedure with address 50
;OBJECT--Name: author. Global procedure with address 100
;OBJECT--Name: subject. Global procedure with address 200
;OBJECT--Name: bookId. Global variable of type Integer with address 200
;OBJECT--Name: EndStruct. Global variable of type Boolean with address 201
;OBJECT--Name: i. Global variable of type Integer with address 202
;OBJECT--Name: test. Global procedure with address 203
;OBJECT--Name: testArr. Global procedure with address 313
;OBJECT--Name: sum. Global variable of type Integer with address 313
;OBJECT--Name: randy. Global variable of type Integer with address 314
;OBJECT--Name: SumUp. Global procedure with address 0
;OBJECT--Name: main. Global procedure with address 0

