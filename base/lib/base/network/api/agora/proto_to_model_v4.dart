

import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_balance.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/sha_224_hash.dart';
import 'package:kin_base/models/agora/protobuf/account/v4/account_service.pb.dart';
import 'package:kin_base/models/agora/protobuf/common/v3/model.pb.dart' as models ;

extension AccountInfoExtension on AccountInfo {

  KinAccount toKinAccount() {
    var key = PublicKey.fromBytes( this.accountId.value );
    var amount = QuarkAmount(this.balance.toInt()).toKin() ;
    var balance = KinBalance(amount);
    var kinAccount = KinAccount(key, balance: balance, status:  KinAccountStatusRegistered(0) );
    return kinAccount;
  }

}

extension ModelsInvoiceListExtension on models.InvoiceList {
  InvoiceList toInvoiceList() {
    return InvoiceList(
        InvoiceListId( this.sha224Hash() ) ,
        this.invoices.map((e) => e.toInvoice() )
    );
  }

  SHA224Hash sha224Hash() => SHA224Hash.fromBytes(this.writeToBuffer()) ;
}

extension ModelsInvoiceExtension on models.Invoice {
  Invoice toInvoice() {
    return Invoice(InvoiceId(sha224Hash()), this.items.map((e) => e.toLineItem()) );
  }

  SHA224Hash sha224Hash() => SHA224Hash.fromBytes( this.writeToBuffer() );
}


extension ModelsInvoiceLineItemExtension on models.Invoice_LineItem {

  LineItem toLineItem() {
    return LineItem(
        this.title,
        this.description,
        QuarkAmount(this.amount.toInt()).toKin(),
        sku.isEmpty ? null : SKU(this.sku)
    );
  }

}

