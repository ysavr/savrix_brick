extension ApplicationName on String {
  static String fallback({
    required String applicationName,
    required String projectName,
  }) {
    return applicationName.isEmpty ? projectName : applicationName;
  }
}