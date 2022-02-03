class SignUpWithEmailAndPasswordFailure implements Exception {
  final String message;
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'The email address is already in use by another account.',
        );
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid',
        );
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
