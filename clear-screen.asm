// Clear the screen
BasicUpstart2(Start)
#import "C64.inc"

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
