# McWire
# MIT License
# Copyright (c) 2026 CodCatDev
# https://github.com/CodCatDev/McWire

version = "0.0.2"
author = "CodCatDev"
description = "McWire - Fast and lightweight Minecraft packet decoder/encoder written in Nim"
license = "MIT"

let name: string = "mcwire"

srcDir = "src"
binDir = "build"
bin = @["mcwire"]
backend = "c"

requires "nim >= 2.2.10"

task release, "Build McWire in release mode":
    exec "nimble build -d:release -d:danger --opt:speed --mm:arc --passL:-s"
    exec "./build/mcwire"

task dev, "Build McWire in dev (debug) mode":
    exec "nimble build -d:debug --debugger:native --stacktrace:on --linetrace:on"
    exec "./build/mcwire"

task test, "Run tests":
    exec "nim c -r tests/handshake.nim"