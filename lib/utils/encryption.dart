import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionUtils {
  final String secretKey;
  final String iv;

  EncryptionUtils({required this.secretKey, required this.iv});

  String encryptText(String text) {
    final encrypter = encrypt.Encrypter(
      encrypt.AES(encrypt.Key.fromUtf8(secretKey), mode: encrypt.AESMode.cbc),
    );
    final iv = encrypt.IV.fromUtf8(this.iv);
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }

  String decryptText(encrypt.Encrypted encryptedText) {
    final encrypter = encrypt.Encrypter(
      encrypt.AES(encrypt.Key.fromUtf8(secretKey), mode: encrypt.AESMode.cbc),
    );
    final iv = encrypt.IV.fromUtf8(this.iv);
    final decrypted = encrypter.decrypt(encryptedText, iv: iv);
    return decrypted;
  }
}
