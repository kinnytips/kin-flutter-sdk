#!/bin/bash
protoc -I lib/models/protodefs --dart_out=grpc:lib/models/gen  lib/models/protodefs/metrics/v3/*.proto lib/models/protodefs/validate/*.proto
protoc -I lib/models/protodefs --dart_out=grpc:lib/models/gen  lib/models/protodefs/common/v3/*.proto lib/models/protodefs/validate/*.proto
protoc -I lib/models/protodefs --dart_out=grpc:lib/models/gen  lib/models/protodefs/account/v3/*.proto lib/models/protodefs/validate/*.proto
protoc -I lib/models/protodefs --dart_out=grpc:lib/models/gen  lib/models/protodefs/transaction/v3/*.proto lib/models/protodefs/validate/*.proto