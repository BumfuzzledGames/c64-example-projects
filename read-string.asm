// Read a string from the keyboard
BasicUpstart2(Start)
#import "C64.inc"

// This program uses the kernal GETIN routine to read a string of
// characters from the keyboard. It's intended to be as flexible
// as possible and makes heavy use of self-modifying code. Since
// passing and reading parameters can be difficult or cumbersome
// on the 6502, it's often more convenient to modify instructions
// directly in the routine itself. You'll notice that for a relatively
// short routine (about 45 instructions) there are a shocking amount
// of parameters. All of these parameters modify an instruction in
// the routine itself and are "free."
//
// Another trick shown here is a quick debugging string of using
// the screen as a buffer. Even though the characters in the buffer
// are gibberish when displayed on the screen, you can still see that
// they are being stored in the buffer correctly. This saves you from
// having to jump into a debugger unless you need to.

Start: {
   lda #<1024
   sta ReadString._buffer
   lda #>1024
   sta ReadString._buffer+1
   lda #5
   sta ReadString._buffer_len
   jsr ReadString
   rts
}


// ReadString  Reads a string from the keyboard or other source
// Parameters
//  _idx: Initial index into the buffer. This should be set to 0 when reading
//    a new string, but can be set to any value. This is useful when a string
//    was read with this routine, but rejected by the application and the user
//    should continue editing it.
//  _buffer (required): The address that the routine should store the string
//    read. It should have enough space for the desired string plus a nul byte.
//  _buffer_len (required): Length of _buffer NOT INCLUDING the nul byte.
//  _getin: Address of routine to get a character. This is KERNAL_GETIN by
//    default, but this could be set to any routine that returns a character
//    in A, or 0 in A if no character was read.
//  _chrout: Address of routine to print a character to the screen. This is
//    set to KERNAL_CHROUT by default, but it could be set to any routine that
//    is required. In a game you might redraw the game screen with the routine,
//    for example. This routine must preserve A and X.
//  _check_mode: Must be one of
//    check_mode_check: Input characters must be present in _check_string
//    check_mode_no_check: Any input characters are accepted
//  _check_string: Address of string used by _check_mode_check
//  _check_string_len: Length of check string
//  _full_buffer_mode: Must be one of
//    full_buffer_mode_yes: Only full buffer is accepted
//    full_buffer_mode_no: Buffer of any length is accepted
//  _echo_mode: Must be one of
//    echo_mode_read_char: The character read is echoed using _chrout
//    echo_mode_fixed_char: _echo_char is echoed for every character read
//  _echo_char: The character to echo when echo_mode_fixed_char is used.
//    Defaults to '*'
// Returns X=number of bytes read, including nul
// Mangles A,X,Y
ReadString: {
   ldx _idx:#0                  //see _idx parameter
loop:
   stx tmp                      //preserve x, no PHX instruction on C64
!: jsr _getin:KERNAL_GETIN      //see _getin parameter
   beq !-
	ldx tmp                      //restore x
   //check for return
   cmp #$0d
   bne !+
   jmp _full_buffer_mode:full_buffer_mode_yes
full_buffer_mode_yes:           //see _full_buffer_mode parameter
	cpx _buffer_len              //see _buffer_len parameter
   bne loop                     //buffer not full, but wanted full
full_buffer_mode_no: 
   lda #0                       //force store a nul
   jmp force_store              //also returns from ReadString
   //check for delete
!: cmp #$14
	bne !+
   cpx #0                       //do nothing if at beginning of buffer
   beq loop
   jsr echo_mode_read_char      //force read_char echo mode for delete
   dex                          //move tail back
   lda #0                       //store nul
   jsr store
   dex                          //store moves tail, move it back again
   jmp loop
   //check for return and delete complete
!: cpx _buffer_len
   beq loop                     //no space to store
   jmp _check_mode:check_mode_check
check_mode_check:
   ldy _check_string_len:#26    //idx into check string
!: dey
   bmi loop                     //end of check string, invalid input char
   cmp _check_string:alpha,y
   beq check_ok
   jmp !-
check_mode_no_check:
check_ok:
   jsr store
   jsr _echo_mode:echo_mode_read_char
   jmp loop
store:
   cpx _buffer_len:#$ff         //end of buffer
   beq !+
force_store:
   sta _buffer:$ffff,x          //store character
   inx                          //move tail
!: rts
echo:
echo_mode_fixed_char:
   lda _echo_char:#'*'
echo_mode_read_char:
   jsr _chrout:KERNAL_CHROUT
   rts
alpha:                          //for check strings
   .encoding "ascii"
   .text "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
num:
   .text "0123456789"
tmp:
   .byte 0
}
