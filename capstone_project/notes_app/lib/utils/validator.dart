class Validator {
  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Title cannot be empty!';
    }
    if (value.trim().length < 3) {
      return 'Title must be at least 3 characters long!';
    }
    return null;
  }
}