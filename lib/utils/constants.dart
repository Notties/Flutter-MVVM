// ignore_for_file: constant_identifier_names

import 'package:flutter_mvvm/users_list/models/users_list_model.dart';

const String USERS_LIST = 'https://jsonplaceholder.typicode.com/users';

//Success
const SUCCESS_CODE = 200;

//Errors
const USER_INVALID_RESPONSE = 100;
const NO_INTERNET = 101;
const INVALID_FORMAT = 102;
const UNKNOW_ERROR = 103;

//Default Users
UserModel defaultUser = UserModel(
  id: 0,
  name: '',
  username: '',
  email: '',
  address: Address(
    street: '',
    suite: '',
    city: '',
    zipcode: '',
    geo: Geo(lat: '', lng: ''),
  ),
  phone: '',
  website: '',
  company: Company(
    name: '',
    catchPhrase: '',
    bs: '',
  ),
);
