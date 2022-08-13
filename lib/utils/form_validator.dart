class FormValidator {
  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Please provide name';
    } else if (name.length >= 21) {
      return 'Too long';
    }
    return null;
  }

  static String? validateSize(String? size) {
    if (size == null || size.isEmpty) {
      return 'Please provide size';
    }
    return null;
  }

  static String? validateLocation(String? location) {
    if (location == null || location.isEmpty) {
      return 'Please provide location';
    }
    return null;
  }

  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Please provide phone';
    } else if (phone.length < 11 || phone.length > 11) {
      return 'Invalid Number';
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please provide email address';
    } else if (!email.endsWith('@gmail.com')) {
      return 'Badly formatted';
    }
    return null;
  }

  static String? validateAddress(String? address) {
    if (address == null || address.isEmpty) {
      return 'Please provide address';
    }
    return null;
  }
}
