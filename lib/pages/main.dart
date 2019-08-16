import 'package:flutter/material.dart';
import 'home_page.dart';
import 'cart_page.dart';
import 'category_page.dart';
import 'personal_page.dart';
import 'eat_page.dart';
import 'package:flutter/services.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false, home: new MainPageWidget());
  }
}

class MainPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPageWidget>
    with SingleTickerProviderStateMixin {
  var _pageController;
  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = ['首页', '分类', '吃什么', '购物车', '我的'];

  /*
   * 存放三个页面，跟fragmentList一样
   */
  var _pageList;

  /*
   * 根据选择获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      print(_tabIndex);
      return Text(appBarTitles[curIndex],
          //color: const Color(0xd4237a))
          style: TextStyle(
              fontSize: 14.0, color: Color.fromRGBO(212, 35, 122, 1.0)));
    } else {
      return Text(appBarTitles[curIndex],
          style: TextStyle(
              fontSize: 14.0, color: Color.fromRGBO(138, 138, 138, 1.0)));
    }
  }

  /*
   * 根据image路径获取图片
   */
  Image getTabImage(path) {
    return Image.asset(path, width: 24.0, height: 24.0);
  }

  void initData() {
    _pageController = new PageController(initialPage: 0);
    /*
     * 初始化选中和未选中的icon
     */
    tabImages = [
      [
        getTabImage('images/index_unchecked.png'),
        getTabImage('images/index_checked.png')
      ],
      [
        getTabImage('images/category_unchecked.png'),
        getTabImage('images/category_checked.png')
      ],
      [
        getTabImage('images/eat_unchecked.png'),
        getTabImage('images/eat_checked.png')
      ],
      [
        getTabImage('images/cart_unchecked.png'),
        getTabImage('images/cart_checked.png')
      ],
      [
        getTabImage('images/me_unchecked.png'),
        getTabImage('images/me_checked.png')
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
                  icon: getTabIcon(0), title: getTabTitle(0)),
              BottomNavigationBarItem(
                  icon: getTabIcon(1), title: getTabTitle(1)),
              BottomNavigationBarItem(
                  icon: getTabIcon(2), title: getTabTitle(2)),
              BottomNavigationBarItem(
                icon: getTabIcon(3),
                title: getTabTitle(3),
              ),
              BottomNavigationBarItem(
                  icon: getTabIcon(4), title: getTabTitle(4))
            ],
          ),
          body: PageView(
            controller: _pageController,
            children: _pageList,
            onPageChanged: (index) {
              _tabIndex = index;
            },
          ),
        ),
      ),
    );
  }
}
