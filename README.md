# Kin Flutter SDK (Unofficial)

Plugin Package for using [Kin Cryptocurrency](https://www.kin.org/) Official SDK within Flutter. currently supporting [IOS](https://github.com/kinecosystem/kin-ios) and [Android](https://github.com/kinecosystem/kin-android) Implmentations.

## Documentation
[API](https://docs.kin.org/agora/api) <br/>
[TECHNICAL ARCHITECTURE](https://docs.kin.org/how-it-works#kin-binary-memo-format)


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