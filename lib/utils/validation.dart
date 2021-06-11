class Validation {
  String validateString(String text) {
    if (text.length > 0 && text.isNotEmpty) {
      return null;
    } else {
      return "This field is required!";
    }
  }

  String validatePhone(String phone) {
    if (phone.length == 10) {
      return null;
    } else {
      return "Invalid number";
    }
  }

  String validateZip(String zip) {
    if (zip.length == 6) {
      return null;
    } else {
      return "Zip should be 6 digits";
    }
  }

  String validateCountryCode(String text) {
    if (text.length == 2) {
      return null;
    } else {
      return "Code should be two digits!";
    }
  }
}
