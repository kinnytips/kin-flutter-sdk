#!/bin/bash
export SRC_DIR=./lib/models/proto

echo "Generating models for v3"
protoc -I $SRC_DIR --dart_out=grpc:lib/models/agora/protobuf  $SRC_DIR/metrics/v3/*.proto $SRC_DIR/validate/validate.proto

echo "Generating models for v4"
protoc -I $SRC_DIR  --dart_out=grpc:lib/models/agora/protobuf  $SRC_DIR/account/v4/*.proto $SRC_DIR/validate/validate.proto
protoc -I $SRC_DIR  --dart_out=grpc:lib/models/agora/protobuf  $SRC_DIR/common/v4/*.proto $SRC_DIR/validate/validate.proto
protoc -I $SRC_DIR  --dart_out=grpc:lib/models/agora/protobuf  $SRC_DIR/airdrop/v4/*.proto $SRC_DIR/validate/validate.proto
protoc -I $SRC_DIR  --dart_out=grpc:lib/models/agora/protobuf  $SRC_DIR/transaction/v4/*.proto $SRC_DIR/validate/validate.proto

echo "Generating Google protos"
protoc -I $SRC_DIR --dart_out=grpc:lib/models/agora/protobuf/google/protobuf  $SRC_DIR/duration.proto
protoc -I $SRC_DIR --dart_out=grpc:lib/models/agora/protobuf/google/protobuf  $SRC_DIR/timestamp.proto

echo "Model generating is complete"