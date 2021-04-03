# Base Module

The [:base](../base) module is the foundation upon which the rest of the SDK stands. However, it can be used on its own to headlessly access the Kin Blockchain.

## Installation
Add the following to your project's `pubspec.yaml` file.
```
dependencies:
  flutter:
    sdk: flutter
  kin_sdk: ^x.x.x

```

## Overview
The base module contains two main components that are to be instantiated and used by the developer:
- a `KinEnvironment` instance to describe the network (test or production) and provide some external dependencies
- a `KinAccountContext` instance to access functionality of a Kin account on the Kin Blockchain, provide local storage for your private key, and provide a data cache for account and payment history data.

## Quick Start
Everything starts with a `KinEnvironment` instance that describes which blockchain, services, and storage will be used.

### Agora Kin Environment
The Agora Kin Environment is now the preferred method of communicating with the Kin Blockchain. Agora is both a gateway to submit payments and a history collector that can be used to resolve your full payment history.
When submitting payments, a developer should properly configure an [Agora webhook](https://docs.kin.org/how-it-works#webhooks), which acts as a delegate to approve and optionally co-sign a transaction to mediate transaction fees.
Agora can also store additional meta-data about your transaction concerning what your payments were for. This bundle of information is called an `Invoice`, offchain data which is referenced by the payment's associated `Memo`. You can read more about both below in the [Sending Payments section](#sending-payments).

You'll also need to tell the SDK a bit about your app in an AppInfoProvider implementation to work with some features (like paying and resolving Invoices and the [spend](../spend) module UI).
There are two bundles of information an App provides through this interface:
- An AppInfo object to describe the App. This contains your App's unique App Index whcih you can obtain by registering [here](https://docs.kin.org/app-registration)
- Passthrough Auth User Credentials are passed onto the webhook when submitting a transaction

For more information regarding webhooks and webhook integration please read more about [how it works](https://docs.kin.org/how-it-works#webhooks).
```
placeholder put example here
```

### Horizon Kin Environment
Horizon access from the SDK has been deprecated. While it's still included in the SDK and can be used, it may become unavailable in a future blockchain migration.
```
placeholder put example here
```
For a given `KinAccount` that you want to operate on, you will need a `KinAccountContext` instance.
This will be used to both create and access all `KinAccount` and `KinPayment`s.

 ```
 placeholder put example here
```

*Failure to do this will default your app to start on Kin 3 which will create a new account for your users on Kin3 with a 0 Kin balance. You probably do not want to do this.*


### *As you may notice on the `KinAccountContext.Builder`, there are a few options for configuring a `KinAccountContext`...*

## Creating An Account
If you want to create a new `KinAccount`:
```
placeholder put example here
```
## Access An Existing Account
If you want to access an existing `KinAccount` with options to send `KinPayment`s, input the `KinAccount.Id` with:
```
placeholder put example here
```
*Note: this variant requires that the `KinEnvironment` knows about this `KinAccount`'s `Key.PrivateKey` which can be imported the first time by:*
```
placeholder put example here
```
## Read Only Account Data
For `KinAccount`s that you do **not** have a `Key.PrivateKey` for and only desired read-only access to the data associated with that account:
```
placeholder put example here
```

## Sending Payments
Sending `KinPayment`s is easy. Just add the amount and the destination `KinAccount.Id`.

*Note: successive calls to this function before the previous is completed will be properly queued according to blockchain implementation needs.*
```
placeholder put example here
```
Sending a batch of payments to the blockchain to be completed together, in a single transaction, is just as easy.

*Note: This operation is atomic. All payments will either succeed or fail together.*
```
placeholder put example here
```

 Paymments made within this library are automatically retried, if the error permits being retried, up to 5 times with exponential backoff starting at 1 second after the first attempt (i.e. 1s, 2s, 4s, 8s intervals).

### Are there Fees?
It depends. By default, payments on the Kin Blockchain are charged a minimal fee of 100 Quark (1 Quark = 0.001 Kin) each. The minimum required fee is dictated by the Blockchain. Fees on the Kin blockchain are an anti-spam feature intended to prevent malicious actors from spamming the network. Registered Kin apps are given a whitelisted account, which they can use to exempt their or their users' transactions using the [Sign Transaction webhook](https://docs.kin.org/how-it-works#sign-transaction).

When using `KinAccountContext` configured with the Agora KinEnvironment, by default a fee will not be added to the payment unless you specifically want your users to pay fees instead of you providing whitelisting. This can be achieved by overriding and setting the `isWhitelistingAvailable` parameter to false in the `KinTransactionWhitelistingApi` instance when configuring your `KinEnvironment` instance.

### How can I add more data to the payment?
#### Memos
Memos are only 32 bytes of data that are stored on the blockchain with your payment data. Because of this, it's recommended to only include data you can use to reference a larger set of data off chain.

#### *Kin Binary Memo Format (Recommended)*
The Kin Binary Memo Format is defined by [this spec](https://github.com/kinecosystem/agora-api-internal/blob/master/spec/memo.md) and includes the following fields:
- Version: the memo encoding version (primarily used by the SDKs for interpreting memos).
- Transaction Type: the 'type' of the transaction the memo is embedded in.
- App Index: a 16-bit value that refers to the app the transaction is related to. Replaces app IDs.
- Foreign Key: the identifier in an auxiliary transaction service that contains metadata about what a transaction is for.

Apps that are migrating from the old AppId format can check out details [here](https://docs.kin.org/how-it-works#memo-format-and-app-index)

Use the `KinBinaryMemo.Builder` class to construct a `KinBinaryMemo`.
The `KinBinaryMemo.TransferType` is important to set appropriately for the type of payment you are making (Earn/Spend/P2P) (See KDoc definitions for more details).
The new foreign key field primarily serves as a way for apps to include a reference to some other data stored off-chain, to help address memo space limitations. This field has a max limit of 230 bits. One option available to developers for storing off-chain data is [invoices](#invoices), which can help developers provide their users with richer transaction data and history. However, developers are free to use the foreign key to reference data hosted by their own services.
```
placeholder put example here
```
#### *Text Memos (Old style memos)*
In this SDK you can provide a text based memo by using the `ClassicKinMemo` class. This format should only be used by existing apps that have been issued AppIds and have yet to upgrade to the new Kin Binary Memo Format.

#### Invoices
[Invoices](https://docs.kin.org/how-it-works#invoices) are a great way to leverage Agora to store data about your payments off-chain for you to retrieve later (e.g. in your payment history). They can be submitted to Agora via the optional invoice field of `sendKinPayment` method with a properly formatted KinBinaryMemo which is used to reference the applicable Invoice data at a later time.

An invoice for a payment contains a list of line items, which contain the following information:
- **title**: the title of a line item.
- **amount**: the amount of a line item.
- **description** (optional): the description of the line item.
- **sku** (optional): an app-specific identifier. This can be anything developers wish to include (e.g. a product ID).

The `Invoice.Builder` class can be used to construct an Invoice to operate on. As an app that sells a set of digital goods or services, you may wish to transform the information you have in your own models into an Invoice object and reference it later via its identifier stored in the SKU.
```
placeholder put example here
```

To execute a payment for an `Invoice`, you can make use of the `payInvoice` convenience function on `KinAccountContext`. This essentially calls `sendPayment` on your behalf with the correctly formatted `KinBinaryMemo` and TransferType of `KinBinaryMemo.TransferType.Spend`. Invoices can and should also be used for other TransferTypes such as P2P and Earns.

*The destinationKinAccountId must match the expected & registered destinationKinAppIdx provided [during registration](https://docs.kin.org/app-registration)*
```
placeholder put example here
```

If an `Invoice` was included with the submission, the optional invoice field on the `KinPayment` will be populated with the Invoice. This is especially helpful when observing your [payment history](#retrieving-payment-history)
```
placeholder put example here
```

*Note:* If you are paying for an `Invoice`, you *must* use the Kin Binary Memo Format for the memo.*

## Retrieving Account Data
The `KinAccount.Id` for a given `KinAccountContext` instance is always available
```
placeholder put example here
```
If you require more than just the id, the full `KinAccount` is available by querying with:
```
placeholder put example here
```
Observing balance changes over time is another common account operation:

*Note: don't forget to clean up when the observer is no longer required! This can be accomplished via a `DisposeBag`, or by calling `.remove(listener)` on the `Observer`*
```
placeholder put example here
```

## Retrieving Payment History
Whether you're looking for the full payment history or just to be notified of new payments, you can observe any changes to payments for a given account with:
```
placeholder put example here
```
Sometimes it's useful to retrieve payments that were processed together in a single `KinTransaction`
```
placeholder put example here
```

## Other
When done with a particular account, you can irrevocably delete the data, **including the private key**, by performing the following:
```
placeholder put example here
```
