import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {
  TextComposer(this.sendMessage);

  final Function({String text, XFile imgFile}) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final ImagePicker _picker = ImagePicker();

  TextEditingController _controller = TextEditingController();

  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
              final XFile? imgFile =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (imgFile == null)
                return;
              else {
                widget.sendMessage(imgFile: imgFile);
              }
            },
            icon: const Icon(Icons.photo_camera),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration.collapsed(
                hintText: 'Enviar uma mensagem',
              ),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                widget.sendMessage(text: text);
                _reset();
              },
            ),
          ),
          IconButton(
            onPressed: _isComposing
                ? () {
                    widget.sendMessage(text: _controller.text);
                    _reset();
                  }
                : null,
            icon: const Icon(Icons.send),
          )
        ],
      ),
    );
  }

  void _reset() {
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }
}
