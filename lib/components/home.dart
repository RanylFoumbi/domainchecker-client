import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:domainavailability/Animation/FadeAnimation.dart';
import 'package:domainavailability/Api/apiCaller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_moment/simple_moment.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _domainList = [];
  bool _isLoading = false;
  TextEditingController domainController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 225,
              decoration: BoxDecoration(color: Colors.deepOrange),
              child: Container(
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(begin: Alignment.bottomRight, colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.2),
                ])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FadeAnimation(
                        1,
                        AutoSizeText(
                          "Would you like to check a domain name availability?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                          maxLines: 2,
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    FadeAnimation(
                        1.3,
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 3),
                            margin: EdgeInsets.symmetric(horizontal: 18),
                            height: 50,
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          topLeft: Radius.circular(15)),
                                      color: Colors.white,
                                    ),
                                    child: TextField(
                                      controller: domainController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: Colors.grey,
                                          ),
                                          hintStyle: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                          hintText: "Search for domain.com"),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (!_isLoading) {
                                        print(domainController.text);
                                        if (domainController.text.length == 0) {
                                        } else {
                                          setState(() {
                                            _domainList = [];
                                            _isLoading = true;
                                          });
                                          ApiCaller()
                                              .fetchDomains(
                                                  domainController.text)
                                              .then((res) {
                                            setState(() {
                                              _domainList = res;
                                              _isLoading = false;
                                            });
                                            print(res);
                                            print(_domainList);
                                          }).catchError((err) {
                                            print(err);
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          });
                                        }
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(15),
                                              topRight: Radius.circular(15)),
                                          color: Colors.blue[900]),
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: _isLoading
                                          ? SpinKitThreeBounce(
                                              color: Colors.white,
                                              size: 18,
                                            )
                                          : Text(
                                              'Search',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                    ),
                                  ),
                                )
                              ],
                            ))),
                    Container(
                        height: 35,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: FadeAnimation(
                          1.2,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Badge(
                                badgeContent: Text(
                                  _domainList.length.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.blue[900]),
                                ),
                                padding: EdgeInsets.all(10),
                                animationType: BadgeAnimationType.fade,
                                toAnimate: true,
                                shape: BadgeShape.square,
                                badgeColor: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                animationDuration: new Duration(seconds: 5),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Results',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Container(
              // alignment: Alignment.topCenter,
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1.4,
                      Container(
                          height: MediaQuery.of(context).size.height,
                          // alignment: Alignment.center,
                          // padding: EdgeInsets.only(top: 15),
                          child: _isLoading
                              ? Container(
                                  height: 100,
                                  alignment: Alignment.topCenter,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 100, horizontal: 50),
                                  child: SpinKitFadingCube(
                                    color: Colors.deepOrange,
                                    size: 50,
                                  ))
                              : _domainList.length == 0
                                  ? Container(
                                      height: 100,
                                      alignment: Alignment.topCenter,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 200, horizontal: 50),
                                      child: AutoSizeText(
                                        "Sorry no results found for" +
                                            '  ' +
                                            domainController.text,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.all(2),
                                      itemCount: _domainList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.only(
                                              top: 12,
                                              bottom:
                                                  index == _domainList.length
                                                      ? 200
                                                      : 0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                offset: Offset(1,
                                                    2.5), // changes position of shadow
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                flex: 2,
                                                fit: FlexFit.tight,
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Domaine:",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontSize: 11.5),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Expanded(
                                                            child: AutoSizeText(
                                                              _domainList[index]
                                                                  ['domain'],
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0Xff755800),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                              maxLines: 2,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Hosting country:",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontSize: 11.5),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              _domainList[index]
                                                                          [
                                                                          'country'] ==
                                                                      null
                                                                  ? 'Not specify'
                                                                  : _domainList[
                                                                          index]
                                                                      [
                                                                      'country'],
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0Xff755800),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Added date:",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontSize: 11.5),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              _domainList[index]
                                                                          [
                                                                          'create_date'] ==
                                                                      null
                                                                  ? 'Not specify'
                                                                  : Moment.parse(
                                                                          _domainList[index]
                                                                              [
                                                                              'create_date'])
                                                                      .format(
                                                                          "dd-MM-yyyy HH:mm"),
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0Xff755800),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Last update:",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontSize: 11.5),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              _domainList[index]
                                                                          [
                                                                          'update_date'] ==
                                                                      null
                                                                  ? 'Not specify'
                                                                  : Moment.parse(
                                                                          _domainList[index]
                                                                              [
                                                                              'update_date'])
                                                                      .format(
                                                                          "dd-MM-yyyy HH:mm"),
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0Xff755800),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                fit: FlexFit.tight,
                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Badge(
                                                        badgeContent: Text(
                                                          _domainList[index][
                                                                      'isDead'] ==
                                                                  'True'
                                                              ? 'Available'
                                                              : 'Unavailable',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        animationType:
                                                            BadgeAnimationType
                                                                .fade,
                                                        toAnimate: true,
                                                        shape:
                                                            BadgeShape.square,
                                                        badgeColor: _domainList[
                                                                        index][
                                                                    'isDead'] ==
                                                                'True'
                                                            ? Colors.green
                                                            : Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        animationDuration:
                                                            new Duration(
                                                                seconds: 5),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
