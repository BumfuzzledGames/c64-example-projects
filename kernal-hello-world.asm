// Print hello world using the kernal
BasicUpstart2(Start)
#import "C64.inc"

// This program uses a kernal routine to print HELLO WORLD
// to the screen. The string is encoded in ASCII, but the C64's
// screen RAM needs the C64 screen character set. The kernal
// routine CHROUT handles this conversion for you.

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
