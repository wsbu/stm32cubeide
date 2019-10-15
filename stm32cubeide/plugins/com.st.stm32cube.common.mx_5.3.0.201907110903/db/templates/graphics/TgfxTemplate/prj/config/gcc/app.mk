###############################################################################
# This file is part of the ST-TouchGFX 4.9.3 distribution.
# Copyright (C) 2017 Draupner Graphics A/S <http://www.touchgfx.com>.
###############################################################################
# This is licensed software. Any use hereof is restricted by and subject to the
# applicable license terms. For further information see "About/Legal Notice"
# in ST-TouchGFX Designer or in your ST-TouchGFX installation directory.
###############################################################################
# Relative location of the TouchGFX framework from root of application
touchgfx_path := ../../../touchgfx

# Optional additional compiler flags
user_cflags := -DUSE_BPP=16

# Settings for image converter output format
alpha_dither := yes
# Dither algorithms: 0 (no dither), 1 (Floyd-Steinberg), 2 (Jarvis, Judice and Ninke), 3 (Stucki)
dither_algorithm := 2
opaque_image_format := RGB565
non_opaque_image_format := ARGB8888

# Settings for image converter screen orientation (empty string =
# default value, -rotate90 rotates the image 90 degrees)
screen_orientation :=

# Settings for Hardware accelerated text rendering on STM32F4 and F7
# devices. Must correspond to value of bitsPerPixel for font to have
# any effect. If A4 blitcap is enabled for target specific HAL the
# fontconverter must generate compliant data format, otherwise
# resulting in a DMA Controller Configuration Error.
text_data_format := A4

# Setting for the textconverter. Identical texts across all languages
# are mapped to the same memory region to save internal flash memory
remap_identical_texts := yes
