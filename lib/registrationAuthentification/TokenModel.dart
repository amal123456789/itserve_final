class TokenModel {
  final String accessToken;
  final String tokenType;
  final String scope;
  final String sessionState;
  final int notBeforePolicy;
  final List<dynamic> role;
  final String name;
  final String email;
  TokenModel(
      {this.accessToken,
      this.tokenType,
      this.scope,
      this.sessionState,
      this.notBeforePolicy,
      this.role,
      this.name,
      this.email});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['accessToken'],
      tokenType: json['tokenType'],
      scope: json['scope'],
      sessionState: json['session_state'],
      notBeforePolicy: json['not-before-policy'],
      role: json['roles'],
      name: json['username'],
      email: json['email'],
    );
  }
}
