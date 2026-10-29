# McWire
# MIT License
# Copyright (c) 2026 CodCatDev
# https://github.com/CodCatDev/McWire

import ../src/mcwire

let fakeData = @[
  0x00'u8, # ID
  0xFB'u8, 0x05'u8, # Version (763)
  0x09'u8, # Length (9)
  0x6C'u8, 0x6F'u8, 0x63'u8, 0x61'u8, 0x6C'u8, 0x68'u8, 0x6F'u8, 0x73'u8, 0x74'u8, # "localhost"
  0x63'u8, 0xDD'u8, # Port (25565)
  0x01'u8 # Next State (1 = Status)
]

var reader = initPacketReader(fakeData)
let packet = parsePacket(reader, HandshakeState)

if packet of Handshake:
  let hs = Handshake(packet)
  echo "Done! Version: ", hs.protocolVersion
  echo "Address: ", hs.serverAddress
  echo "Port: ", hs.serverPort