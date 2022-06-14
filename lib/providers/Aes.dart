// import 'package:encrypt/encrypt.dart';

import 'package:encrypt/encrypt.dart';

class Aes {
  static final String keyId = "AESNIRMALYEHSKEY";
  static final String initVector = "encryptionIntTak";

  static String encrypt(String plainText) {
    // final key = Key.fromUtf8("nirmalyaLabsPVTT");
    // final iv = IV.fromUtf8("TTVPsbaLaylamrin");
    final key = Key.fromUtf8(keyId);
    final iv = IV.fromUtf8(initVector);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    return encrypter.encrypt(plainText, iv: iv).base64;
  }

  static String decrypt(String val) {
    final key = Key.fromUtf8(keyId);
    final iv = IV.fromUtf8(initVector);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    return encrypter.decrypt64(val, iv: iv);
  }
}
