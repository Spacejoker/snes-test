;Testing stuff based on this tutorial: https://wiki.superfamicom.org/making-a-small-game-tic-tac-toe
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

rep #%00010000  ;16 bit xy
sep #%00100000  ;8 bit ab

; Palette loading (I don't understand this)
; repeat 8 times, lda
ldx #$0000
-: lda UntitledPalette.l, x
sta $2122
inx
cpx #8
; branch unless x is 8
bne -

ldx #UntitledData   ; Address
lda #:UntitledData  ; of UntitledData
ldy #(15*16*2)      ; length of data
stx $4302           ; write
sta $4304           ; address
sty $4305           ; and length
lda #%00000001      ; set this mode (transferring words)
sta $4300
lda #$18            ; $211[89]: VRAM data write
sta $4301           ; set destination

ldy #$0000          ; Write to VRAM from $0000
sty $2116

lda #%00000001      ; start DMA, channel 0
sta $420B

lda #%10000000	; VRAM writing mode
sta $2115
ldx #$4000	    ; write to vram
stx $2116       ; from $4000
; End palette magic

; My nice checker pattern of + signs.
.rept 8
  .rept 16
    ldx #$0006
    stx $2118
    ldx #$0000
    stx $2118
  .endr
  .rept 16
    ldx #$0000
    stx $2118
    ldx #$0006
    stx $2118
  .endr
.endr

;set up the screen & modes
lda #%00110000  ; 16x16 tiles, mode 0
sta $2105       ; screen mode register
lda #%01000000  ; data starts from $4000
sta $2107       ; for BG1
lda #%01100000  ; and $6000
sta $2108       ; for BG2

stz $210B	    ; BG1 and BG2 use the $0000 tiles

lda #%00000001  ; enable bg1 only (not bg2)
sta $212C

lda #%00001111  ; enable screen, set brightness to 15
sta $2100

lda #%10000001  ; enable NMI and joypads
sta $4200

; Game loop
forever:
wai
jmp forever

;--------------------------------------

.ends

; Static content
.bank 1 slot 0
.org 0
.section "Tiledata"
.include "tiles.inc"
.ends
