// Display hello world on the screen
BasicUpstart2(Start)

// This program prints HELLO WORLD to the screen by writing 
// directly to screen RAM. Note the .encoding assembler directive.
// The C64 deals with strings in BASIC and the kernal in ASCII,
// but the screen uses a different character set. You need to write
// screen characters in order to write to the screen, and you can
// either obtain those by converting ASCII, or ask the assembler to
// encode the string using screen characters.

.encoding "screencode_upper"
str_hello:
  .text "HELLO, WORLD!"
  .byte 0

Start:
  ldx #0
!loop:
  lda str_hello,x
  beq !end+
  sta SCREEN_DEFAULT,x
  inx
  jmp !loop-
!end:
  jmp *
  
