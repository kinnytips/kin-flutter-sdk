# Kin Flutter SDK
[![Kin flutter SDK CI](https://github.com/kinnytips/kin-flutter-sdk/actions/workflows/dart.yml/badge.svg)](https://github.com/kinnytips/kin-flutter-sdk/actions/workflows/dart.yml)

## NOTE - Kin Agora service is no longer operational.  This SDK can be used along with the open source [Agora](https://github.com/kinecosystem/agora) components to host your own Agora for a feeless UX

Flutter Package for using [Kin Cryptocurrency](https://www.kin.org/). Based on the [Kin Android SDK](https://github.com/kinecosystem/kin-android).

Library&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Path                                                                                   | Description&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                                                                                                                                                                                                                             |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------|
| `kin_base`                                                                                                                   | [`/base`](/lib/base)| The foundation library used by all other libraries in the system to support basic Kin operations: <ul><li>Wallet creation and management</li><li>Send and receive Kin</li><li>Metrics interfaces</li></ul>                                                                                |                                                                                                        | [`/base-compat`](/lib/base-compat)                                                                                                | The [base-compat](base-compat) library implements the public surface layer to be a drop in replacement of the, now deprecated, [kin-sdk-android](https://github.com/kinecosystem/kin-sdk-android) library or Flutter equivalent.         
| `design (WIP)`                                                                                                             | [`/design`](/lib/design)                                                                                                | Shared library components for creating consistent Kin user experiences. When creating a custom Kin experience, this library can be used to include standard UI components for displaying Kin prices, transactions, etc.       
| `spend (WIP)`                                                                                                             | [`/spend`](/lib/spend)                                                                                                | The [:spend](spend) library provides an out of the box model UI for spending Kin within an Android application. Specificy what you're buying, your account, tap confirm. Success.      
| `backup_restore`                                                                                                             | [`/backup_restore`](/lib/backup_restore)                                                                                                | The [:backup-restore](backup-restore) library provides an out of the box model UI for backing up and restoring wallets with a variety of implementations.      

## How to use the SDK
### Initiate the sdk

```dart
var kin = Kin(production, appIndex, 'Example App',
    onBalanceChange: _onBalanceChange,
    onPayment: _onPayment,
    onAccountContext: _onResolveAccountContext,
    credentialUser: credentialUser,
    credentialPass: credentialPass);

    await kin.waitReady();
```
Now, this instance can be used to perform all the operations on the `kin` blockchain.

### Creating a new account
```dart
var accountId = kin.createAccount();
```

### Adding an existing account
```dart
var kinBackupRestore = KinBackupRestore();
var backupKeyPair = kinBackupRestore.importWallet(accountBackup, backupPass);
```

### Fetching account info
```dart
var kinContext = kin.getKinContext();

var account = await kinContext.getAccount(forceUpdate: true);
```

### Import account from backup
```dart
var accountId = await kin.importWallet(walletBackupJson, walletBackupPassword);
```

### Fetching account history
```dart
var transactions = await kinContext.getAllTransactionsHistory();
```
