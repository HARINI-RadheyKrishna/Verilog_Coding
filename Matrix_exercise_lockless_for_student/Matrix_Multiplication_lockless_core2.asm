;-----------------------------------
;EE560 ASM Lab
;Summer 2016
;Topic: Matrix Multiplication
;Auther: Heqing Huang
;Version: Lockless 
;-----------------------------------


;-----------------------------------
;This is core Two
;This is core Two
;This is core Two
;-----------------------------------


;-----------------------------------
;Memory Allocation
;-----------------------------------
;In the Main memory, we have totally 1024 locations, each location holds a word.
;So it is 1024 X 32 bits = 1024 X 4 Bytes = 1024 X 1 Words.
;Basically the address we are talking about is the WORD Address, so it should be divided by 4.
;Remember the location and the address are different and they all starting from 0:
;Locatin 0 <=> Address  is 0 (First location)
;Location 1 <=> Address  is 4 (not 1 or 2)
;Location 512 <=> Address is 512*4 = 2048
;Location 1023 <=> Address is 4092 (Last location)

;In the ASM code, when we are talking about the memory, we are talking about the address.
;For example: LW $1, 200($0); Load the data in word address 200 from memory. In our design we usually access a word rather then a byte so he address here is word address. 

;Two parts are fixed - The Matrix A and B, please follow the exact location(address) in your code.
;Others(Lock L, Sum Result S, Barrier B) address is also defined here. Please follow the address so that it is easier for you and for us to debug and test the result. 
;------------------------------------
;Matrix A:
;Location: 0 ~ 15 (Totally 16 locations)
;Address: 0 ~ 60

;Matrix B:
;Location: 16 ~ 31(Totally 16 locations)
;Address: 64 ~ 124

;LOCK:
;Location: 32
;Address: 128

;SUM Result:
;Location 33
;Adderss: 132

;Barrier:
;Location: 34
;Address: 136


;-------------------------------------


;-----------------------------------
;Register Allocation
;-----------------------------------
;The register holds some intermediate value for calculation or process.
;Here we have pre-define the usage of some registers. You can follow them or use you own choose.
;When you write your code, if you need more registers except the defined registers here you can use the rest register as you wish 
;$0 always store 0, so do not use $0 as destination register.
;Each thread has its own register files so they are not sharing register
;-----------------------------------
;$0 - Store 0;
;$1 - Store data of the element of Matrix A from memory 
;$2 - Store data of the element of Matrix B from memory
;$3 - Store the result of A X B
;$4 - Store the lock -- Since we do not need lock here there is no need for this register here but for simplicity we keep it here but we are not using it. 
;$5 - Store data of SUM from memory 
;$6 - Store the barrier
;$7 - Store 16 to check barrier
;-----------------------------------


;------------------------------------
;Starting of the code
;Please keep the formant of each thread here
;------------------------------------



;#################################################################
; 							THREAD 0
;#################################################################
;Add your code here
LW $1, 32($0);
LW $2, 96($0);
MULT $3, $2, $1;

LOOP0_T0: LL $5, 132($0);
ADD $5, $5, $3;
SC $5, 132($0);
BEQ $5, $0, LOOP0_T0;

LOOP1_T0: LL $6, 136($0);
ADDI $6, $6, 1;
ADD $10, $6, $0; COPY OF THE INCREMENTED BARRIER COUNT
SC $6, 136($0);
BEQ $6, $0, LOOP1_T0;

ADDI $7, $0, 16; CHECKING IF COUNT HAS REACHED 16 OR NOT
BNE $10, $7, Sleep_T0;
CACHE 10101, 132($0);
Sleep_T0: J Sleep_T0;


	
;#################################################################
; 							THREAD 1
;#################################################################
;Add your code here
LW $1, 36($0);
LW $2, 100($0);
MULT $3, $2, $1;

LOOP0_T1: LL $5, 132($0);
ADD $5, $5, $3;
SC $5, 132($0);
BEQ $5, $0, LOOP0_T1;

LOOP1_T1: LL $6, 136($0);
ADDI $6, $6, 1;
ADD $10, $6, $0; COPY OF THE INCREMENTED BARRIER COUNT
SC $6, 136($0);
BEQ $6, $0, LOOP1_T1;

ADDI $7, $0, 16; CHECKING IF COUNT HAS REACHED 16 OR NOT
BNE $10, $7, Sleep_T1;
CACHE 10101, 132($0);
Sleep_T1: J Sleep_T1;


;#################################################################
; 							THREAD 2
;#################################################################
;Add your code here
LW $1, 40($0);
LW $2, 104($0);
MULT $3, $2, $1;

LOOP0_T2: LL $5, 132($0);
ADD $5, $5, $3;
SC $5, 132($0);
BEQ $5, $0, LOOP0_T2;

LOOP1_T2: LL $6, 136($0);
ADDI $6, $6, 1;
ADD $10, $6, $0; COPY OF THE INCREMENTED BARRIER COUNT
SC $6, 136($0);
BEQ $6, $0, LOOP1_T2;

ADDI $7, $0, 16; CHECKING IF COUNT HAS REACHED 16 OR NOT
BNE $10, $7, Sleep_T2;
CACHE 10101, 132($0);
Sleep_T2: J Sleep_T2;

;#################################################################
; 							THREAD 3
;#################################################################
;Add your code here
LW $1, 44($0);
LW $2, 108($0);
MULT $3, $2, $1;

LOOP0_T3: LL $5, 132($0);
ADD $5, $5, $3;
SC $5, 132($0);
BEQ $5, $0, LOOP0_T3;

LOOP1_T3: LL $6, 136($0);
ADDI $6, $6, 1;
ADD $10, $6, $0; COPY OF THE INCREMENTED BARRIER COUNT
SC $6, 136($0);
BEQ $6, $0, LOOP1_T3;

ADDI $7, $0, 16; CHECKING IF COUNT HAS REACHED 16 OR NOT
BNE $10, $7, Sleep_T3;
CACHE 10101, 132($0);
Sleep_T3: J Sleep_T3;