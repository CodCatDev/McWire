# ==============================================================================
# McWire: Fast and lightweight Minecraft packet decoder/encoder for Nim.
# ------------------------------------------------------------------------------
# Copyright (c) 2026 CodCatDev and Contributors
# Licensed under the MIT License. See LICENSE and CONTRIBUTORS.md for details.
# URL: https://github.com/CodCatDev/McWire
# ==============================================================================

type
    McWireError* = object of CatchableError

    PacketReader* = object
        data*: seq[byte]
        pos*: int

