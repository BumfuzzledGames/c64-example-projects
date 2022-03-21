// Store program in c000 RAM
*=$c000
#import "C64.inc"

// This program demonstrates how a program can be loaded into
// RAM at C000, a 4k area of RAM nestled between ROMs intended
// for small assembly language routines. There is no BASIC loader so
// to run this program, issue the command SYS49152.
//
// This is an excellent way to load assembly programs that do not
// interfere with BASIC. You can load BASIC wedges or interrupt
// routines and they won't be overwritten by BASIC.

   ldx #0
!: lda msg,x
   beq !+
   jsr KERNAL_CHROUT
   inx
   jmp !-
!: rts

msg:
   .text "HELLO, WORLD!"
   .byte 0
