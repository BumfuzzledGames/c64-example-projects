// Display hello world on the screen
BasicUpstart2(Start)

.encoding "screencode_upper"
str_hello:
  .text "HELLO, WORLD!"
  .byte 0

Start:
  ldx #0
!loop:
  lda str_hello,x
  beq !end+
  sta 1024,x
  inx
  jmp !loop-
!end:
  jmp *
  
