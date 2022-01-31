class SignUpWithEmailAndPasswordFailure implements Exception {
  final String message;
  const SignUpWithEmailAndPasswordFailure(
      [this.message = 'An unknow exception occured', ]);

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure('Email is not valid');
      case 'email-already-in-use':

        return const SignUpWithEmailAndPasswordFailure('error.',);
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
            'Enter More reliable password');
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
            'Operation is not allowed');
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}