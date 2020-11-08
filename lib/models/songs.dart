class Song {
  String _name;
  String _artistName;
  String _url ;
  String _audioURL;

  String get audioURL => _audioURL;

  set audioURL(String value) {
    _audioURL = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get artistName => _artistName;

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  set artistName(String value) {
    _artistName = value;
  }

  @override
  String toString() {
    return 'Song{_name: $_name, _artistName: $_artistName, _url: $_url}';
  }
}