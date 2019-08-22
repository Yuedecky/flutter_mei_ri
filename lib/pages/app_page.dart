import 'package:flutter/material.dart';
import 'package:flutter_mei_ri/pages/index/home_page.dart';
import 'cart_page.dart';
import 'category_page.dart';
import 'personal_page.dart';
import 'eat_page.dart';
import 'package:flutter/services.dart';

class AppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false, home: AppPageWidget());
  }
}

class AppPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppPageState();
  }
}

class AppPageState extends State<AppPageWidget>
    with SingleTickerProviderStateMixin {
  var _pageController;
  int _tabIndex = 0;
  var _tabImages;
  var _appBarTitles = ['首页', '分类', '吃什么', '购物车', '我的'];

  /*
   * 存放三个页面，跟fragmentList一样
   */
  var _pageList;

  /*
   * 根据选择获得对应的normal或是press的icon
   */
  Image _getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return _tabImages[curIndex][1];
    }
    return _tabImages[curIndex][0];
  }

  /*
   * 获取bottomTab的颜色和文字
   */
  Text _getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return Text(_appBarTitles[curIndex],
          //color: const Color(0xd4237a))
          style: TextStyle(
              fontSize: 14.0, color: Color.fromRGBO(212, 35, 122, 1.0)));
    } else {
      return Text(_appBarTitles[curIndex],
          style: TextStyle(
              fontSize: 14.0, color: Color.fromRGBO(138, 138, 138, 1.0)));
    }
  }

  /*
   * 根据image路径获取图片
   */
  Image _getTabImage(path) {
    return Image.asset(path, width: 24.0, height: 24.0);
  }

  void initData() {
    _pageController = new PageController(initialPage: 0);
    /*
     * 初始化选中和未选中的icon
     */
    _tabImages = [
      [
        _getTabImage('images/index_unchecked.png'),
        _getTabImage('images/index_checked.png')
      ],
      [
        _getTabImage('images/category_unchecked.png'),
        _getTabImage('images/category_checked.png')
      ],
      [
        _getTabImage('images/eat_unchecked.png'),
        _getTabImage('images/eat_checked.png')
      ],
      [
        _getTabImage('images/cart_unchecked.png'),
        _getTabImage('images/cart_checked.png')
      ],
      [
        _getTabImage('images/me_unchecked.png'),
        _getTabImage('images/me_checked.png')
      ]
    ];
    /*
     * 三个子界面
     */
    _pageList = [
      new HomePage(),
      new CategoryPage(),
      new EatPage(),
      new CartPage(),
      new PersonalPage()
    ];
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  //这是监听安卓的返回键操作
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('退出App?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('不'),
              ),
              new FlatButton(
                onPressed: () async {
                  await pop();
                },
                child: new Text('是的'),
              ),
            ],
          ),
        ) ??
        false;
  }

  static Future<void> pop() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            //默认选中首页
            currentIndex: _tabIndex,
            iconSize: 24.0,
            //点击事件
            onTap: (index) {
              setState(() {
                _tabIndex = index;
              });
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 500),
                  curve: new ElasticOutCurve(4));
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: _getTabIcon(0), title: _getTabTitle(0)),
              BottomNavigationBarItem(
                  icon: _getTabIcon(1), title: _getTabTitle(1)),
              BottomNavigationBarItem(
                  icon: _getTabIcon(2), title: _getTabTitle(2)),
              BottomNavigationBarItem(
                icon: _getTabIcon(3), title: _getTabTitle(3),
              ),
              BottomNavigationBarItem(
                  icon: _getTabIcon(4), title: _getTabTitle(4))
            ],
          ),
          body: PageView(
            controller: _pageController,
            children: _pageList,
          ),
        ),
      ),
    );
  }
}
