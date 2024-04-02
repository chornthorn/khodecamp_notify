class AppVersionResponse {
  late final int id;
  late final String? version;
  late final String? description;
  late final String? storeUrl;
  late final String appCastUrl;
  late final String? platform;
  late final int priority;
  late final bool current;
  late final bool isActive;
  late final bool upToDate;
  late final String? minAppVersion;

  AppVersionResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
    description = json['description'];
    storeUrl = json['storeUrl'];
    appCastUrl = json['appCastUrl'];
    platform = json['platform'];
    priority = json['priority'];
    current = json['current'];
    isActive = json['isActive'];
    upToDate = json['upToDate'] ?? false;
    minAppVersion = json['minAppVersion'];
  }
}
