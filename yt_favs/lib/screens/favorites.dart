import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:yt_favs/blocs/favorite_bloc.dart';
import 'package:yt_favs/models/video.dart';
import 'package:yt_favs/screens/video_player.dart';

class Favorites extends StatelessWidget {
  final bloc = BlocProvider.getBloc<FavoriteBlock>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favoritos',
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<Map<String, Video>>(
        stream: bloc.outFav,
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return ListView(
            children: snapshot.data?.values.map<Widget>((v) {
              return InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => VideoPlayer(v.id)));
                },
                onLongPress: (){
                  bloc.toggleFavorite(v);
                },
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(v.thumb),
                    ),
                    Expanded(
                      child: Text(
                        v.title,
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
