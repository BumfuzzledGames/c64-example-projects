// disable BASIC and kernal roms
BasicUpstart2(Start)
#import "C64.inc"

// To access all of the C64's RAM, you must remove the BASIC
// and kernal ROMs from the address space. This is done very
// easily by writing to the address $01, a special address on
// the C64's 6510 variant of the 6502 that acts as an IO port.
// Note that you can always write to the RAM underneath the
// BASIC and kernal ROMs, any writes to those addresses always
// go to RAM, so if your PRG overlaps the BASIC ROM it can be
// loaded from BASIC then the ROM turned off in the program.

Start: {
   sei                          //disable interrupts
   lda $1                       //get the current value of $01
   and #%11111100               //mask out 2 lowest bits
   sta $1                       //write back to $01
   cli                          //re-enable interrupts

!loop:
   jsr KERNAL_GETIN
   beq !loop-

   sei                          //reverse process to re-enable
   lda $1
   ora #%00000011
   sta $1
   cli

   rts
}       
