#!/bin/bash
protoc -I lib/proto --dart_out=lib/gencode lib/proto/metrics/v3/*.proto lib/proto/validate/*.proto
protoc -I lib/proto --dart_out=lib/gencode lib/proto/common/v3/*.proto lib/proto/validate/*.proto
protoc -I lib/proto --dart_out=lib/gencode lib/proto/account/v3/*.proto lib/proto/validate/*.proto
protoc -I lib/proto --dart_out=lib/gencode lib/proto/transaction/v3/*.proto lib/proto/validate/*.proto