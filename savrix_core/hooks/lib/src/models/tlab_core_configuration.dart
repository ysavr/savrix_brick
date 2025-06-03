import 'package:equatable/equatable.dart';
import 'package:tlab_core_hooks/tlab_core_hooks.dart';

/// The variables specified by this hook.
///
/// The variables can be found in the Brick's `brick.yaml` file. They are
/// initially included in the `HookContext.vars` map.
///
/// See also:
///
/// * [brick.yaml documentation](https://docs.brickhub.dev/brick-structure#brickyaml)
enum _tlabCoreConfigurationVariables {
  /// {@template tlab_core_configuration_variables.project_name}
  /// The project name.
  ///
  /// Defaults to `my_app`.
  /// {@endtemplate}
  projectName._('project_name'),

  /// {@template tlab_core_configuration_variables.application_name}
  /// The project name.
  ///
  /// Defaults to `my_app`.
  /// {@endtemplate}
  applicationName._('application_name'),

  /// {@template tlab_core_configuration_variables.organization_name}
  /// The organization name.
  ///
  /// Defaults to `com.example`.
  /// {@endtemplate}
  organizationName._('org_name'),

  /// {@template tlab_core_configuration_variables.application_id}
  /// The application id on Android, Bundle ID on iOS and company name on
  /// Windows. If omitted value will be formed by org_name + . + project_name.
  ///
  /// Has no default specified within the `brick.yaml`.
  /// {@endtemplate}
  applicationId._('application_id'),

  /// {@template tlab_core_configuration_variables.description}
  /// A short project description.
  ///
  /// Defaults to `A Very Good App`.
  /// {@endtemplate}
  description._('description');

  const _tlabCoreConfigurationVariables._(this.key);

  /// The key used in the `HookContext.vars` [Map].
  ///
  /// This should match the variable key in the `brick.yaml`.
  final String key;
}

/// {@template tlab_core_configuration}
/// Configuration for the `tlab_core` brick.
/// {@endtemplate}
class TlabCoreConfiguration extends Equatable {
  /// {@macro tlab_core_configuration}
  TlabCoreConfiguration({
    String? projectName,
    String? applicationName,
    String? organizationName,
    String? description,
    WindowsApplicationId? windowsApplicationId,
    AppleApplicationId? iOsApplicationId,
    AppleApplicationId? macOsApplicationId,
    AndroidApplicationId? androidApplicationId,
    AndroidNamespace? androidNamespace,
  })  : projectName = projectName ?? 'my_app',
        organizationName = organizationName ?? 'com.example',
        description = description ?? 'A TLab App',
        applicationName = ApplicationName.fallback(
            applicationName: applicationName ?? '',
            projectName: projectName ?? 'my_app') {
    this.windowsApplicationId = windowsApplicationId ??
        WindowsApplicationId.fallback(
          organizationName: this.organizationName,
          projectName: this.projectName,
        );
    this.iOsApplicationId = iOsApplicationId ??
        AppleApplicationId.fallback(
          organizationName: this.organizationName,
          projectName: this.projectName,
        );
    this.macOsApplicationId = macOsApplicationId ??
        AppleApplicationId.fallback(
          organizationName: this.organizationName,
          projectName: this.projectName,
        );
    this.androidApplicationId = androidApplicationId ??
        AndroidApplicationId.fallback(
          organizationName: this.organizationName,
          projectName: this.projectName,
        );
    if (!this.androidApplicationId.isValid) {
      throw InvalidAndroidApplicationIdFormat(this.androidApplicationId);
    }

    this.androidNamespace = androidNamespace ??
        AndroidNamespace.fromApplicationId(this.androidApplicationId);
  }

  /// Deserializes a [tlabCoreConfiguration] from a `Map<String, dynamic>`
  /// used to represent the configuration in the `HookContext.vars` map.
  factory TlabCoreConfiguration.fromHookVars(Map<String, dynamic> vars) {
    final projectName = vars[_tlabCoreConfigurationVariables.projectName.key];
    if (projectName is! String?) {
      throw ArgumentError.value(
        vars,
        'vars',
        '''Expected a value for key "${_tlabCoreConfigurationVariables.projectName.key}" to be of type String?, got $projectName.''',
      );
    }

    final applicationName =
        vars[_tlabCoreConfigurationVariables.applicationName.key];
    if (applicationName is! String) {
      throw ArgumentError.value(
        vars,
        'vars',
        '''Expected a value for key "${_tlabCoreConfigurationVariables.applicationName.key}" to be of type String?, got $applicationName.''',
      );
    }

    final organizationName =
        vars[_tlabCoreConfigurationVariables.organizationName.key];
    if (organizationName is! String?) {
      throw ArgumentError.value(
        vars,
        'vars',
        '''Expected a value for key "${_tlabCoreConfigurationVariables.organizationName.key}" to be of type String?, got $organizationName.''',
      );
    }

    final applicationId =
        vars[_tlabCoreConfigurationVariables.applicationId.key];
    if (applicationId is! String?) {
      throw ArgumentError.value(
        vars,
        'vars',
        '''Expected a value for key "${_tlabCoreConfigurationVariables.applicationId.key}" to be of type String?, got $applicationId.''',
      );
    }

    final description = vars[_tlabCoreConfigurationVariables.description.key];
    if (description is! String?) {
      throw ArgumentError.value(
        vars,
        'vars',
        '''Expected a value for key "${_tlabCoreConfigurationVariables.description.key}" to be of type String?, got $description.''',
      );
    }

    return TlabCoreConfiguration(
      projectName: projectName,
      applicationName: applicationName.isEmpty ? "" : applicationName,
      organizationName: organizationName,
      iOsApplicationId: applicationId == null || applicationId.isEmpty
          ? null
          : AppleApplicationId(applicationId),
      macOsApplicationId: applicationId == null || applicationId.isEmpty
          ? null
          : AppleApplicationId(applicationId),
      windowsApplicationId: applicationId == null || applicationId.isEmpty
          ? null
          : WindowsApplicationId(applicationId),
      androidApplicationId: applicationId == null || applicationId.isEmpty
          ? null
          : AndroidApplicationId(applicationId),
      description: description,
    );
  }

  /// {@macro tlab_core_configuration_variables.project_name}
  final String projectName;

  /// {@macro tlab_core_configuration_variables.application_name}
  final String applicationName;

  /// {@macro tlab_core_configuration_variables.organization_name}
  final String organizationName;

  /// {@macro tlab_core_configuration_variables.description}
  final String description;

  /// {@macro windows_application_id}
  late final WindowsApplicationId windowsApplicationId;

  /// {@macro apple_application_id}
  late final AppleApplicationId iOsApplicationId;

  /// {@macro apple_application_id}
  late final AppleApplicationId macOsApplicationId;

  /// {@macro android_namespace}
  late final AndroidNamespace androidNamespace;

  /// {@macro android_application_id}
  late final AndroidApplicationId androidApplicationId;

  @override
  List<Object?> get props => [
        projectName,
        applicationName,
        organizationName,
        description,
        windowsApplicationId,
        iOsApplicationId,
        macOsApplicationId,
        androidNamespace,
        androidApplicationId,
      ];
}
