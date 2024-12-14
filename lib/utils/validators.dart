class Validators {
  // E-posta formatını kontrol et
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-posta boş olamaz';
    }
    String pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Geçerli bir e-posta adresi girin';
    }
    return null;
  }

  // Şifreyi kontrol et
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre boş olamaz';
    }
    if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalı';
    }
    return null;
  }

  // Şifreyi doğrula (şifre tekrarının doğru olup olmadığını kontrol et)
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Şifre tekrar boş olamaz';
    }
    if (value != password) {
      return 'Şifreler uyuşmuyor';
    }
    return null;
  }
}
