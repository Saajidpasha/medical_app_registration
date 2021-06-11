import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:medical_app/services/api_call.dart';
import 'package:medical_app/services/shared_services.dart';
import 'package:medical_app/utils/constants.dart';
import 'package:medical_app/utils/validation.dart';
import 'package:medical_app/widgets/text_field.dart';
import 'package:toast/toast.dart';
import 'package:signature/signature.dart';

import '../model.dart';

enum MediaType { Image, Video }

class UploadItem {
  final String id;
  final String tag;
  final MediaType type;
  final int progress;
  final UploadTaskStatus status;

  UploadItem({
    this.id,
    this.tag,
    this.type,
    this.progress = 0,
    this.status = UploadTaskStatus.undefined,
  });

  UploadItem copyWith({UploadTaskStatus status, int progress}) => UploadItem(
      id: this.id,
      tag: this.tag,
      type: this.type,
      status: status ?? this.status,
      progress: progress ?? this.progress);

  bool isCompleted() =>
      this.status == UploadTaskStatus.canceled ||
      this.status == UploadTaskStatus.complete ||
      this.status == UploadTaskStatus.failed;
}

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextStyle titleStyle = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20);
  final TextStyle subTitleStyle = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16);

  String state = states[0];

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController officeController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController dateOfReqController = TextEditingController();
  TextEditingController deptController = TextEditingController();
  TextEditingController addr1Controller = TextEditingController();
  TextEditingController addr2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController faxController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descrController = TextEditingController();
  TextEditingController patientController = TextEditingController();
  TextEditingController repNameController = TextEditingController();
  TextEditingController repTypeController = TextEditingController();
  TextEditingController repTNController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.blue,
  );

  String radioVal1;
  String radioVal2;
  String radioVal3;
  bool firstVal = false;
  bool secondVal = false;

  String designation;
  String gender;
  String enq;

  bool fax = false;
  bool phone = false;
  bool mail = false;
  bool email = false;

  FlutterUploader uploader = FlutterUploader();

  final _formKey = GlobalKey<FormState>();

  var _signatureCanvas;

  @override
  void dispose() {
    super.dispose();
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    _signatureCanvas = Signature(
      controller: _controller,
      width: 300,
      height: 300,
      backgroundColor: Colors.white,
    );
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          margin: const EdgeInsets.all(10),
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
          child: SingleChildScrollView(
            child: buildColumn(),
          ),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          Constants.title,
          style: titleStyle,
        ),
        SizedBox(
          height: 30,
        ),
        Divider(),
        Text(
          Constants.subTitle,
          style: subTitleStyle,
        ),
        SizedBox(
          height: 30,
        ),
        Divider(),
        buildFormContainer(),
        submitButton(),
      ],
    );
  }

  Form buildFormContainer() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTextFormField(
              label: Constants.firstName,
              controller: firstNameController,
              validator: Validation().validateString,
              keyboardType: TextInputType.name,
              hint: ""),
          buildTextFormField(
              label: Constants.lastName,
              controller: lastNameController,
              keyboardType: TextInputType.name,
              validator: Validation().validateString,
              hint: ""),
          SizedBox(
            height: 30,
          ),
          Text(
            Constants.designation,
            style: subTitleStyle,
          ),
          radioListTile(designationList[0], 1),
          radioListTile(designationList[1], 1),
          radioListTile(designationList[2], 1),
          radioListTile(designationList[3], 1),
          buildTextFormField(
              label: Constants.office + " *",
              controller: officeController,
              hint: Constants.office),
          buildTextFormField(
              label: Constants.dept + " *",
              controller: deptController,
              validator: Validation().validateString,
              hint: Constants.dept),
          buildTextFormField(
              label: Constants.addr1 + " *",
              controller: addr1Controller,
              validator: Validation().validateString,
              keyboardType: TextInputType.streetAddress,
              hint: Constants.addr1 + " 1"),
          buildTextFormField(
              label: Constants.addr2 + " *",
              controller: addr2Controller,
              keyboardType: TextInputType.streetAddress,
              validator: Validation().validateString,
              hint: Constants.addr2),
          SizedBox(
            height: 30,
          ),
          Text(
            Constants.state,
            style: subTitleStyle,
          ),
          stateDropDown(),
          SizedBox(
            height: 30,
          ),
          buildTextFormField(
              label: Constants.city + " *",
              controller: cityController,
              validator: Validation().validateString,
              keyboardType: TextInputType.streetAddress,
              hint: Constants.city),
          buildTextFormField(
              label: Constants.zip + " *",
              controller: zipController,
              validator: Validation().validateZip,
              keyboardType: TextInputType.number,
              hint: Constants.zip),
          buildTextFormField(
              label: Constants.phone,
              controller: phoneController,
              //validator: Validation().validatePhone,
              keyboardType: TextInputType.number,
              hint: Constants.phone),
          buildTextFormField(
              label: Constants.fax,
              controller: faxController,
              hint: Constants.fax),
          buildTextFormField(
              label: Constants.email,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              hint: Constants.email),
          SizedBox(
            child: Divider(),
            height: 20,
          ),
          Text(
            Constants.subTitle2,
            style: subTitleStyle,
          ),
          SizedBox(
            child: Divider(),
            height: 20,
          ),
          Text(
            Constants.choose,
            style: subTitleStyle,
          ),
          Row(
            children: [
              buildCheckboxListTile(text: Constants.mg1, v: 1),
              buildCheckboxListTile(text: Constants.mg2, v: 2)
            ],
          ),
          buildTextFormField(
              label: Constants.descr, controller: descrController, maxLines: 2),
          SizedBox(
            child: Divider(),
            height: 20,
          ),
          Text(
            Constants.checkOne,
            style: subTitleStyle,
          ),
          radioListTile(Constants.enq1, 2),
          radioListTile(Constants.enq2, 2),
          buildTextFormField(
              label: Constants.patientName + " *",
              controller: patientController,
              validator: Validation().validateString,
              hint: Constants.patientName),
          buildTextFormField(
              label: Constants.dob + " *",
              controller: dobController,
              keyboardType: TextInputType.datetime,
              hint: "dd/mm/yyyy"),
          Text(
            Constants.gender,
            style: subTitleStyle,
          ),
          radioListTile(Constants.male, 3),
          radioListTile(Constants.female, 3),
          radioListTile(Constants.other, 3),
          buildTextFormField(
              label: Constants.dateOfReq + " *",
              controller: dateOfReqController,
              keyboardType: TextInputType.datetime,
              hint: "dd/06/2020"),
          Text(
            Constants.prefMethod,
            style: subTitleStyle,
          ),
          buildCheckboxListTile2(text: Constants.fax, i: 1),
          buildCheckboxListTile2(text: Constants.mail, i: 2),
          buildCheckboxListTile2(text: Constants.email, i: 3),
          buildCheckboxListTile2(text: Constants.phone, i: 4),
          SizedBox(
            child: Divider(),
            height: 20,
          ),
          Text(
            Constants.sign,
            style: subTitleStyle,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border:
                    Border.all(color: Colors.black, style: BorderStyle.solid)),
            margin: EdgeInsets.all(10),
            child: _signatureCanvas,
          ),
          SizedBox(
            child: Divider(),
            height: 20,
          ),
          Text(
            Constants.subTitle3,
            style: titleStyle,
          ),
          SizedBox(
            child: Divider(),
            height: 20,
          ),
          Text(
            Constants.text3,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            child: Divider(),
            height: 20,
          ),
          buildTextFormField(
            label: Constants.repName + "*",
            hint: Constants.repName,
            validator: Validation().validateString,
            controller: repNameController,
          ),
          buildTextFormField(
            label: Constants.repType + "*",
            hint: Constants.repType,
            validator: Validation().validateString,
            controller: repTypeController,
          ),
          buildTextFormField(
            label: Constants.repTN + "*",
            hint: Constants.repTN,
            validator: Validation().validateString,
            controller: repTNController,
          ),
          buildTextFormField(
              label: Constants.countryCode,
              hint: "+1",
              keyboardType: TextInputType.number,
              controller: countryCodeController,
              validator: Validation().validateCountryCode),
          buildTextFormField(
            label: Constants.telNum,
            hint: Constants.teleNum,
            keyboardType: TextInputType.number,
            controller: telephoneController,
          ),
        ],
      ),
    );
  }

  Container submitButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      //alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10)),
      child: TextButton(
          onPressed: () async {
            //print("clikc");
            if (_formKey.currentState.validate() && _controller.isNotEmpty) {
              print("Validated");
              var signImg = await _controller.toPngBytes();

              Model model = Model(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  designation: designation,
                  office: officeController.text,
                  dept: deptController.text,
                  addr1: addr1Controller.text,
                  addr2: addr2Controller.text,
                  state: state,
                  descr: descrController.text,
                  city: cityController.text,
                  zip: zipController.text,
                  phone: phoneController.text,
                  fax: faxController.text,
                  email: emailController.text,
                  product1: firstVal,
                  product2: secondVal,
                  enq: enq,
                  gender: gender,
                  patientName: patientController.text,
                  dateOfReq: dateOfReqController.text,
                  dob: dobController.text,
                  faxCheck: fax,
                  phoneCheck: phone,
                  mailCheck: mail,
                  emailCheck: email,
                  base64Img: base64Encode(signImg),
                  repName: repNameController.text,
                  repType: repTypeController.text,
                  repTN: repTNController.text,
                  countryCode: countryCodeController.text,
                  telNum: telephoneController.text);

              Toast.show("Form Submitted Successfully!", context);
              saveToLocal(model);
              ApiCall().insertData(model: model);
            }
          },
          child: Text(
            "Submit",
            style: subTitleStyle,
          )),
    );
  }

  buildCheckboxListTile({String text, int v}) {
    return Expanded(
      child: CheckboxListTile(
          title: Text(text),
          value: v == 1 ? firstVal : secondVal,
          onChanged: (bool val) {
            setState(() {
              v == 1 ? firstVal = val : secondVal = val;
            });
          }),
    );
  }

  buildCheckboxListTile2({String text, int i}) {
    return Row(
      children: [
        Checkbox(
            value: i == 1
                ? fax
                : i == 2
                    ? mail
                    : i == 3
                        ? email
                        : phone,
            onChanged: (bool val) {
              setState(() {
                i == 1
                    ? fax = val
                    : i == 2
                        ? mail = val
                        : i == 3
                            ? email = val
                            : phone = val;
              });
            }),
        Text(
          text,
          style: subTitleStyle,
        ),
      ],
    );
  }

  DropdownButtonHideUnderline stateDropDown() {
    return DropdownButtonHideUnderline(
      child: new DropdownButton<String>(
        isExpanded: true,
        elevation: 0,
        items: states.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        onChanged: (val) {
          state = val;
          setState(() {});
        },
        value: state,
        hint: Text(state),
      ),
    );
  }

  ListTile radioListTile(String title, int radio) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      leading: Radio(
        value: title,
        groupValue: radio == 1
            ? radioVal1
            : radio == 2
                ? radioVal2
                : radioVal3,
        onChanged: (val) {
          setState(() {
            radio == 1
                ? radioVal1 = val
                : radio == 2
                    ? radioVal2 = val
                    : radioVal3 = val;
            if (radio == 1) {
              designation = val;
            } else if (radio == 2) {
              enq = val;
            } else {
              gender = val;
            }
          });
        },
      ),
    );
  }
}
