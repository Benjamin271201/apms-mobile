class LoginRepo {
  Future<void> login(String phoneNumber, String password) async {
    print('Loging in----');
    await Future.delayed(const Duration(seconds: 2));
    print('Loged In');
  }
}
