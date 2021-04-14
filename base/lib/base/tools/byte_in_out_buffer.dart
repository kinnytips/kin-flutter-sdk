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
  }

  void writeAll(List<int> bs) {
    ensureCapacity(_position+bs.length);
    for (var b in bs) {
      _bytes[_position++] = b;
    }
  }

  void ensureCapacity(int desiredLength) {
    if (_bytes.length < desiredLength) {
      var capacity2 = max(desiredLength, _bytes.length * 2);
      var bytes2 = Uint8List(capacity2);
      bytes2.addAll(_bytes);
      _bytes = bytes2;
    }
  }

  void seek(int position) {
    if (position < 0 || position > length)
      throw ArgumentError("Invalid position: $position / $length");
    _position = position;
  }

  Uint8List toBytes() {
    var bytes2 = Uint8List(_bytes.length);
    bytes2.addAll(_bytes);
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
