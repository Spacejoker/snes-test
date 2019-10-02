.include "header.inc"
.include "InitSNES.asm"

.bank 0 slot 0
.org 0
.section "Vblank"
;--------------------------------------
VBlank:
rti
;--------------------------------------
.ends


.bank 0 slot 0
.org 0
.section "Main"
;--------------------------------------
Start:
  InitSNES
sep #$30        ; get 8-bit registers
stz $2121       ; write to CGRAM from $0
lda #%11101111  ; this is
ldx #%00111111  ; a green color
sta $2122       ; write it
stx $2122       ; to CGRAM
lda #%00001111  ; turn on screen
sta $2100       ; here

forever:
wai
jmp forever
;--------------------------------------
.ends
