
To build .proto files:

$> cd ./base_storage
$> protoc --proto_path=proto --dart_out=lib/src/ proto/storage.proto

See:

- https://developers.google.com/protocol-buffers/docs/reference/dart-generated
- https://github.com/google/protobuf.dart/tree/master/protoc_plugin
- https://pub.dev/packages/protobuf
