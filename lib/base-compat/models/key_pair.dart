import 'dart:async';
import 'dart:typed_data';

import 'decorated_signature.dart';
import 'signature_hint.dart';

class IKeyPair {
    /**
     * Returns the human readable account ID encoded in strkey.
     */
    String accountId;

    /**
     * Returns the human readable secret seed encoded in strkey.
     */
    CharArray secretSeed;
    
    /**
     * Returns the raw 32 byte secret seed.
     */
    ByteData rawSecretSeed;
    ByteData publicKey;
    SignatureHint signatureHint;
    PublicKey xdrPublicKey;
    SignerKey xdrSignerKey;

    /**
     * Returns true if this Keypair is capable of signing
     */
    Future<bool> canSign() async {

    }

    /**
     * Sign the provided data with the keypair's private key.
     *
     * @param data The data to sign.
     * @return signed bytes, null if the private key for this keypair is null.
     */
    Future<ByteData> sign(ByteData data) async {

    } 

    /**
     * Sign the provided data with the keypair's private key and returns [DecoratedSignature].
     *
     * @param data
     */
    Future<DecoratedSignature> signDecorated(ByteData data) async {

    }

    /**
     * Verify the provided data and signature match this keypair's public key.
     *
     * @param data      The data that was signed.
     * @param signature The signature.
     * @return True if they match, false otherwise.
     * @throws RuntimeException
     */
    Future<bool> verify(ByteData data, ByteData signature) async {

    }
}
    
class CharArray {
}

class SignerKey {
}

class PublicKey {
}

class KeyPair implements IKeyPair {
  @override
  String accountId;

  @override
  ByteData publicKey;

  @override
  ByteData rawSecretSeed;

  @override
  var secretSeed;

  @override
  var signatureHint;

  @override
  var xdrPublicKey;

  @override
  var xdrSignerKey;

  @override
  Future<bool> canSign() {
    // TODO: implement canSign
    throw UnimplementedError();
  }

  @override
  Future<ByteData> sign(ByteData data) {
      // TODO: implement sign
      throw UnimplementedError();
    }
  
    @override
    Future<DecoratedSignature> signDsign(Byt(DataData data) {
      // TODO: implement signDecorated
      throw UnimplementedError();
    }
  
    @override
    Future<sign(BytrDataByteData data, ByteData signature) {
    // TODO: implement verify
    throw UnimplementedError();
  }

  @override
  Future<DecoratedSignature> signDecorated(ByteData data) {
      // TODO: implement signDecorated
      throw UnimplementedError();
    }

  @override
  Future<bool> verify(ByteData data, ByteData signature) {
    // TODO: implement verify
    throw UnimplementedError();
  }

}