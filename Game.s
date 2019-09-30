; Based on libSFX examples.
; stahl.jens@gmail.com

.include "libSFX.i"

;VRAM destination addresses
VRAM_MAP_LOC     = $0000
VRAM_TILES_LOC   = $8000

Main:
  ;libSFX calls Main after CPU/PPU registers, memory and interrupt handlers are initialized.

  ;Set color 0
  CGRAM_setcolor_rgb 0, 7,31,31

  ;Decompress Map and upload to VRAM
  LZ4_decompress Map, EXRAM, y
  ; Upload Map to VRAM
  VRAM_memcpy VRAM_MAP_LOC, EXRAM, y
  ; Same for Tiles
  LZ4_decompress Tiles, EXRAM, y
  VRAM_memcpy VRAM_TILES_LOC, EXRAM, y
  ; Set palette
  CGRAM_memcpy 0, Palette, sizeof_Palette

  ;Set up screen mode
  lda     #bgmode(BG_MODE_1, BG3_PRIO_NORMAL, BG_SIZE_8X8, BG_SIZE_8X8, BG_SIZE_8X8, BG_SIZE_8X8)
  sta     BGMODE
  ;BG Character Data Area Designation
  ldx     #bgnba(VRAM_TILES_LOC, 0, 0, 0)
  stx     BG12NBA
  lda     #tm(ON, OFF, OFF, OFF, OFF)
  sta     TM

  ;Turn on screen
  ;The vblank interrupt handler will copy the value in SFX_inidisp to INIDISP ($2100)
  lda     #inidisp(ON, DISP_BRIGHTNESS_MAX)
  sta     SFX_inidisp

  ;Turn on vblank interrupt
  VBL_on

: wai
  bra :-

;Import graphics
.segment "RODATA"
incbin  Palette,        "data/simcity.png.palette"
incbin  Tiles,          "data/simcity.png.tiles.lz4"
incbin  Map,            "data/simcity.png.map.lz4"
