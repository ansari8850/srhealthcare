

class LoginResModel {
    bool error;
    String message;
    String accessToken;
    int status;
    bool verify;
    Result result;

    LoginResModel({
        required this.error,
        required this.message,
        required this.accessToken,
        required this.status,
        required this.verify,
        required this.result,
    });

    LoginResModel copyWith({
        bool? error,
        String? message,
        String? accessToken,
        int? status,
        bool? verify,
        Result? result,
    }) => 
        LoginResModel(
            error: error ?? this.error,
            message: message ?? this.message,
            accessToken: accessToken ?? this.accessToken,
            status: status ?? this.status,
            verify: verify ?? this.verify,
            result: result ?? this.result,
        );

    factory LoginResModel.fromJson(Map<String, dynamic> json) => LoginResModel(
        error: json["error"],
        message: json["message"],
        accessToken: json["access_token"],
        status: json["status"],
        verify: json["verify"],
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "access_token": accessToken,
        "status": status,
        "verify": verify,
        "result": result.toJson(),
    };
}

class Result {
    int id;
    String name;
    String lastName;
    String mobileNo;
    String loginType;
    String department;
    String email;
    dynamic contactPersonName;
    String userTypeId;
    dynamic workPhone;
    String field;
    String displayName;
    dynamic businessLeagalName;
    dynamic taxPreference;
    dynamic gstNo;
    dynamic panNo;
    dynamic website;
    dynamic registrationType;
    String bio;
    dynamic subField;
    String emrMobileNo;
    String photo;
    String education;
    String address;
    dynamic remark;
    String attachments;
    int isDisabled;
    String password;
    String cPassword;
    String userType;
    String countryId;
    dynamic date;
    String stateId;
    String cityId;
    String street1;
    String street2;
    String zipCode;
    dynamic companyName;
    dynamic contactPerson;
    String status;
    dynamic workEmail;
    String fieldName;
    int otp;
    String otpVerify;
    DateTime createdAt;
    DateTime updatedAt;

    Result({
        required this.id,
        required this.name,
        required this.lastName,
        required this.mobileNo,
        required this.loginType,
        required this.department,
        required this.email,
        required this.contactPersonName,
        required this.userTypeId,
        required this.workPhone,
        required this.field,
        required this.displayName,
        required this.businessLeagalName,
        required this.taxPreference,
        required this.gstNo,
        required this.panNo,
        required this.website,
        required this.registrationType,
        required this.bio,
        required this.subField,
        required this.emrMobileNo,
        required this.photo,
        required this.education,
        required this.address,
        required this.remark,
        required this.attachments,
        required this.isDisabled,
        required this.password,
        required this.cPassword,
        required this.userType,
        required this.countryId,
        required this.date,
        required this.stateId,
        required this.cityId,
        required this.street1,
        required this.street2,
        required this.zipCode,
        required this.companyName,
        required this.contactPerson,
        required this.status,
        required this.workEmail,
        required this.fieldName,
        required this.otp,
        required this.otpVerify,
        required this.createdAt,
        required this.updatedAt,
    });

