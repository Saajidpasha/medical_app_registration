import 'package:medical_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model.dart';

saveToLocal(Model model) async {
  try {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    print("data stored locally");
    _prefs.setBool("dataStoredLocally", true);

    _prefs.setString(Constants.firstName, model.firstName);
    _prefs.setString(Constants.lastName, model.lastName);
    _prefs.setString(Constants.designation, model.designation);
    _prefs.setString(Constants.dept, model.dept);
    _prefs.setString(Constants.office, model.office);
    _prefs.setString(Constants.addr1, model.addr1);
    _prefs.setString(Constants.addr2, model.addr2);
    _prefs.setString(Constants.state, model.state);
    _prefs.setString(Constants.city, model.city);
    _prefs.setString(Constants.zip, model.zip);
    _prefs.setString(Constants.phone, model.phone);
    _prefs.setString(Constants.fax, model.fax);
    _prefs.setString(Constants.email, model.email);
    _prefs.setString(Constants.mg1, model.product1.toString());
    _prefs.setString(Constants.mg2, model.product2.toString());
    _prefs.setString("Enquiry", model.enq);
    _prefs.setString(Constants.patientName, model.patientName);
    _prefs.setString(Constants.dob, model.dob);
    _prefs.setString(Constants.descr, model.descr);
    _prefs.setString(Constants.gender, model.gender);
    _prefs.setString(Constants.dateOfReq, model.dateOfReq);
    _prefs.setString(Constants.sign, model.dob);
    _prefs.setString(Constants.repName, model.repName);
    _prefs.setString(Constants.repType, model.repType);
    _prefs.setString(Constants.repTN, model.repTN);
    _prefs.setString(Constants.countryCode, model.countryCode);
    _prefs.setString(Constants.telNum, model.telNum);
    _prefs.setString(responses[0], model.faxCheck.toString());
    _prefs.setString(responses[1], model.mailCheck.toString());
    _prefs.setString(responses[2], model.emailCheck.toString());
    _prefs.setString(responses[3], model.phoneCheck.toString());
  } catch (er) {
    print("Error saving to local" + er);
  }
}

destroyLocalCopy() async {
  try {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
  } catch (er) {
    print("Error clearing local" + er);
  }
}

Future<Model> getDataFromLocal() async {
  try {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("dataStoredLocally", false);
    Model model = Model(
        firstName: _prefs.getString(Constants.firstName),
        lastName: _prefs.getString(Constants.lastName),
        designation: _prefs.getString(Constants.designation),
        dept: _prefs.getString(Constants.dept),
        office: _prefs.getString(Constants.office),
        addr1: _prefs.getString(Constants.addr1),
        addr2: _prefs.getString(Constants.addr2),
        state: _prefs.getString(Constants.state),
        city: _prefs.getString(Constants.city),
        zip: _prefs.getString(Constants.zip),
        phone: _prefs.getString(Constants.phone),
        fax: _prefs.getString(Constants.fax),
        email: _prefs.getString(Constants.email),
        product1: _prefs.getString(Constants.mg1) == "true" ? true : false,
        product2: _prefs.getString(Constants.mg2) == "true" ? true : false,
        enq: _prefs.getString("Enquiry"),
        patientName: _prefs.getString(Constants.patientName),
        dob: _prefs.getString(Constants.dob),
        descr: _prefs.getString(Constants.descr),
        gender: _prefs.getString(Constants.gender),
        dateOfReq: _prefs.getString(Constants.dateOfReq),
        base64Img: _prefs.getString(Constants.sign),
        repName: _prefs.getString(Constants.repName),
        repType: _prefs.getString(Constants.repType),
        repTN: _prefs.getString(Constants.repTN),
        countryCode: _prefs.getString(Constants.countryCode),
        telNum: _prefs.getString(Constants.telNum),
        faxCheck: _prefs.getString(responses[0]) == "true" ? true : false,
        mailCheck: _prefs.getString(responses[1]) == "true" ? true : false,
        emailCheck: _prefs.getString(responses[2]) == "true" ? true : false,
        phoneCheck: _prefs.getString(responses[3]) == "true" ? true : false);
    return model;
  } catch (er) {
    return null;
  }
}
