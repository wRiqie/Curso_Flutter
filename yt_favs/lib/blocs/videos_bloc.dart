import 'dart:async';
import 'dart:ui';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:yt_favs/api.dart';
import 'package:yt_favs/models/video.dart';

class VideosBloc implements BlocBase{
  late Api api;

  List<Video>? videos;

  final StreamController<List<Video>?> _videosController = StreamController<List<Video>?>();
  Stream get outVideos => _videosController.stream;

  final StreamController<String> _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  VideosBloc(){
    api = Api();

    _searchController.stream.listen((data) => _search(data));
  }

  void _search(String search) async {
    if(search.isNotEmpty){
      _videosController.sink.add([]);
      videos = await api.search(search);
    } else{
      videos = videos! + await api.nextPage();
    }
    
    _videosController.sink.add(videos);
  }

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }

}