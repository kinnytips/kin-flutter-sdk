# Kin Flutter SDK (Unofficial)

Plugin Package for using [Kin Cryptocurrency](https://www.kin.org/) Official SDK within Flutter. currently supporting [IOS](https://github.com/kinecosystem/kin-ios) and [Android](https://github.com/kinecosystem/kin-android) Implmentations.

## How to use the SDK

SDK has: <br>
1) `KinSdk` for all the newer oprations using the `Agora` 
2) `KinBaseCompatSdk` for older version of the sdk.

### KinSdk (`base`)
### Creating an account 
```dart
import 'package:kin_sdk/kin_sdk.dart';


Future<void> createAccount() async {
    String accountId;

    try {
      accountId = await KinSdk.createAccount;
    } on PlatformException {
      accountId = 'Failed to create accountId';
    }

    setState(() {
      _accountId = accountId;
    });
  }
```


### KinBaseCompatSdk (`base-compat`)
### Creating an account 
```dart
import 'package:kin_sdk/kin_base_compat_sdk.dart';


Future<void> createAccount() async {
    String accountId;

    try {
      accountId = await KinBaseCompatSdk.createAccount;
    } on PlatformException {
      accountId = 'Failed to create accountId';
    }

    setState(() {
      _accountId = accountId;
    });
  }
```