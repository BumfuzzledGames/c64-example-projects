// Print hello world using the kernal
BasicUpstart2(Start)
#import "C64.inc"

str_hello:
   .text "HELLO, WORLD!"
   .byte 0

Start: {
   ldx #0
!loop:
   lda str_hello,x
   beq !done+
   jsr KERNAL_CHROUT
   inx
   jmp !loop-
!done:
   rts
}
