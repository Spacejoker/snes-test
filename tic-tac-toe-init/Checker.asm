;============================================================================
; DrawCheckerPattern - Draws checker pattern on screen
;
; $2118 is VRAM Data write, which is incremented on each write (depending on the value in $4301).
;----------------------------------------------------------------------------
; In: SPRITE -- Sprite thing to draw, for example #0005
;----------------------------------------------------------------------------
; Out: None
;----------------------------------------------------------------------------
; Modifies: X,Y
; Requires: ?
;----------------------------------------------------------------------------

.MACRO DrawCheckerPattern
  ldx #\1
  ldy #$0000
  .rept 8
    .rept 16
      stx $2118
      sty $2118
    .endr
    .rept 16
      sty $2118
      stx $2118
    .endr
  .endr
.ENDM

