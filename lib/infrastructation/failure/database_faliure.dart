class DatabaseFaliure implements Exception {
  final String message;
  const DatabaseFaliure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory DatabaseFaliure.fromCode(String code) {
    switch (code) {
      case 'asd':
        return const DatabaseFaliure(
          'asd',
        );
      default:
        return const DatabaseFaliure();
    }
  }
}
