import 'dart:math';
import 'dart:typed_data';

class ByteInputBuffer {
  final Uint8List _bytes;

  final int _offset;

  final int _end;

  int _position = 0;

  ByteInputBuffer(this._bytes, [int offset, int length])
      : this._offset = (offset ?? 0),
        this._end = (offset ?? 0) + (length ?? _bytes.length) {
    if (_offset < 0 || _offset >= _bytes.length) throw ArgumentError('Invalid offset: $_offset');
    if (_end < 0 || _end > _bytes.length) throw ArgumentError('Invalid length: $length / ${_bytes.length}');
  }

  int get length => _end - _offset;

  int get remaining => length - _position;

  int get position => _position;

  int read() {
    if (_position >= length) throw ByteInputBufferException('EOF: ');
    var p = _offset + (_position++);
    var b = _bytes[p];
    return b;
  }

  Uint8List readBytes(int length) {
    var bytes = Uint8List(length);
    readTo(bytes, 0, length);
    return bytes ;
  }

  void seek(int position) {
    if (position < 0 || position > length)
      throw ArgumentError("Invalid position: $position / $length");
    _position = position;
  }

  void readTo(Uint8List dest, int offset, int length) {
    for (var i = 0; i < length; ++i) {
      var b = read() ;
      dest[offset+i] = b ;
    }
  }

  Uint8List readRemainingBytes() {
    var remaining = this.remaining ;
    var bytes = Uint8List(remaining);
    readTo(bytes, 0, remaining);
    return bytes;
  }
}

class ByteOutputBuffer {
  Uint8List _bytes;

  int _length = 0;

  int _position = 0;

  ByteOutputBuffer(int capacity) : _bytes = Uint8List(max(capacity, 8));

  int get length => _length;

  int get position => _position;

  void write(int b) {
    var p = _position++;
    ensureCapacity(_position);
    _bytes[p] = b;
    if (_position > _length) _length = _position;
  }

  void writeBytes(ByteData data) {
    ensureCapacity(_position+data.lengthInBytes);

    for (var i = 0; i < data.lengthInBytes; ++i) {
      var b = data.getUint8(i);
      _bytes[_position++] = b;
    }

    if (_position > _length) _length = _position;
  }

  void writeAll(List<int> bs) {
    ensureCapacity(_position+bs.length);
    for (var b in bs) {
      _bytes[_position++] = b;
    }

    if (_position > _length) _length = _position;
  }

  void ensureCapacity(int desiredLength) {
    if (_bytes.length < desiredLength) {
      var capacity2 = max(desiredLength, _bytes.length * 2);
      var bytes2 = Uint8List(capacity2);
      bytes2.setRange(0, _bytes.length, _bytes);
      _bytes = bytes2;
    }
  }

  void seek(int position) {
    if (position < 0 || position > length)
      throw ArgumentError("Invalid position: $position / $length");
    _position = position;
  }

  Uint8List toBytes() {
    var bytes2 = Uint8List(_length);
    bytes2.setRange(0, _length, _bytes);
    return bytes2;
  }
}

class ByteInputBufferException implements Exception {
  String message;

  ByteInputBufferException(this.message);

  @override
  String toString() {
    return '[ByteInputBufferException] $message';
  }
}
