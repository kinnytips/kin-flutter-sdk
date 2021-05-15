import 'dart:convert';
import 'dart:typed_data';

import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/stellar/models/paging_token.dart';
import 'package:kin_base/models/agora/protobuf/common/v4/model.pb.dart';
import 'package:kin_base/models/agora/protobuf/transaction/v4/transaction_service.pbgrpc.dart';

extension KinAccountIdToProto on KinAccountId {
  SolanaAccountId toProtoSolanaAccountId() =>
      SolanaAccountId.create()..value = Uint8List.fromList(this.value);
}

extension PagingTokenToProtoV4 on PagingToken {
  Cursor toProtoCursor() => toProtoCursorV4();

  Cursor toProtoCursorV4() {
    var cursor = Cursor.create();
    if (this.value.isNotEmpty) {
      cursor.value = base64.decode(this.value);
    }
    return cursor;
  }
}
