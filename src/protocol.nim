# McWire
# MIT License
# Copyright (c) 2026 CodCatDev
# https://github.com/CodCatDev/McWire

type
    McProtocolError* = object of CatchableError
    
    PacketReader* = object
        data*: seq[byte]
        pos*: int

proc initPacketReader*(data: seq[byte]): PacketReader =
    result.data = data
    result.pos = 0

proc readByte*(reader: var PacketReader): byte =
    if reader.pos >= reader.data.len:
        raise newException(McProtocolError, "Unexpected end of packet data")
    result = reader.data[reader.pos]
    inc reader.pos

proc readVarInt*(reader: var PacketReader): int32 =
    result = 0
    var numRead = 0
    while true:
        let b = reader.readByte()
        result = result or (int32(b and 0x7F) shl (7 * numRead))
        inc numRead
        if numRead > 5:
            raise newException(McProtocolError, "VarInt is too big")
        if (b and 0x80) == 0:
            break

proc readUShort*(reader: var PacketReader): uint16 =
    let b1 = reader.readByte()
    let b2 = reader.readByte()
    result = (uint16(b1) shl 8) or uint16(b2)

proc readLong*(reader: var PacketReader): int64 =
    var res: int64 = 0
    for i in 0 ..< 8:
        res = (res shl 8) or int64(reader.readByte())
    result = res

proc readString*(reader: var PacketReader): string =
    let length = reader.readVarInt()
    if length < 0 or int(length) > reader.data.len - reader.pos:
        raise newException(McProtocolError, "Invalid string length")
    
    var bytes = newSeq[byte](length)
    for i in 0 ..< length:
        bytes[i] = reader.readByte()
    result = cast[string](bytes)