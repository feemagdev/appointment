class Client {
  final String _clientID;
  final String _phone;
  final String _lastName;
  final String _firstName;
  final String _address;
  final String _city;
  final String _state;
  final String _zipCode;

  Client.fromMap(Map snapshot, String clientID)
      : _clientID = clientID,
        _phone = snapshot['phone'],
        _lastName = snapshot['last_name'],
        _firstName = snapshot['first_name'],
        _address = snapshot['address'],
        _city = snapshot['city'],
        _state = snapshot['state'],
        _zipCode = snapshot['zip_code'];

  String getClientID() {
    return _clientID;
  }

  String getPhone() {
    return _phone;
  }

  String getLastName() {
    return _lastName;
  }

  String getFirstName() {
    return _firstName;
  }

  String getAddress() {
    return _address;
  }

  String getCity() {
    return _city;
  }

  String getState() {
    return _state;
  }

  String getZipCode() {
    return _zipCode;
  }
}
