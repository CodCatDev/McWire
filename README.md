<div align="center">
    <h1>McWire</h1>
    <p>v0.0.2 | b2</p>
</div>

## About
McWire is a Minecraft Java Server packet decoder/encoder for Nim.

McWire can be used to decode and encode packets from/to Minecraft servers, with very useful features.

## Usage

Decode a Handshake
```nim
import mcwire

# Raw bytes received from the client (e.g., from a socket)
# In this example, it's a Handshake with protocol version 763, address "localhost", port 25565, and nextState = 1 (Status)
let rawData = @[
  0x00'u8, # Packet ID (Handshake)
  0xFB'u8, 0x05'u8, # VarInt protocol version (763)
  0x09'u8, # String length (9 characters)
  0x6C'u8, 0x6F'u8, 0x63'u8, 0x61'u8, 0x6C'u8, 0x68'u8, 0x6F'u8, 0x73'u8, 0x74'u8, # "localhost"
  0x63'u8, 0xDD'u8, # Port (25565)
  0x01'u8 # Next State (1 = Status)
]

# 1. Initialize the reader
var reader = initPacketReader(rawData)

# 2. Parse the packet, specifying the current client state
let packet = parsePacket(reader, HandshakeState)

# 3. Check the type and use the data
if packet of Handshake:
  let hs = Handshake(packet)
  echo "Client Version: ", hs.protocolVersion
  echo "Server Address: ", hs.serverAddress
  echo "Port: ", hs.serverPort
  echo "Next State: ", hs.nextState
```

## Installing

Requires:
- [Nim](https://nim-lang.org/) >= 2.2.10

Nimble is not supported for download, sorry. But you can install it by GIT

```bash
git clone https://github.com/CodCatDev/McWire.git
cd McWire
```

move mcwire to your project and use!