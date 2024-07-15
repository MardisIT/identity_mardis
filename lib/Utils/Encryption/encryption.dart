import 'dart:typed_data';
import 'package:pointycastle/export.dart';

Uint8List decrypt(Uint8List cipherText, Uint8List key, Uint8List iv) {
  final keyParam = KeyParameter(key);
  final ivParam = ParametersWithIV<KeyParameter>(keyParam, iv);
  final params =
      PaddedBlockCipherParameters<CipherParameters, CipherParameters>(
          ivParam, null);

  final cipher =
      PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()));

  cipher.init(false, params); // false for decryption

  try {
    return cipher.process(cipherText);
  } on InvalidCipherTextException {
    throw ArgumentError('Invalid ciphertext');
  }
}