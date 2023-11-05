class TestServerData {
      String? server;

  TestServerData({
      this.server,
  });

  TestServerData.fromJson(Map<String, dynamic> json) {
      server = json['server'];
      
  }

  static TestServerData initialTelNumber() {
    return TestServerData(
      server: '- -  - -',
    );
  }
}