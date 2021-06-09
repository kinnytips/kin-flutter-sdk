#!/bin/bash

## Proto Sources:
## git clone https://github.com/kinecosystem/agora-api.git

## The output directory
GEN_OUT="/tmp/kin-dart-protobuf"

## If you need to activate Dart protoc_plugin:
# dart pub global activate protoc_plugin 19.3.1

protoc --dart_out=grpc:$GEN_OUT -Iproto proto/transaction/v4/transaction_service.proto proto/transaction/v3/transaction_service.proto proto/account/v4/account_service.proto proto/account/v3/account_service.proto proto/common/v4/model.proto proto/common/v3/model.proto proto/metrics/v3/ingestion_service.proto proto/metrics/v3/model.proto proto/airdrop/v4/airdrop_service.proto proto/validate/validate.proto
protoc --dart_out=grpc:$GEN_OUT -Iproto proto/validate/duration.proto
protoc --dart_out=grpc:$GEN_OUT -Iproto proto/validate/timestamp.proto
