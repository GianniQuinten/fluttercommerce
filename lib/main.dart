import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

const double fem = 1.0; // Adjust the value as needed

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Add your design widgets here
            CustomContent(),
          ],
        ),
      ),
    );
  }
}

class CustomContent extends StatelessWidget {
  const CustomContent({Key? key});

  @override
  Widget build(BuildContext context) {
    // Implement your content design here
    return Container(
          // homepagezSf (24:214)
          padding:  EdgeInsets.fromLTRB(72*fem, 22*fem, 72*fem, 170*fem),
          width:  double.infinity,
          decoration:  BoxDecoration (
            color:  Color(0xffffffff),
          ),
          child:
          Column(
            crossAxisAlignment:  CrossAxisAlignment.center,
            children:  [
              Container(
                // navbarheader2G9H (8:131)
                margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 116*fem),
                padding:  EdgeInsets.fromLTRB(32*fem, 16*fem, 0*fem, 0*fem),
                width:  double.infinity,
                height:  72*fem,
                decoration:  BoxDecoration (
                  color:  Color(0xff89aae6),
                  borderRadius:  BorderRadius.circular(20*fem),
                  boxShadow:  [
                    BoxShadow(
                      color:  Color(0x260d1a26),
                      offset:  Offset(0*fem, 2*fem),
                      blurRadius:  3*fem,
                    ),
                  ],
                ),
                child:
                Row(
                  crossAxisAlignment:  CrossAxisAlignment.center,
                  children:  [
                    Container(
                      // frame5J5y (I8:131;419:2885)
                      margin:  EdgeInsets.fromLTRB(0*fem, 6*fem, 798*fem, 0*fem),
                      padding:  EdgeInsets.fromLTRB(0*fem, 0*fem, 82*fem, 0*fem),
                      height:  50.39*fem,
                      child:
                      Row(
                        crossAxisAlignment:  CrossAxisAlignment.start,
                        children:  [
                          Container(
                            // autogroupagpkzDh (PwC3JUcWr6gHu8c5ovAGpK)
                            margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 46*fem, 0*fem),
                            width:  60*fem,
                            height:  double.infinity,
                            child:
                            Text(
                              'Home',
                              style: GoogleFonts.inter(
                                fontSize: 20 * fem,
                                fontWeight: FontWeight.w400,
                                height: 1.5 * fem / fem,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                          Container(
                            // doextraszN7 (I8:131;419:2894)
                            margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 50*fem, 0*fem),
                            child:
                            Text(
                              'Shoes',
                              style: GoogleFonts.inter(
                                fontSize: 20 * fem,
                                fontWeight: FontWeight.w400,
                                height: 1.5 * fem / fem,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                          Text(
                            // docontactusgkj (I8:131;419:2896)
                            'Contact',
                            style: GoogleFonts.inter(
                              fontSize: 20 * fem,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * fem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // actionsDVm (I8:131;419:2897)
                      margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 16*fem),
                      width:  168*fem,
                      height:  40*fem,
                      decoration:  BoxDecoration (
                        borderRadius:  BorderRadius.circular(4*fem),
                      ),
                      child:
                      Container(
                        // button98X (I8:131;419:2898)
                        padding:  EdgeInsets.fromLTRB(16*fem, 6*fem, 16*fem, 8*fem),
                        width:  double.infinity,
                        height:  double.infinity,
                        decoration:  BoxDecoration (
                          color:  Color(0xff246eb9),
                          borderRadius:  BorderRadius.circular(4*fem),
                        ),
                        child:
                        ButtonTheme(
                          height:  double.infinity,
                          child:
                          Center(
                            child:
                            Text(
                              'My Cart',
                              style: GoogleFonts.inter(
                                fontSize: 20 * fem,
                                fontWeight: FontWeight.w400,
                                height: 1.5 * fem / fem,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // autogroupgudzke7 (PwC2yKVmaZBHSBC3UmgUdZ)
                margin:  EdgeInsets.fromLTRB(23.06*fem, 0*fem, 0*fem, 0*fem),
                width:  1255.06*fem,
                height:  644*fem,
                child:
                Stack(
                  children:  [
                    Positioned(
                      // buttonsij (11:175)
                      left:  840.578125*fem,
                      top:  536*fem,
                      child:
                      TextButton(
                        onPressed:  () {},
                        style:  TextButton.styleFrom (
                          padding:  EdgeInsets.zero,
                        ),
                        child:
                        Container(
                          padding:  EdgeInsets.fromLTRB(34*fem, 8*fem, 34*fem, 8*fem),
                          width:  274*fem,
                          height:  94*fem,
                          decoration:  BoxDecoration (
                            color:  Color(0xff246eb9),
                            borderRadius:  BorderRadius.circular(20*fem),
                          ),
                          child:
                          Container(
                            // autogroupwoa3hSs (PwC36u7UQKAQRkDEVHWoA3)
                            margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 15*fem),
                            padding:  EdgeInsets.fromLTRB(0*fem, 15*fem, 0*fem, 0*fem),
                            width:  double.infinity,
                            height:  63*fem,
                            child:
                            Text(
                              'Explore more',
                              style: GoogleFonts.inter(
                                fontSize: 20 * fem,
                                fontWeight: FontWeight.w400,
                                height: 1.5 * fem / fem,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // loremipsumdolorsitametconsecte (11:179)
                      left:  700.0625*fem,
                      top:  0*fem,
                      child:
                      Align(
                        child:
                        SizedBox(
                          width:  555*fem,
                          height:  480*fem,
                          child:
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ',
                            style: GoogleFonts.inter(
                              fontSize: 20 * fem,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * fem / fem,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
    }
}