    Result copyWith({
        int? id,
        String? name,
        String? lastName,
        String? mobileNo,
        String? loginType,
        String? department,
        String? email,
        dynamic contactPersonName,
        String? userTypeId,
        dynamic workPhone,
        String? field,
        String? displayName,
        dynamic businessLeagalName,
        dynamic taxPreference,
        dynamic gstNo,
        dynamic panNo,
        dynamic website,
        dynamic registrationType,
        String? bio,
        dynamic subField,
        String? emrMobileNo,
        String? photo,
        String? education,
        String? address,
        dynamic remark,
        String? attachments,
        int? isDisabled,
        String? password,
        String? cPassword,
        String? userType,
        String? countryId,
        dynamic date,
        String? stateId,
        String? cityId,
        String? street1,
        String? street2,
        String? zipCode,
        dynamic companyName,
        dynamic contactPerson,
        String? status,
        dynamic workEmail,
        String? fieldName,
        int? otp,
        String? otpVerify,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Result(
            id: id ?? this.id,
            name: name ?? this.name,
            lastName: lastName ?? this.lastName,
            mobileNo: mobileNo ?? this.mobileNo,
            loginType: loginType ?? this.loginType,
            department: department ?? this.department,
            email: email ?? this.email,
            contactPersonName: contactPersonName ?? this.contactPersonName,
            userTypeId: userTypeId ?? this.userTypeId,
            workPhone: workPhone ?? this.workPhone,
            field: field ?? this.field,
            displayName: displayName ?? this.displayName,
            businessLeagalName: businessLeagalName ?? this.businessLeagalName,
            taxPreference: taxPreference ?? this.taxPreference,
            gstNo: gstNo ?? this.gstNo,
            panNo: panNo ?? this.panNo,
            website: website ?? this.website,
            registrationType: registrationType ?? this.registrationType,
            bio: bio ?? this.bio,
            subField: subField ?? this.subField,
            emrMobileNo: emrMobileNo ?? this.emrMobileNo,
            photo: photo ?? this.photo,
            education: education ?? this.education,
            address: address ?? this.address,
            remark: remark ?? this.remark,
            attachments: attachments ?? this.attachments,
            isDisabled: isDisabled ?? this.isDisabled,
            password: password ?? this.password,
            cPassword: cPassword ?? this.cPassword,
            userType: userType ?? this.userType,
            countryId: countryId ?? this.countryId,
            date: date ?? this.date,
            stateId: stateId ?? this.stateId,
            cityId: cityId ?? this.cityId,
            street1: street1 ?? this.street1,
            street2: street2 ?? this.street2,
            zipCode: zipCode ?? this.zipCode,
            companyName: companyName ?? this.companyName,
            contactPerson: contactPerson ?? this.contactPerson,
            status: status ?? this.status,
            workEmail: workEmail ?? this.workEmail,
            fieldName: fieldName ?? this.fieldName,
            otp: otp ?? this.otp,
            otpVerify: otpVerify ?? this.otpVerify,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        lastName: json["last_name"],
        mobileNo: json["mobile_no"],
        loginType: json["login_type"],
        department: json["department"],
        email: json["email"],
        contactPersonName: json["contact_person_name"],
        userTypeId: json["user_type_id"],
        workPhone: json["work_phone"],
        field: json["field"],
        displayName: json["display_name"],
        businessLeagalName: json["business_leagal_name"],
        taxPreference: json["tax_preference"],
        gstNo: json["gst_no"],
        panNo: json["pan_no"],
        website: json["website"],
        registrationType: json["registration_type"],
        bio: json["bio"],
        subField: json["sub_field"],
        emrMobileNo: json["emr_mobile_no"],
        photo: json["photo"],
        education: json["education"],
        address: json["address"],
        remark: json["remark"],
        attachments: json["attachments"],
        isDisabled: json["is_disabled"],
        password: json["password"],
        cPassword: json["c_password"],
        userType: json["user_type"],
        countryId: json["country_id"],
        date: json["date"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        street1: json["street_1"],
        street2: json["street_2"],
        zipCode: json["zip_code"],
        companyName: json["company_name"],
        contactPerson: json["contact_person"],
        status: json["status"],
        workEmail: json["work_email"],
        fieldName: json["field_name"],
        otp: json["otp"],
        otpVerify: json["otp_verify"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "last_name": lastName,
        "mobile_no": mobileNo,
        "login_type": loginType,
        "department": department,
        "email": email,
        "contact_person_name": contactPersonName,
        "user_type_id": userTypeId,
        "work_phone": workPhone,
        "field": field,
        "display_name": displayName,
        "business_leagal_name": businessLeagalName,
        "tax_preference": taxPreference,
        "gst_no": gstNo,
        "pan_no": panNo,
        "website": website,
        "registration_type": registrationType,
        "bio": bio,
        "sub_field": subField,
        "emr_mobile_no": emrMobileNo,
        "photo": photo,
        "education": education,
        "address": address,
        "remark": remark,
        "attachments": attachments,
        "is_disabled": isDisabled,
        "password": password,
        "c_password": cPassword,
        "user_type": userType,
        "country_id": countryId,
        "date": date,
        "state_id": stateId,
        "city_id": cityId,
        "street_1": street1,
        "street_2": street2,
        "zip_code": zipCode,
        "company_name": companyName,
        "contact_person": contactPerson,
        "status": status,
        "work_email": workEmail,
        "field_name": fieldName,
        "otp": otp,
        "otp_verify": otpVerify,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
