    LDR     R5, =99999
 LDR R2, =1
 ADD R2, R4, R2, LSL #2
 STR R5, [R2] ; test
; Procedure Subtract
SubtractBody
 LDR R2, =0
 ADD R2, R4, R2, LSL #2
 LDR R6, [R2] ; i
    LDR     R7, =1
    SUB     R6, R6, R7
 LDR R2, =0
 ADD R2, R4, R2, LSL #2
 STR R6, [R2] ; i
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
 LDR R2, =0
 ADD R2, R4, R2, LSL #2
 LDR R8, [R2] ; i
    LDR     R9, =0
    CMP     R8, R9
    MOVGT   R8, #1
    MOVLE   R8, #0
    MOVS    R8, R8          ; reset Z flag in CPSR
    BEQ     L1              ; jump on condition false
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    LDR     R10, [R2]        ; sum
 LDR R2, =0
 ADD R2, R4, R2, LSL #2
 LDR R11, [R2] ; i
    ADD     R10, R10, R11
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    STR     R10, [R2]        ; sum
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
 LDR R2, =0
 ADD R2, R4, R2, LSL #2
 LDR R12, [R2] ; i
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R12, [R2]        ; j
    LDR     R13, =0
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    STR     R13, [R2]        ; sum
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       Add
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L3
    DCB     "The sum of the values from 1 to ", 0
    ALIGN
L3
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R14, [R2]        ; j
    MOV     R0, R14
    BL      TastierPrintInt
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L4
    DCB     " is ", 0
    ALIGN
L4
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    LDR     R15, [R2]        ; sum
    MOV     R0, R15
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
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L5
    DCB     "Enter value for i (or 0 to stop): ", 0
    ALIGN
L5
    BL      TastierReadInt
 LDR R2, =0
 ADD R2, R4, R2, LSL #2
 STR R0, [R2] ; i
L6
 LDR R2, =0
 ADD R2, R4, R2, LSL #2
 LDR R16, [R2] ; i
    LDR     R17, =0
    CMP     R16, R17
    MOVGT   R16, #1
    MOVLE   R16, #0
    MOVS    R16, R16          ; reset Z flag in CPSR
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
 LDR R2, =0
 ADD R2, R4, R2, LSL #2
 STR R0, [R2] ; i
    LDR     R18, =4
 LDR R2, =112
 ADD R2, R4, R2, LSL #2
 STR R18, [R2] ; month
    LDR     R19, =7
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R19, [R2]        ; StackTopTemp
 LDR R2, =112
 ADD R2, R4, R2, LSL #2
 LDR R20, [R2] ; month
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R21, [R2]        ; StackTopTemp
    ADD     R21, R21, R20
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R21, [R2]        ; StackTopTemp
    LDR     R22, =5
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R23, [R2]        ; StackTopTemp
    LDR     R2, =111
    ADD     R2, R4, R2, LSL #2
    STR     R22, [R2, R23, LSL #2] ; value of testArr[]
 LDR R2, =111
 ADD R2, R4, R2, LSL #2
 STR R22, [R2] ; testArr
    LDR     R25, =7
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R25, [R2]        ; StackTopTemp
 LDR R2, =112
 ADD R2, R4, R2, LSL #2
 LDR R26, [R2] ; month
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R27, [R2]        ; StackTopTemp
    ADD     R26, R26, R27
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R26, [R2]        ; StackTopTemp
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2, #16
    LDR     R1, =111
    ADD     R2, R2, R1, LSL #2
    LDR     R28, [R2, R26, LSL #2] ; value of testArr[]
 LDR R2, =111
 ADD R2, R4, R2, LSL #2
 STR R24, [R2] ; sum
    LDR     R29, =1
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2, #16
    LDR     R1, =112
    ADD     R2, R2, R1, LSL #2
    STR     R30, [R2]        ; month
    CMP     R29, R30
    MOVEQ   R29, #1
    MOVNE   R29, #0
    MOVS    R29, R29          ; reset Z flag in CPSR
    BEQ     L9              ; jump on condition false
    LDR     R31, =1
 LDR R2, =111
 ADD R2, R4, R2, LSL #2
 STR R31, [R2] ; sum
    B       L10
L9
    LDR     R32, =2
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2, #16
    LDR     R1, =112
    ADD     R2, R2, R1, LSL #2
    STR     R33, [R2]        ; month
    CMP     R32, R33
    MOVEQ   R32, #1
    MOVNE   R32, #0
    MOVS    R32, R32          ; reset Z flag in CPSR
    BEQ     L9              ; jump on condition false
    LDR     R34, =2
 LDR R2, =111
 ADD R2, R4, R2, LSL #2
 STR R34, [R2] ; sum
L9
    LDR     R35, =3
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2, #16
    LDR     R1, =112
    ADD     R2, R2, R1, LSL #2
    STR     R36, [R2]        ; month
    CMP     R35, R36
    MOVEQ   R35, #1
    MOVNE   R35, #0
    MOVS    R35, R35          ; reset Z flag in CPSR
    BEQ     L9              ; jump on condition false
    LDR     R37, =3
 LDR R2, =111
 ADD R2, R4, R2, LSL #2
 STR R37, [R2] ; sum
    B       L10
L9
    LDR     R38, =4
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2, #16
    LDR     R1, =112
    ADD     R2, R2, R1, LSL #2
    STR     R39, [R2]        ; month
    CMP     R38, R39
    MOVEQ   R38, #1
    MOVNE   R38, #0
    MOVS    R38, R38          ; reset Z flag in CPSR
    BEQ     L9              ; jump on condition false
    LDR     R40, =4
 LDR R2, =111
 ADD R2, R4, R2, LSL #2
 STR R40, [R2] ; sum
    LDR     R41, =11
    MOV     R0, R41
    BL      TastierPrintInt
    B       L10
L9
    LDR     R42, =5
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2, #16
    LDR     R1, =112
    ADD     R2, R2, R1, LSL #2
    STR     R43, [R2]        ; month
    CMP     R42, R43
    MOVEQ   R42, #1
    MOVNE   R42, #0
    MOVS    R42, R42          ; reset Z flag in CPSR
    BEQ     L9              ; jump on condition false
L9
    LDR     R44, =10
    MOV     R0, R44
    BL      TastierPrintInt
L10
    B       L6
L7
StopTest
    B       StopTest
Main
    LDR     R0, =1          ; current lexic level
    LDR     R1, =1          ; number of local variables
    BL      enter           ; build new stack frame
    B       MainBody

;OBJECT--Name: i. Global variable of type Integer with address 0
;OBJECT--Name: test. Global procedure with address 1
;OBJECT--Name: testArr. Global procedure with address 111
;OBJECT--Name: sum. Global variable of type Integer with address 111
;OBJECT--Name: month. Global variable of type Integer with address 112
;OBJECT--Name: SumUp. Global procedure with address 0
;OBJECT--Name: main. Global procedure with address 0

