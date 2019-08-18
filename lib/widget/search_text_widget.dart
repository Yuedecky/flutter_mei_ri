import 'package:flutter/material.dart';

class SearchBarDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = "";
          showSuggestions(context);
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return null;
  }
}

class SearchTextFieldWidget extends StatelessWidget {
  final ValueChanged<String> onSubmitted;
  final VoidCallback onTab;

  final String hintText;

  final EdgeInsetsGeometry margin;

  SearchTextFieldWidget(
      {Key key, this.hintText, this.onSubmitted, this.onTab, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin == null ? EdgeInsets.all(0.0) : margin,
      width: MediaQuery.of(context).size.width,
      alignment: AlignmentDirectional.center,
      height: 37.0,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        onSubmitted: onSubmitted,
        onTap: onTab,

        cursorColor: Color.fromARGB(255, 0, 189, 96),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 20,
            color: Color.fromARGB(255, 128, 128, 128),
          ),
        ),
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
