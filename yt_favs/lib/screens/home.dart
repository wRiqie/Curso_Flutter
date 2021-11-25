import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:yt_favs/blocs/favorite_bloc.dart';
import 'package:yt_favs/blocs/videos_bloc.dart';
import 'package:yt_favs/delegates/data_search.dart';
import 'package:yt_favs/models/video.dart';
import 'package:yt_favs/screens/favorites.dart';
import 'package:yt_favs/widgets/video_tile.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 25,
          child: Image.asset(
            'images/yt_logo.png',
            fit: BoxFit.cover,
          ),
        ),
        elevation: 0,
        actions: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              stream: BlocProvider.getBloc<FavoriteBlock>().outFav,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Text(snapshot.data!.length.toString());
                }
                else{
                  return Container();
                }
              },
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Favorites()));
            },
            icon: const Icon(Icons.star),
          ),
          IconButton(
            onPressed: () async {
              var result =
                  await showSearch(context: context, delegate: DataSearch());
              if (result != null) {
                BlocProvider.getBloc<VideosBloc>().inSearch.add(result);
              }
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: StreamBuilder(
        initialData: [],
        stream: BlocProvider.getBloc<VideosBloc>().outVideos,
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length + 1,
              itemBuilder: (context, index){
                if(index < snapshot.data.length){
                  return VideoTile(snapshot.data[index]);
                }
                else if (index > 1) {
                  BlocProvider.getBloc<VideosBloc>().inSearch.add('');
                  return Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                }
                else{
                  return Container();
                }
            });
          }
          else{
            return Container();
          }
        },
      ),
    );
  }
}
