 ; SNES Initialization Tutorial code
 ; This code is in the public domain.
 
 .include "Header.inc"
 .include "Snes_Init.asm"
 
 ; Needed to satisfy interrupt definition in "Header.inc".
 VBlank:
   RTI
 
 .bank 0
 .section "MainCode"
 
; Start label is required by header
 Start:
     Snes_Init
 
     ; Set the background color to green.
     sep     #$20        ; Set the A register to 8-bit.
     lda     #%10000000  ; Force VBlank by turning off the screen.
     ; $2100 Screen Display Register, eight bit forces VBlank.
     sta     $2100
     ; Color format is 0BBBBBGG|GGGRRRRR, one byte at a time (low first)
     lda     #$15  ; Load the low byte of the color.
     ; $2122 is the Color Data Register.
     sta     $2122
     lda     #$00  ; Load the high byte of the color.
     sta     $2122
     ; Same register as before, but set brightness to 15 (100%).
     lda     #%00001111
     sta     $2100
 
 Loop:
     jmp Loop
 
 .ends
