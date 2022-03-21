// Scan the keyboard part 1
BasicUpstart2(Start)
#import "C64.inc"

// This is the first in a series of programs that shows how to
// scan the keyboard without using the kernal ROM. The objective
// of this program is to look for a single key: the INST/DEL key.

// Why might you want to scan the keyboard manually?
//  * You've unmapped the kernal ROM. You could map it back in,
//    jump to GETCH and map it back out, but this is inflexible.
//    The GETCH kernal routine reads from the keyboard, but also
//    from files, and does ASCII conversion for you. If all you
//    want is the scancode of keys that are pressed, this is a
//    lot of work that just won't need to be done.
//  * You need to check for a button press quickly. Even if you
//    don't convert input to ASCII, scanning the whole keyboard
//    throws cycles away. If you just want to check for F7 in
//    in a very tight loop, for example, you can do that in a few
//    instructions, without even having to call a subroutine.
//  * Detecting more keypresses. The GETCH routine fails in any
//    number of situations where multiple keys are being pressed.
//    While it's definitely not demonstrated here, there are ways
//    of detecting more key combinations than you normally would
//    be able to.
//
// One interesting thing to note is that the keyboard is still
// being scanned by... something. Keys are being put into the
// key buffer, even if I disable interrupts. I'm not quite sure
// what's going on there, yet.
   
Start:
   jsr ScanForInstDel
   rts

ScanForInstDel: {
   lda #$fe
!: sta $dc00
   ldx $dc01
   cpx #$fe
   bne !-
   rts
}
   
