<div align="center">
    <h1>McWire</h1>
    <p>v0.0.2 | b5</p>
    <a href="https://hub.xerj.org/contributors/CodCatDev"><img src="https://hub.xerj.org/contributors/CodCatDev/badge.svg" alt="XERJ Corpus Hub contributor"></a>
    <a href="https://github.com/CodCatDev/McWire/stargazers">
    <img alt="Stargazers" src="https://img.shields.io/github/stars/CodCatDev/McWire?style=for-the-badge&logo=github&color=f4dbd6&logoColor=D9E0EE&labelColor=302D41"></a>
    <a href="#">
    <img alt="Sans-I/O" src="https://img.shields.io/badge/Architecture-Sans--I%2FO-blue?style=for-the-badge&logo=codeforces&color=f5bde6&logoColor=D9E0EE&labelColor=302D41"/></a>
    <a href="https://nim-lang.org">
    <img alt="Nim" src="https://img.shields.io/badge/Nim-%3E%3D%202.2.10-yellow?style=for-the-badge&logo=nim&color=f5bde6&logoColor=D9E0EE&labelColor=302D41"/></a>
    <a href="https://github.com/CodCatDev/McWire/releases/latest">
    <img alt="Releases" src="https://img.shields.io/github/release/CodCatDev/McWire.svg?style=for-the-badge&logo=semantic-release&color=f5bde6&logoColor=D9E0EE&labelColor=302D41"/></a>
</div>

## About
McWire is a lightweight Minecraft Java Server packet decoder/encoder written in Nim. 

Designed with a **Sans-I/O** approach, it can be used to decode and encode packets from/to Minecraft clients and servers without being tied to any specific networking library. It provides a robust foundation for building custom servers, proxies, or bots, giving you full control over how data is transported.

## Usage

Decode a Handshake
```nim
import mcwire

# Maybe the data from socket
let rawData = @[...]

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

## Contributing
Thanks all contributors for your help!

<a href="https://github.com/codcatdev/mcwire/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=codcatdev/mcwire&max=50&columns=4&anon=1" />
</a>

If you want to contribute, read our [Contributing Guide](CONTRIBUTING.md)

## RoadMap to v1.0.0 (Russian)

P.s: В хедере где версия, bX это билд, например щас билд b4, если вы делаете pullrequest добавляете +1 к номеру билда

### 1. Фундамент
- [ ] Чтение `VarInt` и `VarLong`
- [ ] Чтение базовых типов (Big-Endian `UShort`, `Long`, `Double`, `UUID`)
- [ ] Чтение `String` (с проверкой длины UTF-8)
- [ ] Реализация `PacketWriter` для сборки (энкодинга) исходящих пакетов
- [ ] Защита от переполнения буфера (Buffer Overflow) и битых пакетов

### 2. Архитектура
- [ ] Базовый тип `Packet` и фабрика `parsePacket`
- [ ] Наследование и методы `read` для каждого пакета
- [ ] Валидация ID пакетов в зависимости от состояния (State Machine)

### 3. Общение
- [ ] Обработка `Handshake` (чтение версии, адреса и порта)
- [ ] Обработка `Status Request` и `Ping`
- [ ] Энкодинг `Status Response` (сборка JSON с MOTD и онлайном)
- [ ] Энкодинг `Pong` (ответ на проверку задержки)

### 4. Логин и игра
- [ ] Пакеты `Login Start`, `Encryption Request/Response`
- [ ] Пакеты `Play` (KeepAlive, Chat, Player Position)
- [ ] Парсинг NBT (Named Binary Tag) для передачи сложных данных

### 5. Утилиты0
- [ ] `mcwire.utils.pingServer` (возвращает пинг и данные сервера)
- [ ] `mcwire.utils.getMotd` (быстрое получение MOTD и иконки)
- [ ] `mcwire.utils.packetDump` (вывод сырых байтов пакета для дебага)

### 6. Полировка
- [ ] Поддержка нескольких версий (через маппинг пакетов)
- [ ] Написание Unit-тестов для всех ключевых функций
- [ ] Стабильный релиз
