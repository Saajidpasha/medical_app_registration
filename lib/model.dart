class Model {
  final String firstName;
  final String lastName;
  final String designation;
  final String office;
  final String dept;
  final String addr1;
  final String addr2;
  final String state;
  final String city;
  final String zip;
  final String phone;
  final String fax;
  final String email;
  final bool product1;
  final bool product2;
  final String enq;
  final String patientName;
  final String dob;
  final String gender;
  final String dateOfReq;
  final String base64Img;
  final String repName;
  final String repType;
  final String repTN;
  final String countryCode;
  final String telNum;
  final bool faxCheck;
  final bool mailCheck;
  final bool emailCheck;
  final bool phoneCheck;
  final String descr;

  Model(
      {this.firstName,
      this.faxCheck,
      this.emailCheck,
      this.mailCheck,
      this.phoneCheck,
      this.lastName,
      this.designation,
      this.office,
      this.dept,
      this.addr1,
      this.addr2,
      this.state,
      this.city,
      this.zip,
      this.phone,
      this.fax,
      this.descr,
      this.email,
      this.product1,
      this.product2,
      this.enq,
      this.patientName,
      this.dob,
      this.gender,
      this.dateOfReq,
      this.base64Img,
      this.repName,
      this.repType,
      this.repTN,
      this.countryCode,
      this.telNum});
}
