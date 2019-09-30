# Name
name		:= Game
debug		:= 0

# Use packages
libsfx_packages := LZ4

derived_files	:= data/simcity.png.palette data/simcity.png.tiles data/simcity.png.map
derived_files	+= data/simcity.png.tiles.lz4 data/simcity.png.map.lz4

# Include libSFX.make
# Git repo: https://github.com/Optiroc/libSFX
libsfx_dir	:= ../libSFX
include $(libsfx_dir)/libSFX.make
