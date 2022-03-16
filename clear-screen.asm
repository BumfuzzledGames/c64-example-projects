// Clear the screen
BasicUpstart2(Start)
#import "C64.inc"

// This program is likely the first time many C64 programmers encountered
// an unrolled loop. An unrolled loop is any loop where the action of the
// loop is performed more than once per iteration. This is often done for
// performance reasons (branch instructions certainly are not free), but
// in this case, it solves a more mundne problem. The C64's screen is
// 40x25 characters and 1,000 bytes in memory. You cannot easily loop
// 1,000 bytes with an 8-bit register. So you either use the X and Y
// registers, or a pair of memory addresses, or you unroll the loop.
// In this case, if we unroll the loop four times, we can use just
// the X register as our counter.

Start:
   lda #' '
   ldx #250
!loop:
   dex
   sta SCREEN_DEFAULT,x
   sta SCREEN_DEFAULT+250,x
   sta SCREEN_DEFAULT+500,x
   sta SCREEN_DEFAULT+750,x
   bne !loop-
   rts
