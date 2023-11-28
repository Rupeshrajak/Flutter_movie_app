enum PageStatus {
  /// Initial status of the page, it is also a default status of the page.
  initial,

  /// [PageStatus.loading] indicates that API call is in progress and a circular
  /// progress indicator needs to be shown.
  loading,

  /// [PageStatus.success] indicates that data has been loaded successfully.
  success,

  /// [PageStatus.failure] indicates that there is some issue in loading the data.
  failure,

  /// [PageStatus.warning] indicates that there is some info to show.
  info,

  /// [PageStatus.unAuthorized] indicates that the user's access token has been expired.
  /// Hence user will be forcibly logged out.
  unAuthorized,

  /// [PageStatus.loadMoreFailed] indicates that there is some issue while loading
  /// more data.
  loadMoreFailed,

  /// [PageStatus.loadMoreNoData] indicates that an API call to get more data has
  /// been made and there is no more data available.
  loadMoreNoData,

  /// [PageStatus.loadMoreSuccess] indicates that more data has been loaded successfully.
  loadMoreSuccess,
  refreshSuccess,
  refreshFailed
}
