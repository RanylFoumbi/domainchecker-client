import 'package:domainavailability/components/about.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class BigContainer extends StatefulWidget {
  @override
  _BigContainerState createState() => _BigContainerState();
}

class _BigContainerState extends State<BigContainer>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  PageController _pageController;
  List<Widget> _screenList = [HomePage(), AboutPage()];

/*when init component*/
  @override
  void initState() {
    _pageController = new PageController();
    super.initState();
  }

  /*On item click in the nav bar*/
  void _onTap(index) async {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: new Stack(children: <Widget>[
          new Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(bottom: 0),
            child: new PageView(
              children: _screenList,
              controller: _pageController,
              onPageChanged: (index) => setState(() {
                _selectedIndex = index;
              }),
              // allowImplicitScrolling: true,
            ),
          ),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedItemColor: Colors.blue[900],
          unselectedItemColor: Colors.black.withOpacity(0.5),
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.easeIn);
          }),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              activeIcon: Icon(Icons.home, color: Colors.blue[900]),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.more,
                size: 27,
              ),
              title: Text("About"),
              activeIcon: Icon(Icons.more, size: 27, color: Colors.blue[900]),
            ),
          ],
        ));
  }

  /*when the component die*/
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
