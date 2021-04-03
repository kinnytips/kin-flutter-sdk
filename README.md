# Kin Flutter SDK (Unofficial)
[![Kin flutter SDK CI](https://github.com/kinnytips/kin-flutter-sdk/actions/workflows/dart.yml/badge.svg)](https://github.com/kinnytips/kin-flutter-sdk/actions/workflows/dart.yml)

Flutter Package for using [Kin Cryptocurrency](https://www.kin.org/). Based on the [Kin Android SDK](https://github.com/kinecosystem/kin-android).

Library&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Path                                                                                   | Description&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                                                                                                                                                                                                                             |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------|
| `base`                                                                                                                   | [`/base`](/lib/base)| The foundation library used by all other libraries in the system to support basic Kin operations: <ul><li>Wallet creation and management</li><li>Send and receive Kin</li><li>Metrics interfaces</li></ul>                                                                                |
| `base-compat`                                                                                                             | [`/base-compat`](/lib/base-compat)                                                                                                | The [:base-compat](base-compat) library implements the public surface layer to be a drop in replacement of the, now deprecated, [kin-sdk-android](https://github.com/kinecosystem/kin-sdk-android) library. Just update your version in gradle and have better performance and stability.                                                                                                       

## Installation

### From pub.dev
1. Add the dependency to your pubspec.yaml file:
```
dependencies:
  kin_sdk: x.x.x
```
2. Install it (command line or IDE):
```
flutter pub get
```
3. In your source file import the SDK, initialize and use it:
```dart
import 'package:kinny.io/kin_sdk.dart';
```

## Documentation
[API](https://docs.kin.org/agora/api) <br/>
[TECHNICAL ARCHITECTURE](https://docs.kin.org/how-it-works#kin-binary-memo-format)<br/>
[KIN MEMO FORMAT](https://github.com/kinecosystem/agora-api/blob/master/spec/memo.md)

## How to use the SDK
### Initiate the sdk

```
 KinSdk sdk = KinSdk("GDHCB4VCNNFIMZI3BVHLA2FVASECBR2ZXHOAXEBBFVUH5G2YAD7V3JVH");
```
Now, this instance can be used to perform all the operations on the `kin` blockchain.

### Creating a new account
```
var response = await sdk.createAccount;
```

### Adding an existing account
```
var response = await sdk.addAccount;
```

### Fetching account info
```
var response = await sdk.getAccountInfo;
```

### Fetching account info
```
var response = await sdk.getAccountInfo;
```

### Fetching account history
```
var response = await sdk.getAccountHistory;
```

### Fetching account transactions
```
var response = await sdk.getTransaction(String transactionId);
```
