enum Routes {
  login(
    path: '/',
    name: 'login',
    title: 'Login'
  ),
  home(
    path: '/home',
    name: 'home',
    title: 'Home'
  ),

  ;

  final String path, name;
  final String? title;
  const Routes({
    required this.name,
    required this.path,
    this.title,
  });

  /// removes the first '/' in [path]
  ///
  /// `return path.replaceFirst('/', '');`
  String get subpath {
    return path.replaceFirst('/', '');
  }

  /// returns new route name with a given [parentName]
  ///
  /// `return '$parentName-$name'`
  String subname(String parentName) {
    return '$parentName-$name';
  }
}