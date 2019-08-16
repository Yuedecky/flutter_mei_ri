import 'package:flutter/material.dart';
import '../components/search_text_widget.dart';
import '../components/category_scroll.dart';

class CategoryPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SearchTextFieldWidget(
                margin: EdgeInsets.all(10),
                hintText: "进口山竹9.9元",
                onTab:(){

                }
            ),
            Expanded(
              child: _CategoryWidget(),
            )

          ],
        ),
      ),
    );
  }
}


class _CategoryWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CategoryWidgetState();
  }

}

class _CategoryWidgetState extends State<_CategoryWidget>{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CategoryItemScroll()
        ],
      ),
    );
  }
}
