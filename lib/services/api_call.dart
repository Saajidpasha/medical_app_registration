import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medical_app/my_provider.dart';
import 'package:medical_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model.dart';

class ApiCall {
  insertData({Model model,context}) async {
    var data = {
      "firstName": model.firstName,
      "lastName": model.lastName,
      "designation": model.designation,
      "office": model.office,
      "dept": model.dept,
      "addr1": model.addr1,
      "addr2": model.addr2,
      "state": model.state,
      "city": model.city,
      "zip": model.zip,
      "phone": model.phone,
      "fax": model.fax,
      "email": model.email,
      "product1": model.product1.toString(),
      "product2": model.product2.toString(),
      "enq": model.enq,
      "patientName": model.patientName,
      "dob": model.dob,
      "gender": model.gender,
      "dateOfReq": model.dateOfReq,
      "base64Img": model.base64Img,
      "repName": model.repName,
      "repType": model.repType,
      "repTN": model.repTN,
      "countryCode": model.countryCode,
      "telNum": model.telNum,
      "faxCheck": model.faxCheck.toString(),
      "mailCheck": model.mailCheck.toString(),
      "emailCheck": model.emailCheck.toString(),
      "descr": model.descr,
      "phoneCheck": model.phoneCheck.toString()
    };
    print(data);
    try {
      MyProvider provider = Provider.of<MyProvider>(context);
      var res = await http.post(Uri.parse(Constants.URL), body: data);
      print(res.statusCode);
      if (res.statusCode == 200) {
        provider.setBoolVal(false);
      }
      print(res.body);
    } catch (er) {
      print("Error inserting" + er);
    }
  }
}
