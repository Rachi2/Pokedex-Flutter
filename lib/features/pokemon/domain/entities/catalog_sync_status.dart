enum SyncState { idle, syncing, success, error }

class CatalogSyncStatus {
  const CatalogSyncStatus({
    required this.state,
    this.lastSyncedAt,
    this.hasMorePages = true,
  });

  final SyncState state;

  /// null si nunca se ha sincronizado.
  final DateTime? lastSyncedAt;

  /// false cuando ya se descargó la última página.
  final bool hasMorePages;

  @override
  bool operator ==(Object other) =>
      other is CatalogSyncStatus &&
      other.state == state &&
      other.lastSyncedAt == lastSyncedAt &&
      other.hasMorePages == hasMorePages;

  @override
  int get hashCode => Object.hash(state, lastSyncedAt, hasMorePages);
}
