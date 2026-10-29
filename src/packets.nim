# McWire
# MIT License
# Copyright (c) 2026 CodCatDev
# https://github.com/CodCatDev/McWire

import protocol

type
  Packet* = ref object of RootObj
    id*: int32

  ClientState* = enum
    HandshakeState, StatusState, LoginState, PlayState

  Handshake* = ref object of Packet
    protocolVersion*: int32
    serverAddress*: string
    serverPort*: uint16
    nextState*: int32

  StatusRequest* = ref object of Packet
  
  Ping* = ref object of Packet
    payload*: int64

method read*(p: Packet, reader: var PacketReader) {.base.} =
  raise newException(McProtocolError, "Read method not implemented")

method read*(p: Handshake, reader: var PacketReader) =
  p.protocolVersion = reader.readVarInt()
  p.serverAddress = reader.readString()
  p.serverPort = reader.readUShort()
  p.nextState = reader.readVarInt()

method read*(p: StatusRequest, reader: var PacketReader) =
  discard

method read*(p: Ping, reader: var PacketReader) =
  p.payload = reader.readLong()

proc parsePacket*(reader: var PacketReader, state: ClientState): Packet =
  let packetId = reader.readVarInt()
  
  case state
  of HandshakeState:
    if packetId == 0x00:
      result = Handshake(id: packetId)
      result.read(reader)
    else:
      raise newException(McProtocolError, "Unknown Handshake packet: " & $packetId)
      
  of StatusState:
    if packetId == 0x00:
      result = StatusRequest(id: packetId)
      result.read(reader)
    elif packetId == 0x01:
      result = Ping(id: packetId)
      result.read(reader)
    else:
      raise newException(McProtocolError, "Unknown Status packet: " & $packetId)
      
  else:
    raise newException(McProtocolError, "State not implemented yet")