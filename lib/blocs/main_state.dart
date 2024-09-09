part of 'main_cubit.dart';

class MainState extends Equatable {
  const MainState({
    this.appVersion = '',
    this.apiUrl = '',
  });

  const MainState.initial()
      : appVersion = '',
        apiUrl = '';

  final String? appVersion;
  final String? apiUrl;

  MainState copyWith({
    String? appVersion,
    String? apiUrl,
  }) {
    return MainState(
      appVersion: appVersion ?? this.appVersion,
      apiUrl: apiUrl ?? this.apiUrl,
    );
  }

  @override
  List<Object?> get props => [
        appVersion,
        apiUrl,
      ];
}
