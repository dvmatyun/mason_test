final apiRouteParameterWildcard = RegExp(r'\{(.*?)\}');

/// Every ApiRoute consists of FetchMethod, relative url path and resulting model json deserialize function
/// To insert a custom parameter into the path url, use the wildcard with curly brackets in the url string
/// If URL is not supposed to return any model, use [EmptyResponse.factory] as a default factory
/// By default, all requests expect to have a security token in header - to disable this rule, explicitly change [isSecure] to false
enum ApiRoute<ReturnedModel> {
  /// Auth
  authRequestSmsCode(FetchMethod.post, '/api_client/passwordless/start', EmptyResponse.factory,
      isSecure: false); // Or: SmsRequestResponse.fromJson instead of EmptyResponse.factory

  const ApiRoute(
    this.method,
    String path,
    this.modelFactory, {
    this.isSecure = true,
  }) : _path = path;

  final String _path;
  final FetchMethod method;
  final bool isSecure;

  /// Function for extracting Model class out of response JSON
  /// In case no model expected in the result, use [EmptyResponse.factory]
  final ReturnedModel Function(Map<String, dynamic> json) modelFactory;

  Type get modelType => ReturnedModel;

  /// [args] parameter replaces all wildcards in the path
  /// wildcards match as pair of curly brackets
  /// i.e. path '/api/{wildcardedParam}/fetch' with args == ['1'] will result in '/api/1/fetch'
  String getPath(List<String>? args) {
    if (args == null) return _path;
    var replaced = _path;
    for (var str in args) {
      replaced = replaced.replaceFirst(apiRouteParameterWildcard, str);
    }
    return replaced;
  }
}

enum FetchMethod {
  get,
  post,
  put,
  delete;
}

/// Stub class to act as a returned model for API requests that are not expected to yield any model in the result
class EmptyResponse {
  const EmptyResponse();

  factory EmptyResponse.factory(Map<String, dynamic> json) => const EmptyResponse();
}
